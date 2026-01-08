import type { NextApiRequest, NextApiResponse } from 'next';
import { supabase } from '@/lib/supabase';

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  const { postId } = req.query;

  if (req.method === 'GET') {
    try {
      const { data: reactions, error } = await supabase
        .from('reactions')
        .select('reaction_type, count')
        .eq('post_id', postId);

      if (error) throw error;

      // リアクションをタイプごとに集計
      const reactionCounts: Record<string, number> = {
        like: 0,
        laugh: 0,
        think: 0,
        sad: 0,
        fire: 0,
      };

      reactions?.forEach((reaction) => {
        if (reaction.reaction_type in reactionCounts) {
          reactionCounts[reaction.reaction_type] = reaction.count || 0;
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

      // 既存のリアクションを確認
      const { data: existing, error: selectError } = await supabase
        .from('reactions')
        .select('count')
        .eq('post_id', Number(postId))
        .eq('reaction_type', reactionType)
        .single();

      if (selectError && selectError.code !== 'PGRST116') {
        // PGRST116 = no rows returned (new reaction)
        throw selectError;
      }

      if (existing) {
        // 既存のリアクションがあればcountを増やす
        const { error: updateError } = await supabase
          .from('reactions')
          .update({ count: (existing.count || 0) + 1 })
          .eq('post_id', Number(postId))
          .eq('reaction_type', reactionType);

        if (updateError) throw updateError;
      } else {
        // 新しいリアクションを追加
        const { error: insertError } = await supabase
          .from('reactions')
          .insert({
            post_id: Number(postId),
            reaction_type: reactionType,
            count: 1,
          });

        if (insertError) throw insertError;
      }

      res.status(200).json({ success: true });
    } catch (error) {
      console.error('Error adding reaction:', error);
      res.status(500).json({ error: 'Failed to add reaction' });
    }
  } else {
    res.status(405).json({ error: 'Method not allowed' });
  }
}
