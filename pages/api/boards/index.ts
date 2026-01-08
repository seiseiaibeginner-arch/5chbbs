import type { NextApiRequest, NextApiResponse } from 'next';
import { supabase } from '@/lib/supabase';

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  if (req.method === 'GET') {
    try {
      // 板一覧を取得
      const { data: boards, error } = await supabase
        .from('boards')
        .select('*');

      if (error) throw error;

      // 各板のスレッド数と最終更新を取得
      const boardsWithStats = await Promise.all(
        boards.map(async (board) => {
          const { count } = await supabase
            .from('threads')
            .select('*', { count: 'exact', head: true })
            .eq('board_id', board.id)
            .eq('status', 'active');

          const { data: lastThread } = await supabase
            .from('threads')
            .select('last_posted_at')
            .eq('board_id', board.id)
            .eq('status', 'active')
            .order('last_posted_at', { ascending: false })
            .limit(1)
            .single();

          return {
            ...board,
            thread_count: count || 0,
            last_updated: lastThread?.last_posted_at || null,
          };
        })
      );

      // 最終投稿日時でソート（新しい順、投稿がない板は後ろ）
      boardsWithStats.sort((a, b) => {
        // 投稿がない板は後ろ
        if (!a.last_updated && !b.last_updated) return 0;
        if (!a.last_updated) return 1;
        if (!b.last_updated) return -1;
        // 新しい順
        return new Date(b.last_updated).getTime() - new Date(a.last_updated).getTime();
      });

      res.status(200).json(boardsWithStats);
    } catch (error) {
      console.error('Error fetching boards:', error);
      res.status(500).json({ error: 'Failed to fetch boards' });
    }
  } else {
    res.status(405).json({ error: 'Method not allowed' });
  }
}
