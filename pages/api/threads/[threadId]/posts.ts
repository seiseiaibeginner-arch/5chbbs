import type { NextApiRequest, NextApiResponse } from 'next';
import { supabase } from '@/lib/supabase';
import { generatePosterId } from '@/lib/utils';

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  const { threadId } = req.query;

  if (req.method === 'GET') {
    try {
      const page = parseInt(req.query.page as string) || 1;
      const limit = 100;
      const offset = (page - 1) * limit;

      const { data: posts, error } = await supabase
        .from('posts')
        .select('*')
        .eq('thread_id', threadId)
        .order('post_number', { ascending: true })
        .range(offset, offset + limit - 1);

      if (error) throw error;

      const { count } = await supabase
        .from('posts')
        .select('*', { count: 'exact', head: true })
        .eq('thread_id', threadId);

      res.status(200).json({
        posts: posts || [],
        total: count || 0,
        page,
        totalPages: Math.ceil((count || 0) / limit)
      });
    } catch (error) {
      console.error('Error fetching posts:', error);
      res.status(500).json({ error: 'Failed to fetch posts' });
    }
  } else if (req.method === 'POST') {
    try {
      const { name, email, content } = req.body;

      // バリデーション
      if (!content) {
        return res.status(400).json({ error: '本文は必須です' });
      }

      if (content.length > 1000) {
        return res.status(400).json({ error: '本文は1000文字以内で入力してください' });
      }

      // スレッドの存在確認
      const { data: thread, error: threadError } = await supabase
        .from('threads')
        .select('*')
        .eq('id', threadId)
        .single();

      if (threadError || !thread) {
        return res.status(404).json({ error: 'スレッドが見つかりません' });
      }

      // スレッドがdat落ちしていないか確認
      if (thread.post_count >= 1000 || thread.status !== 'active') {
        return res.status(400).json({ error: 'このスレッドは書き込みできません' });
      }

      // IPアドレス取得
      const ip = (req.headers['x-forwarded-for'] as string)?.split(',')[0] || 
                 req.socket.remoteAddress || 
                 '127.0.0.1';
      
      const posterId = generatePosterId(ip);

      // 現在のレス数を取得
      const { data: lastPost } = await supabase
        .from('posts')
        .select('post_number')
        .eq('thread_id', threadId)
        .order('post_number', { ascending: false })
        .limit(1)
        .single();

      const nextPostNumber = (lastPost?.post_number || 0) + 1;

      // レスを作成
      const { error: postError } = await supabase
        .from('posts')
        .insert({
          thread_id: Number(threadId),
          post_number: nextPostNumber,
          name: name || '名無しさん',
          email: email || null,
          content,
          poster_id: posterId,
        });

      if (postError) throw postError;

      // スレッドの情報を更新
      const isSage = email?.toLowerCase() === 'sage';
      const updateData: Record<string, any> = {
        post_count: thread.post_count + 1,
      };

      if (!isSage) {
        updateData.last_posted_at = new Date().toISOString();
      }

      // 1000レス達したらdat落ち
      if (nextPostNumber >= 1000) {
        updateData.status = 'archived';
      }

      await supabase
        .from('threads')
        .update(updateData)
        .eq('id', threadId);

      res.status(201).json({ postNumber: nextPostNumber, message: 'レスを投稿しました' });
    } catch (error) {
      console.error('Error creating post:', error);
      res.status(500).json({ error: 'レスの投稿に失敗しました' });
    }
  } else {
    res.status(405).json({ error: 'Method not allowed' });
  }
}
