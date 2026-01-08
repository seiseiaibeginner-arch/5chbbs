import type { NextApiRequest, NextApiResponse } from 'next';
import { supabase } from '@/lib/supabase';

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  const { threadId } = req.query;

  if (req.method === 'GET') {
    try {
      const { data: thread, error } = await supabase
        .from('threads')
        .select('*')
        .eq('id', threadId)
        .single();

      if (error || !thread) {
        return res.status(404).json({ error: 'Thread not found' });
      }

      res.status(200).json(thread);
    } catch (error) {
      console.error('Error fetching thread:', error);
      res.status(500).json({ error: 'Failed to fetch thread' });
    }
  } else {
    res.status(405).json({ error: 'Method not allowed' });
  }
}
