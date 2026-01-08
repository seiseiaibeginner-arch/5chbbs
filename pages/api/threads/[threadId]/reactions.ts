import type { NextApiRequest, NextApiResponse } from 'next';
import { supabase } from '@/lib/supabase';

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  const { threadId } = req.query;

  if (req.method === 'GET') {
    try {
      // スレッド内の全投稿を取得
      const { data: posts, error: postsError } = await supabase
        .from('posts')
        .select('id')
        .eq('thread_id', threadId);

      if (postsError) throw postsError;

      const postIds = posts?.map(p => p.id) || [];

      // リアクションを取得
      const { data: reactions, error: reactionsError } = await supabase
        .from('reactions')
        .select('post_id, reaction_type, count')
        .in('post_id', postIds.length > 0 ? postIds : [0]);

      if (reactionsError) throw reactionsError;

      // 投稿IDごとにリアクションをグループ化
      const reactionsByPost: Record<number, Record<string, number>> = {};
      
      postIds.forEach(postId => {
        reactionsByPost[postId] = {
          like: 0,
          laugh: 0,
          think: 0,
          sad: 0,
          fire: 0
        };
      });

      reactions?.forEach((r) => {
        if (reactionsByPost[r.post_id]) {
          reactionsByPost[r.post_id][r.reaction_type] = r.count;
        }
      });

      res.status(200).json(reactionsByPost);
    } catch (error) {
      console.error('Error fetching reactions:', error);
      res.status(500).json({ error: 'Failed to fetch reactions' });
    }
  } else {
    res.status(405).json({ error: 'Method not allowed' });
  }
}
