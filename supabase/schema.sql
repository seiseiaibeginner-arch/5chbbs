-- =============================================
-- 5chBBS Supabase Schema
-- =============================================
-- このSQLをSupabaseのSQL Editorで実行してテーブルを作成してください

-- 板テーブル
CREATE TABLE IF NOT EXISTS boards (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  description TEXT NOT NULL,
  category TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- スレッドテーブル
CREATE TABLE IF NOT EXISTS threads (
  id SERIAL PRIMARY KEY,
  board_id INTEGER NOT NULL REFERENCES boards(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  post_count INTEGER DEFAULT 1,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  last_posted_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  status TEXT DEFAULT 'active'
);

-- レステーブル
CREATE TABLE IF NOT EXISTS posts (
  id SERIAL PRIMARY KEY,
  thread_id INTEGER NOT NULL REFERENCES threads(id) ON DELETE CASCADE,
  post_number INTEGER NOT NULL,
  name TEXT DEFAULT '名無しさん',
  email TEXT,
  posted_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  poster_id TEXT NOT NULL,
  content TEXT NOT NULL,
  is_deleted BOOLEAN DEFAULT FALSE
);

-- リアクションテーブル
CREATE TABLE IF NOT EXISTS reactions (
  id SERIAL PRIMARY KEY,
  post_id INTEGER NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
  reaction_type TEXT NOT NULL,
  count INTEGER DEFAULT 0,
  UNIQUE(post_id, reaction_type)
);

-- インデックス作成
CREATE INDEX IF NOT EXISTS idx_threads_board_id ON threads(board_id);
CREATE INDEX IF NOT EXISTS idx_threads_last_posted ON threads(last_posted_at DESC);
CREATE INDEX IF NOT EXISTS idx_posts_thread_id ON posts(thread_id);
CREATE INDEX IF NOT EXISTS idx_posts_post_number ON posts(thread_id, post_number);
CREATE INDEX IF NOT EXISTS idx_reactions_post_id ON reactions(post_id);

-- RLS (Row Level Security) を無効化（匿名掲示板のため全員がアクセス可能）
ALTER TABLE boards ENABLE ROW LEVEL SECURITY;
ALTER TABLE threads ENABLE ROW LEVEL SECURITY;
ALTER TABLE posts ENABLE ROW LEVEL SECURITY;
ALTER TABLE reactions ENABLE ROW LEVEL SECURITY;

-- 全員が読み書きできるポリシーを作成
CREATE POLICY "Allow all access to boards" ON boards FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all access to threads" ON threads FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all access to posts" ON posts FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all access to reactions" ON reactions FOR ALL USING (true) WITH CHECK (true);

-- =============================================
-- 初期データ投入
-- =============================================

-- 板の初期データ
INSERT INTO boards (name, description, category) VALUES
  ('ニュース速報', '最新ニュースについて語りましょう', 'ニュース'),
  ('芸能ニュース', '芸能・エンタメの話題', 'ニュース'),
  ('国際ニュース', '世界の出来事を語る', 'ニュース'),
  ('プログラミング', 'プログラミング全般の話題', '技術'),
  ('Web開発', 'フロントエンド・バックエンドの話題', '技術'),
  ('AI・機械学習', 'AI技術について語る', '技術'),
  ('アニメ', 'アニメについて語るスレ', '趣味'),
  ('ゲーム', 'ゲームの話題全般', '趣味'),
  ('音楽', '音楽全般の話題', '趣味'),
  ('料理', '料理のレシピや食べ物の話題', '生活'),
  ('健康', '健康・フィットネスの話題', '生活'),
  ('旅行', '旅行・観光の話題', '生活'),
  ('雑談', 'なんでもありの雑談板', 'その他'),
  ('質問', '質問・相談全般', 'その他'),
  ('創作', '創作活動の話題', 'その他')
ON CONFLICT (name) DO NOTHING;

-- サンプルスレッドとレスの投入
DO $$
DECLARE
  board_record RECORD;
  thread_id INTEGER;
BEGIN
  -- プログラミング板にサンプルスレッド
  SELECT id INTO board_record FROM boards WHERE name = 'プログラミング';
  IF board_record.id IS NOT NULL THEN
    INSERT INTO threads (board_id, title, post_count, last_posted_at)
    VALUES (board_record.id, 'プログラミング初心者の質問スレ Part1', 3, NOW())
    RETURNING id INTO thread_id;
    
    INSERT INTO posts (thread_id, post_number, name, poster_id, content) VALUES
      (thread_id, 1, '1', 'ABC12345', 'プログラミング初心者の質問スレです

質問する前にググりましょう
エラーメッセージは全文貼りましょう'),
      (thread_id, 2, '名無しさん', 'DEF67890', '>>1
Pythonから始めるのがいいですか？'),
      (thread_id, 3, '名無しさん', 'GHI11111', '>>2
目的による
Web系ならJavaScript、データ分析ならPythonがおすすめ');
  END IF;

  -- 雑談板にサンプルスレッド
  SELECT id INTO board_record FROM boards WHERE name = '雑談';
  IF board_record.id IS NOT NULL THEN
    INSERT INTO threads (board_id, title, post_count, last_posted_at)
    VALUES (board_record.id, '暇だから誰か構ってくれ', 4, NOW())
    RETURNING id INTO thread_id;
    
    INSERT INTO posts (thread_id, post_number, name, poster_id, content) VALUES
      (thread_id, 1, '名無しさん', 'JKL22222', '暇すぎて死にそう
誰か話そう'),
      (thread_id, 2, '名無しさん', 'MNO33333', '何の話する？'),
      (thread_id, 3, '名無しさん', 'JKL22222', '>>2
何でもいい
最近あった面白いこととか'),
      (thread_id, 4, '名無しさん', 'PQR44444', '今日スーパーで知らない子供に手振られた');
  END IF;

  -- アニメ板にサンプルスレッド
  SELECT id INTO board_record FROM boards WHERE name = 'アニメ';
  IF board_record.id IS NOT NULL THEN
    INSERT INTO threads (board_id, title, post_count, last_posted_at)
    VALUES (board_record.id, '2026年冬アニメ総合スレ', 3, NOW())
    RETURNING id INTO thread_id;
    
    INSERT INTO posts (thread_id, post_number, name, poster_id, content) VALUES
      (thread_id, 1, '名無しさん', 'STU55555', '2026年冬アニメについて語ろう

今期の注目作は？'),
      (thread_id, 2, '名無しさん', 'VWX66666', '○○の2期が楽しみすぎる'),
      (thread_id, 3, '名無しさん', 'YZA77777', '>>2
分かる
1期の終わり方が良かったから期待してる');
  END IF;
END $$;
