-- =============================================
-- 初期データ投入（テーブル作成後に実行）
-- =============================================

-- 既存データをクリア（必要に応じて）
TRUNCATE TABLE reactions CASCADE;
TRUNCATE TABLE posts CASCADE;
TRUNCATE TABLE threads CASCADE;
TRUNCATE TABLE boards CASCADE;

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
  ('創作', '創作活動の話題', 'その他');

-- プログラミング板にサンプルスレッド
INSERT INTO threads (board_id, title, post_count, last_posted_at)
VALUES (
  (SELECT id FROM boards WHERE name = 'プログラミング'),
  'プログラミング初心者の質問スレ Part1',
  3,
  NOW()
);

INSERT INTO posts (thread_id, post_number, name, poster_id, content)
SELECT 
  t.id,
  1,
  '1',
  'ABC12345',
  'プログラミング初心者の質問スレです

質問する前にググりましょう
エラーメッセージは全文貼りましょう'
FROM threads t WHERE t.title = 'プログラミング初心者の質問スレ Part1';

INSERT INTO posts (thread_id, post_number, name, poster_id, content)
SELECT 
  t.id,
  2,
  '名無しさん',
  'DEF67890',
  '>>1
Pythonから始めるのがいいですか？'
FROM threads t WHERE t.title = 'プログラミング初心者の質問スレ Part1';

INSERT INTO posts (thread_id, post_number, name, poster_id, content)
SELECT 
  t.id,
  3,
  '名無しさん',
  'GHI11111',
  '>>2
目的による
Web系ならJavaScript、データ分析ならPythonがおすすめ'
FROM threads t WHERE t.title = 'プログラミング初心者の質問スレ Part1';

-- 雑談板にサンプルスレッド
INSERT INTO threads (board_id, title, post_count, last_posted_at)
VALUES (
  (SELECT id FROM boards WHERE name = '雑談'),
  '暇だから誰か構ってくれ',
  4,
  NOW()
);

INSERT INTO posts (thread_id, post_number, name, poster_id, content)
SELECT 
  t.id,
  1,
  '名無しさん',
  'JKL22222',
  '暇すぎて死にそう
誰か話そう'
FROM threads t WHERE t.title = '暇だから誰か構ってくれ';

INSERT INTO posts (thread_id, post_number, name, poster_id, content)
SELECT 
  t.id,
  2,
  '名無しさん',
  'MNO33333',
  '何の話する？'
FROM threads t WHERE t.title = '暇だから誰か構ってくれ';

INSERT INTO posts (thread_id, post_number, name, poster_id, content)
SELECT 
  t.id,
  3,
  '名無しさん',
  'JKL22222',
  '>>2
何でもいい
最近あった面白いこととか'
FROM threads t WHERE t.title = '暇だから誰か構ってくれ';

INSERT INTO posts (thread_id, post_number, name, poster_id, content)
SELECT 
  t.id,
  4,
  '名無しさん',
  'PQR44444',
  '今日スーパーで知らない子供に手振られた'
FROM threads t WHERE t.title = '暇だから誰か構ってくれ';

-- アニメ板にサンプルスレッド
INSERT INTO threads (board_id, title, post_count, last_posted_at)
VALUES (
  (SELECT id FROM boards WHERE name = 'アニメ'),
  '2026年冬アニメ総合スレ',
  3,
  NOW()
);

INSERT INTO posts (thread_id, post_number, name, poster_id, content)
SELECT 
  t.id,
  1,
  '名無しさん',
  'STU55555',
  '2026年冬アニメについて語ろう

今期の注目作は？'
FROM threads t WHERE t.title = '2026年冬アニメ総合スレ';

INSERT INTO posts (thread_id, post_number, name, poster_id, content)
SELECT 
  t.id,
  2,
  '名無しさん',
  'VWX66666',
  '○○の2期が楽しみすぎる'
FROM threads t WHERE t.title = '2026年冬アニメ総合スレ';

INSERT INTO posts (thread_id, post_number, name, poster_id, content)
SELECT 
  t.id,
  3,
  '名無しさん',
  'YZA77777',
  '>>2
分かる
1期の終わり方が良かったから期待してる'
FROM threads t WHERE t.title = '2026年冬アニメ総合スレ';

-- 完了メッセージ
SELECT 'データ投入完了！' as message;
SELECT COUNT(*) as board_count FROM boards;
SELECT COUNT(*) as thread_count FROM threads;
SELECT COUNT(*) as post_count FROM posts;
