-- =============================================
-- 追加ダミーデータ投入
-- =============================================

-- ニュース速報板
INSERT INTO threads (board_id, title, post_count, last_posted_at)
VALUES (
  (SELECT id FROM boards WHERE name = 'ニュース速報'),
  '【速報】2026年の注目ニュースを語るスレ',
  5,
  NOW() - INTERVAL '1 hour'
);

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 1, '名無しさん', 'NEWS1234', '2026年も色々ありそうだな
みんなの予想を聞かせてくれ', NOW() - INTERVAL '5 hours'
FROM threads t WHERE t.title = '【速報】2026年の注目ニュースを語るスレ';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 2, '名無しさん', 'NEWS5678', '>>1
AI関連のニュースが増えそう', NOW() - INTERVAL '4 hours'
FROM threads t WHERE t.title = '【速報】2026年の注目ニュースを語るスレ';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 3, '名無しさん', 'NEWS9ABC', '宇宙開発も進みそうだよな', NOW() - INTERVAL '3 hours'
FROM threads t WHERE t.title = '【速報】2026年の注目ニュースを語るスレ';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 4, '名無しさん', 'NEWS1234', '>>3
月面基地の話とかワクワクする', NOW() - INTERVAL '2 hours'
FROM threads t WHERE t.title = '【速報】2026年の注目ニュースを語るスレ';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 5, '名無しさん', 'NEWSDEF0', '電気自動車の普及も加速しそう', NOW() - INTERVAL '1 hour'
FROM threads t WHERE t.title = '【速報】2026年の注目ニュースを語るスレ';

-- Web開発板
INSERT INTO threads (board_id, title, post_count, last_posted_at)
VALUES (
  (SELECT id FROM boards WHERE name = 'Web開発'),
  'Next.js vs Nuxt.js どっちがいい？',
  6,
  NOW() - INTERVAL '30 minutes'
);

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 1, '名無しさん', 'WEB11111', 'フロントエンドフレームワーク選びで悩んでる
Next.jsとNuxt.jsどっちがおすすめ？', NOW() - INTERVAL '6 hours'
FROM threads t WHERE t.title = 'Next.js vs Nuxt.js どっちがいい？';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 2, '名無しさん', 'WEB22222', '>>1
React好きならNext.js
Vue好きならNuxt.js
これが答え', NOW() - INTERVAL '5 hours'
FROM threads t WHERE t.title = 'Next.js vs Nuxt.js どっちがいい？';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 3, '名無しさん', 'WEB33333', 'エコシステムの大きさで言えばNext.jsの方が有利かな', NOW() - INTERVAL '4 hours'
FROM threads t WHERE t.title = 'Next.js vs Nuxt.js どっちがいい？';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 4, '名無しさん', 'WEB44444', 'Nuxt3からかなり良くなったけどね
TypeScriptとの相性も改善された', NOW() - INTERVAL '3 hours'
FROM threads t WHERE t.title = 'Next.js vs Nuxt.js どっちがいい？';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 5, '名無しさん', 'WEB11111', '>>2-4
ありがとう！参考になる
Reactの経験があるからNext.jsにしてみる', NOW() - INTERVAL '1 hour'
FROM threads t WHERE t.title = 'Next.js vs Nuxt.js どっちがいい？';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 6, '名無しさん', 'WEB55555', 'App RouterにするかPages Routerにするかも悩むポイントだよね', NOW() - INTERVAL '30 minutes'
FROM threads t WHERE t.title = 'Next.js vs Nuxt.js どっちがいい？';

-- Web開発板2
INSERT INTO threads (board_id, title, post_count, last_posted_at)
VALUES (
  (SELECT id FROM boards WHERE name = 'Web開発'),
  'Tailwind CSS使ってる人いる？',
  4,
  NOW() - INTERVAL '2 hours'
);

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 1, '名無しさん', 'TAIL1111', 'Tailwind CSS最高すぎない？
もうCSS手書きには戻れない', NOW() - INTERVAL '8 hours'
FROM threads t WHERE t.title = 'Tailwind CSS使ってる人いる？';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 2, '名無しさん', 'TAIL2222', '>>1
分かる
特にshadcn/uiと組み合わせると最強', NOW() - INTERVAL '6 hours'
FROM threads t WHERE t.title = 'Tailwind CSS使ってる人いる？';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 3, '名無しさん', 'TAIL3333', 'クラス名が長くなるのがちょっと...', NOW() - INTERVAL '4 hours'
FROM threads t WHERE t.title = 'Tailwind CSS使ってる人いる？';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 4, '名無しさん', 'TAIL1111', '>>3
慣れると気にならなくなるよ
@applyで共通化もできるし', NOW() - INTERVAL '2 hours'
FROM threads t WHERE t.title = 'Tailwind CSS使ってる人いる？';

-- ゲーム板
INSERT INTO threads (board_id, title, post_count, last_posted_at)
VALUES (
  (SELECT id FROM boards WHERE name = 'ゲーム'),
  '最近やってるゲーム教えて',
  7,
  NOW() - INTERVAL '15 minutes'
);

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 1, '名無しさん', 'GAME1111', '最近何やってる？
おすすめあったら教えて', NOW() - INTERVAL '10 hours'
FROM threads t WHERE t.title = '最近やってるゲーム教えて';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 2, '名無しさん', 'GAME2222', 'エルデンリングのDLCやってる
めっちゃ難しい', NOW() - INTERVAL '8 hours'
FROM threads t WHERE t.title = '最近やってるゲーム教えて';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 3, '名無しさん', 'GAME3333', '>>2
あれマジで鬼畜だよな
何回死んだか分からん', NOW() - INTERVAL '6 hours'
FROM threads t WHERE t.title = '最近やってるゲーム教えて';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 4, '名無しさん', 'GAME4444', 'パルワールドまだやってる人いる？', NOW() - INTERVAL '4 hours'
FROM threads t WHERE t.title = '最近やってるゲーム教えて';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 5, '名無しさん', 'GAME5555', 'スイカゲームがシンプルで好き', NOW() - INTERVAL '2 hours'
FROM threads t WHERE t.title = '最近やってるゲーム教えて';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 6, '名無しさん', 'GAME1111', 'みんな色々やってるんだな
参考になる', NOW() - INTERVAL '1 hour'
FROM threads t WHERE t.title = '最近やってるゲーム教えて';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 7, '名無しさん', 'GAME6666', 'インディーゲームだけどHadesおすすめ
ローグライクの傑作', NOW() - INTERVAL '15 minutes'
FROM threads t WHERE t.title = '最近やってるゲーム教えて';

-- ゲーム板2
INSERT INTO threads (board_id, title, post_count, last_posted_at)
VALUES (
  (SELECT id FROM boards WHERE name = 'ゲーム'),
  'PS5 vs Xbox どっち買う？',
  5,
  NOW() - INTERVAL '3 hours'
);

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 1, '名無しさん', 'CONS1111', '次世代機で迷ってる
どっちがいい？', NOW() - INTERVAL '12 hours'
FROM threads t WHERE t.title = 'PS5 vs Xbox どっち買う？';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 2, '名無しさん', 'CONS2222', '>>1
独占タイトル次第じゃない？
FF好きならPS5一択', NOW() - INTERVAL '10 hours'
FROM threads t WHERE t.title = 'PS5 vs Xbox どっち買う？';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 3, '名無しさん', 'CONS3333', 'Game Passがあるからコスパ的にはXboxかな', NOW() - INTERVAL '8 hours'
FROM threads t WHERE t.title = 'PS5 vs Xbox どっち買う？';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 4, '名無しさん', 'CONS4444', 'PC持ってるならXbox独占はほぼPCでできるからPS5でいいんじゃね', NOW() - INTERVAL '5 hours'
FROM threads t WHERE t.title = 'PS5 vs Xbox どっち買う？';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 5, '名無しさん', 'CONS1111', '>>4
なるほど、その発想はなかった
PS5にするわ', NOW() - INTERVAL '3 hours'
FROM threads t WHERE t.title = 'PS5 vs Xbox どっち買う？';

-- AI・機械学習板
INSERT INTO threads (board_id, title, post_count, last_posted_at)
VALUES (
  (SELECT id FROM boards WHERE name = 'AI・機械学習'),
  'ChatGPT vs Claude どっちが賢い？',
  6,
  NOW() - INTERVAL '10 minutes'
);

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 1, '名無しさん', 'AI111111', 'LLMの比較スレ立てた
みんなはどっち派？', NOW() - INTERVAL '5 hours'
FROM threads t WHERE t.title = 'ChatGPT vs Claude どっちが賢い？';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 2, '名無しさん', 'AI222222', '>>1
用途によって使い分けてる
コーディングはClaude、検索はGPT', NOW() - INTERVAL '4 hours'
FROM threads t WHERE t.title = 'ChatGPT vs Claude どっちが賢い？';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 3, '名無しさん', 'AI333333', 'Claudeの方が長文の理解力高い気がする', NOW() - INTERVAL '3 hours'
FROM threads t WHERE t.title = 'ChatGPT vs Claude どっちが賢い？';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 4, '名無しさん', 'AI444444', 'GPT-4oのマルチモーダルは便利だよね', NOW() - INTERVAL '2 hours'
FROM threads t WHERE t.title = 'ChatGPT vs Claude どっちが賢い？';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 5, '名無しさん', 'AI555555', 'ローカルLLMも侮れないぞ
Llama3とか結構使える', NOW() - INTERVAL '1 hour'
FROM threads t WHERE t.title = 'ChatGPT vs Claude どっちが賢い？';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 6, '名無しさん', 'AI111111', '>>5
ローカルLLMはプライバシー的にも良いよな
ハードの壁が高いけど', NOW() - INTERVAL '10 minutes'
FROM threads t WHERE t.title = 'ChatGPT vs Claude どっちが賢い？';

-- 料理板
INSERT INTO threads (board_id, title, post_count, last_posted_at)
VALUES (
  (SELECT id FROM boards WHERE name = '料理'),
  '一人暮らしの簡単レシピ教えて',
  5,
  NOW() - INTERVAL '45 minutes'
);

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 1, '名無しさん', 'COOK1111', '一人暮らし始めたんだけど
簡単に作れるレシピ教えて', NOW() - INTERVAL '8 hours'
FROM threads t WHERE t.title = '一人暮らしの簡単レシピ教えて';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 2, '名無しさん', 'COOK2222', '>>1
卵かけご飯は最強
醤油とごま油で無限に食える', NOW() - INTERVAL '6 hours'
FROM threads t WHERE t.title = '一人暮らしの簡単レシピ教えて';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 3, '名無しさん', 'COOK3333', 'レンジでパスタ茹でる容器買え
マジで便利', NOW() - INTERVAL '4 hours'
FROM threads t WHERE t.title = '一人暮らしの簡単レシピ教えて';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 4, '名無しさん', 'COOK4444', '冷凍うどん+めんつゆ+卵
これで釜玉うどんの完成', NOW() - INTERVAL '2 hours'
FROM threads t WHERE t.title = '一人暮らしの簡単レシピ教えて';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 5, '名無しさん', 'COOK1111', 'みんなありがとう！
全部試してみる', NOW() - INTERVAL '45 minutes'
FROM threads t WHERE t.title = '一人暮らしの簡単レシピ教えて';

-- 音楽板
INSERT INTO threads (board_id, title, post_count, last_posted_at)
VALUES (
  (SELECT id FROM boards WHERE name = '音楽'),
  '2026年に流行りそうなアーティスト',
  4,
  NOW() - INTERVAL '1 hour'
);

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 1, '名無しさん', 'MUSI1111', '今年ブレイクしそうなアーティスト予想しようぜ', NOW() - INTERVAL '6 hours'
FROM threads t WHERE t.title = '2026年に流行りそうなアーティスト';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 2, '名無しさん', 'MUSI2222', 'VTuberの音楽活動がもっと盛り上がりそう', NOW() - INTERVAL '4 hours'
FROM threads t WHERE t.title = '2026年に流行りそうなアーティスト';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 3, '名無しさん', 'MUSI3333', 'AI作曲も増えてきそうで複雑な気持ち', NOW() - INTERVAL '2 hours'
FROM threads t WHERE t.title = '2026年に流行りそうなアーティスト';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 4, '名無しさん', 'MUSI4444', '>>3
人間のアーティストの価値は変わらないと思う
ライブとか生の体験は代替できない', NOW() - INTERVAL '1 hour'
FROM threads t WHERE t.title = '2026年に流行りそうなアーティスト';

-- 旅行板
INSERT INTO threads (board_id, title, post_count, last_posted_at)
VALUES (
  (SELECT id FROM boards WHERE name = '旅行'),
  '国内旅行のおすすめスポット',
  5,
  NOW() - INTERVAL '2 hours'
);

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 1, '名無しさん', 'TRIP1111', '週末旅行のおすすめ教えて
関東から日帰りで行けるところ希望', NOW() - INTERVAL '10 hours'
FROM threads t WHERE t.title = '国内旅行のおすすめスポット';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 2, '名無しさん', 'TRIP2222', '>>1
箱根は定番だけど温泉いいよ
ロマンスカーで1時間ちょい', NOW() - INTERVAL '8 hours'
FROM threads t WHERE t.title = '国内旅行のおすすめスポット';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 3, '名無しさん', 'TRIP3333', '鎌倉もいいぞ
食べ歩きが楽しい', NOW() - INTERVAL '6 hours'
FROM threads t WHERE t.title = '国内旅行のおすすめスポット';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 4, '名無しさん', 'TRIP4444', '日光も意外と近い
東照宮は一度は見とくべき', NOW() - INTERVAL '4 hours'
FROM threads t WHERE t.title = '国内旅行のおすすめスポット';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 5, '名無しさん', 'TRIP1111', '>>2-4
全部良さそう！
順番に制覇してく', NOW() - INTERVAL '2 hours'
FROM threads t WHERE t.title = '国内旅行のおすすめスポット';

-- 健康板
INSERT INTO threads (board_id, title, post_count, last_posted_at)
VALUES (
  (SELECT id FROM boards WHERE name = '健康'),
  '筋トレ始めたいんだが',
  5,
  NOW() - INTERVAL '4 hours'
);

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 1, '名無しさん', 'FIT11111', '運動不足解消したい
筋トレ初心者は何から始めればいい？', NOW() - INTERVAL '12 hours'
FROM threads t WHERE t.title = '筋トレ始めたいんだが';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 2, '名無しさん', 'FIT22222', '>>1
まずは自重トレから
腕立て、腹筋、スクワット', NOW() - INTERVAL '10 hours'
FROM threads t WHERE t.title = '筋トレ始めたいんだが';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 3, '名無しさん', 'FIT33333', 'YouTubeで動画見ながらやるのおすすめ
フォーム大事', NOW() - INTERVAL '8 hours'
FROM threads t WHERE t.title = '筋トレ始めたいんだが';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 4, '名無しさん', 'FIT44444', 'プロテインは飲んだ方がいい
筋肉の回復が全然違う', NOW() - INTERVAL '6 hours'
FROM threads t WHERE t.title = '筋トレ始めたいんだが';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 5, '名無しさん', 'FIT11111', 'みんなありがとう
とりあえず自重から始めてみる', NOW() - INTERVAL '4 hours'
FROM threads t WHERE t.title = '筋トレ始めたいんだが';

-- 質問板
INSERT INTO threads (board_id, title, post_count, last_posted_at)
VALUES (
  (SELECT id FROM boards WHERE name = '質問'),
  'パソコン買い替えたいんだけど',
  6,
  NOW() - INTERVAL '20 minutes'
);

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 1, '名無しさん', 'PC111111', 'パソコン買い替え検討中
予算15万くらいで何がいい？
用途は普段使い+たまに動画編集', NOW() - INTERVAL '8 hours'
FROM threads t WHERE t.title = 'パソコン買い替えたいんだけど';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 2, '名無しさん', 'PC222222', '>>1
動画編集するならメモリ16GB以上は欲しい', NOW() - INTERVAL '6 hours'
FROM threads t WHERE t.title = 'パソコン買い替えたいんだけど';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 3, '名無しさん', 'PC333333', 'M2 MacBook Airとか？
動画編集もサクサク', NOW() - INTERVAL '4 hours'
FROM threads t WHERE t.title = 'パソコン買い替えたいんだけど';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 4, '名無しさん', 'PC444444', '>>3
Windowsじゃないと困ることもあるから確認した方がいい', NOW() - INTERVAL '2 hours'
FROM threads t WHERE t.title = 'パソコン買い替えたいんだけど';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 5, '名無しさん', 'PC555555', 'ゲームもするならWindowsノートにしとけ', NOW() - INTERVAL '1 hour'
FROM threads t WHERE t.title = 'パソコン買い替えたいんだけど';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 6, '名無しさん', 'PC111111', '>>2-5
ありがとう
ゲームはしないからMac検討してみる', NOW() - INTERVAL '20 minutes'
FROM threads t WHERE t.title = 'パソコン買い替えたいんだけど';

-- 創作板
INSERT INTO threads (board_id, title, post_count, last_posted_at)
VALUES (
  (SELECT id FROM boards WHERE name = '創作'),
  '小説書いてる人いる？',
  4,
  NOW() - INTERVAL '5 hours'
);

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 1, '名無しさん', 'WRIT1111', '趣味で小説書いてるんだけど
同じような人いない？', NOW() - INTERVAL '24 hours'
FROM threads t WHERE t.title = '小説書いてる人いる？';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 2, '名無しさん', 'WRIT2222', '>>1
ノシ
なろう系書いてる', NOW() - INTERVAL '18 hours'
FROM threads t WHERE t.title = '小説書いてる人いる？';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 3, '名無しさん', 'WRIT3333', 'AIに添削してもらうと捗る
文章の改善案くれるし', NOW() - INTERVAL '12 hours'
FROM threads t WHERE t.title = '小説書いてる人いる？';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 4, '名無しさん', 'WRIT1111', '>>3
それいいな
試してみる', NOW() - INTERVAL '5 hours'
FROM threads t WHERE t.title = '小説書いてる人いる？';

-- 芸能ニュース板
INSERT INTO threads (board_id, title, post_count, last_posted_at)
VALUES (
  (SELECT id FROM boards WHERE name = '芸能ニュース'),
  '最近の推し活事情',
  4,
  NOW() - INTERVAL '6 hours'
);

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 1, '名無しさん', 'IDOL1111', '推し活楽しいけど金がやばい
みんなどのくらい使ってる？', NOW() - INTERVAL '20 hours'
FROM threads t WHERE t.title = '最近の推し活事情';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 2, '名無しさん', 'IDOL2222', '>>1
月3万くらいかな
グッズとライブで飛ぶ', NOW() - INTERVAL '16 hours'
FROM threads t WHERE t.title = '最近の推し活事情';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 3, '名無しさん', 'IDOL3333', '推しは推せるときに推せ
後悔しないために', NOW() - INTERVAL '10 hours'
FROM threads t WHERE t.title = '最近の推し活事情';

INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 4, '名無しさん', 'IDOL1111', '>>3
名言だな...', NOW() - INTERVAL '6 hours'
FROM threads t WHERE t.title = '最近の推し活事情';

-- リアクションのダミーデータ
INSERT INTO reactions (post_id, reaction_type, count)
SELECT p.id, 'like', FLOOR(RANDOM() * 10 + 1)::int
FROM posts p
WHERE p.post_number = 1
ON CONFLICT (post_id, reaction_type) DO UPDATE SET count = EXCLUDED.count;

INSERT INTO reactions (post_id, reaction_type, count)
SELECT p.id, 'laugh', FLOOR(RANDOM() * 5 + 1)::int
FROM posts p
WHERE p.content LIKE '%www%' OR p.content LIKE '%ｗｗｗ%' OR RANDOM() < 0.3
ON CONFLICT (post_id, reaction_type) DO UPDATE SET count = EXCLUDED.count;

INSERT INTO reactions (post_id, reaction_type, count)
SELECT p.id, 'think', FLOOR(RANDOM() * 5 + 1)::int
FROM posts p
WHERE p.content LIKE '%？%' OR p.content LIKE '%なるほど%' OR RANDOM() < 0.2
ON CONFLICT (post_id, reaction_type) DO UPDATE SET count = EXCLUDED.count;

INSERT INTO reactions (post_id, reaction_type, count)
SELECT p.id, 'fire', FLOOR(RANDOM() * 3 + 1)::int
FROM posts p
WHERE RANDOM() < 0.15
ON CONFLICT (post_id, reaction_type) DO UPDATE SET count = EXCLUDED.count;

-- 完了メッセージ
SELECT 'ダミーデータ追加完了！' as message;
SELECT COUNT(*) as total_threads FROM threads;
SELECT COUNT(*) as total_posts FROM posts;
SELECT COUNT(*) as total_reactions FROM reactions;
