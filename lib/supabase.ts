import { createClient } from '@supabase/supabase-js';

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!;
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!;

export const supabase = createClient(supabaseUrl, supabaseAnonKey);

// 型定義
export interface Board {
  id: number;
  name: string;
  description: string;
  category: string;
  created_at: string;
}

export interface Thread {
  id: number;
  board_id: number;
  title: string;
  post_count: number;
  created_at: string;
  last_posted_at: string;
  status: string;
}

export interface Post {
  id: number;
  thread_id: number;
  post_number: number;
  name: string;
  email: string | null;
  posted_at: string;
  poster_id: string;
  content: string;
  is_deleted: boolean;
}

export interface Reaction {
  id: number;
  post_id: number;
  reaction_type: string;
  count: number;
}
