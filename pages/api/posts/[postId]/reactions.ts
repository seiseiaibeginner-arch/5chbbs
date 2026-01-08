import type { NextApiRequest, NextApiResponse } from 'next';
import { supabase } from '@/lib/supabase';

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  const { postId } = req.query;

  if (req.method === 'GET') {
    try {
      const { data: reactions, error } = await supabase
        .from('reactions')
        .select('*')
        .eq('post_id', postId);

      if (error) throw error;

      // リアクションをタイプごとに集計
      const reactionCounts = {
        like: 0,
        laugh: 0,
        think: 0,
        sad: 0,
        fire: 0,
      };

      reactions.forEach((reaction) => {
        if (reaction.reaction_type in reactionCounts) {
          reactionCounts[reaction.reaction_type as keyof typeof reactionCounts]++;
        }
      });

      res.status(200).json(reactionCounts);
    } catch (error) {
      console.error('Error fetching reactions:', error);
      res.status(500).json({ error: 'Failed to fetch reactions' });
    }
  } else if (req.method === 'POST') {
    try {
      const { reactionType } = req.body;

      if (!reactionType || !['like', 'laugh', 'think', 'sad', 'fire'].includes(reactionType)) {
        return res.status(400).json({ error: 'Invalid reaction type' });
      }

      const { error } = await supabase
        .from('reactions')
        .insert({
          post_id: Number(postId),
          reaction_type: reactionType,
        });

      if (error) throw error;

      res.status(200).json({ success: true });
    } catch (error) {
      console.error('Error adding reaction:', error);
      res.status(500).json({ error: 'Failed to add reaction' });
    }
  } else {
    res.status(405).json({ error: 'Method not allowed' });
  }
}
