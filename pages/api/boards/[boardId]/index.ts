import type { NextApiRequest, NextApiResponse } from 'next';
import { supabase } from '@/lib/supabase';

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  const { boardId } = req.query;

  if (req.method === 'GET') {
    try {
      const { data: board, error } = await supabase
        .from('boards')
        .select('*')
        .eq('id', boardId)
        .single();

      if (error || !board) {
        return res.status(404).json({ error: 'Board not found' });
      }

      res.status(200).json(board);
    } catch (error) {
      console.error('Error fetching board:', error);
      res.status(500).json({ error: 'Failed to fetch board' });
    }
  } else {
    res.status(405).json({ error: 'Method not allowed' });
  }
}
