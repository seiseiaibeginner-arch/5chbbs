import type { NextApiRequest, NextApiResponse } from 'next';
import { supabase } from '@/lib/supabase';
import { generatePosterId } from '@/lib/utils';

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  const { boardId } = req.query;

  if (req.method === 'GET') {
    try {
      const page = parseInt(req.query.page as string) || 1;
      const limit = 50;
      const offset = (page - 1) * limit;
      const sort = req.query.sort as string || 'last_posted';

      let orderColumn = 'last_posted_at';
      if (sort === 'created') {
        orderColumn = 'created_at';
      } else if (sort === 'post_count') {
        orderColumn = 'post_count';
      }

      const { data: threads, error } = await supabase
        .from('threads')
        .select('*')
        .eq('board_id', boardId)
        .eq('status', 'active')
        .order(orderColumn, { ascending: false })
        .range(offset, offset + limit - 1);

      if (error) throw error;

      const { count } = await supabase
        .from('threads')
        .select('*', { count: 'exact', head: true })
        .eq('board_id', boardId)
        .eq('status', 'active');

      res.status(200).json({
        threads: threads || [],
        total: count || 0,
        page,
        totalPages: Math.ceil((count || 0) / limit)
      });
    } catch (error) {
      console.error('Error fetching threads:', error);
      res.status(500).json({ error: 'Failed to fetch threads' });
    }
  } else if (req.method === 'POST') {
    try {
      const { title, name, content } = req.body;

      // バリデーション
      if (!title || !content) {
        return res.status(400).json({ error: 'タイトルと本文は必須です' });
      }

      if (title.length > 100) {
        return res.status(400).json({ error: 'タイトルは100文字以内で入力してください' });
      }

      if (content.length > 1000) {
        return res.status(400).json({ error: '本文は1000文字以内で入力してください' });
      }

      // 重複チェック
      const { data: existingThread } = await supabase
        .from('threads')
        .select('id')
        .eq('board_id', boardId)
        .eq('title', title)
        .single();

      if (existingThread) {
        return res.status(400).json({ error: '同じタイトルのスレッドが既に存在します' });
      }

      // IPアドレス取得（簡易版）
      const ip = (req.headers['x-forwarded-for'] as string)?.split(',')[0] || 
                 req.socket.remoteAddress || 
                 '127.0.0.1';
      
      const posterId = generatePosterId(ip);

      // スレッド作成
      const { data: newThread, error: threadError } = await supabase
        .from('threads')
        .insert({
          board_id: Number(boardId),
          title,
          post_count: 1,
        })
        .select()
        .single();

      if (threadError) throw threadError;

      // 最初のレスを作成
      const { error: postError } = await supabase
        .from('posts')
        .insert({
          thread_id: newThread.id,
          post_number: 1,
          name: name || '名無しさん',
          content,
          poster_id: posterId,
        });

      if (postError) throw postError;

      res.status(201).json({ threadId: newThread.id, message: 'スレッドを作成しました' });
    } catch (error) {
      console.error('Error creating thread:', error);
      res.status(500).json({ error: 'スレッドの作成に失敗しました' });
    }
  } else {
    res.status(405).json({ error: 'Method not allowed' });
  }
}
