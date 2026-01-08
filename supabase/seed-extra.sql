-- =============================================
-- 大量ダミーデータ追加
-- =============================================

-- ニュース速報板 追加スレッド
INSERT INTO threads (board_id, title, post_count, last_posted_at) VALUES
((SELECT id FROM boards WHERE name = 'ニュース速報'), '【悲報】物価高騰が止まらない件', 8, NOW() - INTERVAL '5 minutes'),
((SELECT id FROM boards WHERE name = 'ニュース速報'), '少子化対策について真剣に考えるスレ', 6, NOW() - INTERVAL '25 minutes'),
((SELECT id FROM boards WHERE name = 'ニュース速報'), '地震速報スレ Part999', 10, NOW() - INTERVAL '8 minutes');

-- 物価高騰スレのレス
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 1, '名無しさん', 'BUKKA001', 'スーパー行くたびに値上げしててワロタ...ワロタ...', NOW() - INTERVAL '3 hours' FROM threads t WHERE t.title = '【悲報】物価高騰が止まらない件';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 2, '名無しさん', 'BUKKA002', '>>1
卵が高すぎて泣ける', NOW() - INTERVAL '2 hours 50 minutes' FROM threads t WHERE t.title = '【悲報】物価高騰が止まらない件';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 3, '名無しさん', 'BUKKA003', '給料は上がらないのにな', NOW() - INTERVAL '2 hours 40 minutes' FROM threads t WHERE t.title = '【悲報】物価高騰が止まらない件';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 4, '名無しさん', 'BUKKA001', '>>3
ほんとそれ
実質賃金下がりっぱなし', NOW() - INTERVAL '2 hours 30 minutes' FROM threads t WHERE t.title = '【悲報】物価高騰が止まらない件';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 5, '名無しさん', 'BUKKA004', '節約生活始めた
自炊最強', NOW() - INTERVAL '1 hour' FROM threads t WHERE t.title = '【悲報】物価高騰が止まらない件';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 6, '名無しさん', 'BUKKA005', '>>5
自炊しても材料高いんだよなぁ', NOW() - INTERVAL '45 minutes' FROM threads t WHERE t.title = '【悲報】物価高騰が止まらない件';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 7, '名無しさん', 'BUKKA006', 'もやし最強説', NOW() - INTERVAL '30 minutes' FROM threads t WHERE t.title = '【悲報】物価高騰が止まらない件';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 8, '名無しさん', 'BUKKA002', '>>7
もやしすら値上げしてる現実', NOW() - INTERVAL '5 minutes' FROM threads t WHERE t.title = '【悲報】物価高騰が止まらない件';

-- 少子化スレのレス
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 1, '名無しさん', 'SHOSHI01', '出生率やばすぎない？
このままだと日本終わる', NOW() - INTERVAL '4 hours' FROM threads t WHERE t.title = '少子化対策について真剣に考えるスレ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 2, '名無しさん', 'SHOSHI02', '>>1
結婚できる経済力がないんだよ', NOW() - INTERVAL '3 hours 30 minutes' FROM threads t WHERE t.title = '少子化対策について真剣に考えるスレ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 3, '名無しさん', 'SHOSHI03', '育児支援充実させないとダメだと思う', NOW() - INTERVAL '3 hours' FROM threads t WHERE t.title = '少子化対策について真剣に考えるスレ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 4, '名無しさん', 'SHOSHI04', '保育園増やしてくれ', NOW() - INTERVAL '2 hours' FROM threads t WHERE t.title = '少子化対策について真剣に考えるスレ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 5, '名無しさん', 'SHOSHI05', '>>4
保育士の給料も上げないと人手不足で回らない', NOW() - INTERVAL '1 hour' FROM threads t WHERE t.title = '少子化対策について真剣に考えるスレ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 6, '名無しさん', 'SHOSHI01', '結局お金の問題に帰結するよな', NOW() - INTERVAL '25 minutes' FROM threads t WHERE t.title = '少子化対策について真剣に考えるスレ';

-- 地震スレのレス
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 1, '名無しさん', 'JISIN001', '地震きたー', NOW() - INTERVAL '2 hours' FROM threads t WHERE t.title = '地震速報スレ Part999';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 2, '名無しさん', 'JISIN002', '東京揺れた', NOW() - INTERVAL '1 hour 58 minutes' FROM threads t WHERE t.title = '地震速報スレ Part999';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 3, '名無しさん', 'JISIN003', '神奈川も揺れた', NOW() - INTERVAL '1 hour 57 minutes' FROM threads t WHERE t.title = '地震速報スレ Part999';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 4, '名無しさん', 'JISIN004', '震度3くらい？', NOW() - INTERVAL '1 hour 55 minutes' FROM threads t WHERE t.title = '地震速報スレ Part999';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 5, '名無しさん', 'JISIN005', '>>4
NHKによると震度4らしい', NOW() - INTERVAL '1 hour 50 minutes' FROM threads t WHERE t.title = '地震速報スレ Part999';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 6, '名無しさん', 'JISIN006', '最近多くない？', NOW() - INTERVAL '1 hour 40 minutes' FROM threads t WHERE t.title = '地震速報スレ Part999';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 7, '名無しさん', 'JISIN007', '防災グッズ確認しとこ', NOW() - INTERVAL '1 hour 30 minutes' FROM threads t WHERE t.title = '地震速報スレ Part999';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 8, '名無しさん', 'JISIN001', '>>7
水と食料は常備しとくべき', NOW() - INTERVAL '1 hour' FROM threads t WHERE t.title = '地震速報スレ Part999';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 9, '名無しさん', 'JISIN008', 'モバイルバッテリーも大事', NOW() - INTERVAL '30 minutes' FROM threads t WHERE t.title = '地震速報スレ Part999';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 10, '名無しさん', 'JISIN009', '皆さん気をつけて', NOW() - INTERVAL '8 minutes' FROM threads t WHERE t.title = '地震速報スレ Part999';

-- プログラミング板 追加スレッド
INSERT INTO threads (board_id, title, post_count, last_posted_at) VALUES
((SELECT id FROM boards WHERE name = 'プログラミング'), 'Python vs JavaScript どっちを学ぶべき？', 9, NOW() - INTERVAL '12 minutes'),
((SELECT id FROM boards WHERE name = 'プログラミング'), 'Git使いこなせない奴wwwww', 7, NOW() - INTERVAL '35 minutes'),
((SELECT id FROM boards WHERE name = 'プログラミング'), '競プロやってる人集合', 6, NOW() - INTERVAL '1 hour'),
((SELECT id FROM boards WHERE name = 'プログラミング'), 'エディタ何使ってる？', 8, NOW() - INTERVAL '18 minutes');

-- Python vs JS スレのレス
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 1, '名無しさん', 'LANG0001', 'プログラミング始めたいんだけど
PythonとJavaScriptどっちがいい？', NOW() - INTERVAL '5 hours' FROM threads t WHERE t.title = 'Python vs JavaScript どっちを学ぶべき？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 2, '名無しさん', 'LANG0002', '>>1
何を作りたいかによる', NOW() - INTERVAL '4 hours 50 minutes' FROM threads t WHERE t.title = 'Python vs JavaScript どっちを学ぶべき？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 3, '名無しさん', 'LANG0003', 'Webサイト作りたいならJS
AI/データ分析ならPython', NOW() - INTERVAL '4 hours 30 minutes' FROM threads t WHERE t.title = 'Python vs JavaScript どっちを学ぶべき？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 4, '名無しさん', 'LANG0001', '>>2-3
Webアプリ作りたいです', NOW() - INTERVAL '4 hours' FROM threads t WHERE t.title = 'Python vs JavaScript どっちを学ぶべき？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 5, '名無しさん', 'LANG0004', '>>4
ならJSから始めろ
HTML/CSSも一緒に覚えられる', NOW() - INTERVAL '3 hours 30 minutes' FROM threads t WHERE t.title = 'Python vs JavaScript どっちを学ぶべき？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 6, '名無しさん', 'LANG0005', 'TypeScript学んどけ
JSの上位互換だから', NOW() - INTERVAL '2 hours' FROM threads t WHERE t.title = 'Python vs JavaScript どっちを学ぶべき？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 7, '名無しさん', 'LANG0006', '>>6
初心者にTS勧めるのは早すぎない？', NOW() - INTERVAL '1 hour 30 minutes' FROM threads t WHERE t.title = 'Python vs JavaScript どっちを学ぶべき？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 8, '名無しさん', 'LANG0005', '>>7
最初からTS学んだ方が変な癖つかなくていいと思う', NOW() - INTERVAL '45 minutes' FROM threads t WHERE t.title = 'Python vs JavaScript どっちを学ぶべき？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 9, '名無しさん', 'LANG0001', 'とりあえずJSから始めてみます
ありがとう', NOW() - INTERVAL '12 minutes' FROM threads t WHERE t.title = 'Python vs JavaScript どっちを学ぶべき？';

-- Git スレのレス
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 1, '名無しさん', 'GIT00001', 'Gitのコマンド覚えられない
みんなどうやって覚えた？', NOW() - INTERVAL '4 hours' FROM threads t WHERE t.title = 'Git使いこなせない奴wwwww';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 2, '名無しさん', 'GIT00002', '>>1
VSCodeの拡張機能使えばGUIでできるぞ', NOW() - INTERVAL '3 hours 45 minutes' FROM threads t WHERE t.title = 'Git使いこなせない奴wwwww';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 3, '名無しさん', 'GIT00003', 'git add .
git commit -m "fix"
git push
これだけ覚えとけ', NOW() - INTERVAL '3 hours 30 minutes' FROM threads t WHERE t.title = 'Git使いこなせない奴wwwww';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 4, '名無しさん', 'GIT00004', '>>3
コミットメッセージ雑すぎワロタ', NOW() - INTERVAL '3 hours' FROM threads t WHERE t.title = 'Git使いこなせない奴wwwww';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 5, '名無しさん', 'GIT00005', 'rebaseとmergeの違いが分からん', NOW() - INTERVAL '2 hours' FROM threads t WHERE t.title = 'Git使いこなせない奴wwwww';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 6, '名無しさん', 'GIT00006', '>>5
履歴を綺麗にしたいならrebase
安全にやりたいならmerge', NOW() - INTERVAL '1 hour' FROM threads t WHERE t.title = 'Git使いこなせない奴wwwww';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 7, '名無しさん', 'GIT00001', 'SourceTreeとか使えばいいのか
試してみる', NOW() - INTERVAL '35 minutes' FROM threads t WHERE t.title = 'Git使いこなせない奴wwwww';

-- 競プロスレのレス
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 1, '名無しさん', 'KYOPRO01', 'AtCoder茶色から抜け出せない
どうすればいい？', NOW() - INTERVAL '6 hours' FROM threads t WHERE t.title = '競プロやってる人集合';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 2, '名無しさん', 'KYOPRO02', '>>1
過去問解きまくれ
ABC埋めが基本', NOW() - INTERVAL '5 hours 30 minutes' FROM threads t WHERE t.title = '競プロやってる人集合';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 3, '名無しさん', 'KYOPRO03', 'アルゴリズムの勉強も大事
蟻本読んだ？', NOW() - INTERVAL '5 hours' FROM threads t WHERE t.title = '競プロやってる人集合';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 4, '名無しさん', 'KYOPRO01', '>>3
蟻本難しすぎて挫折した', NOW() - INTERVAL '4 hours' FROM threads t WHERE t.title = '競プロやってる人集合';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 5, '名無しさん', 'KYOPRO04', '>>4
けんちょん本の方が入門向けでおすすめ', NOW() - INTERVAL '2 hours' FROM threads t WHERE t.title = '競プロやってる人集合';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 6, '名無しさん', 'KYOPRO01', '>>5
ありがとう、買ってみる', NOW() - INTERVAL '1 hour' FROM threads t WHERE t.title = '競プロやってる人集合';

-- エディタスレのレス
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 1, '名無しさん', 'EDIT0001', 'みんなエディタ何使ってる？
VSCode一択？', NOW() - INTERVAL '4 hours' FROM threads t WHERE t.title = 'エディタ何使ってる？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 2, '名無しさん', 'EDIT0002', 'VSCodeでいいと思う
拡張機能豊富だし', NOW() - INTERVAL '3 hours 50 minutes' FROM threads t WHERE t.title = 'エディタ何使ってる？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 3, '名無しさん', 'EDIT0003', 'Vim使いワイ、高みの見物', NOW() - INTERVAL '3 hours 30 minutes' FROM threads t WHERE t.title = 'エディタ何使ってる？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 4, '名無しさん', 'EDIT0004', '>>3
Vim覚えるのに何年かかった？', NOW() - INTERVAL '3 hours' FROM threads t WHERE t.title = 'エディタ何使ってる？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 5, '名無しさん', 'EDIT0003', '>>4
基本操作は1週間で覚えた
使いこなすのは今も勉強中', NOW() - INTERVAL '2 hours 30 minutes' FROM threads t WHERE t.title = 'エディタ何使ってる？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 6, '名無しさん', 'EDIT0005', 'Cursorが最近熱い
AI補完が便利', NOW() - INTERVAL '1 hour' FROM threads t WHERE t.title = 'エディタ何使ってる？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 7, '名無しさん', 'EDIT0006', '>>6
Cursorいいよね
コード書くのが捗る', NOW() - INTERVAL '40 minutes' FROM threads t WHERE t.title = 'エディタ何使ってる？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 8, '名無しさん', 'EDIT0001', 'Cursor試してみるわ', NOW() - INTERVAL '18 minutes' FROM threads t WHERE t.title = 'エディタ何使ってる？';

-- アニメ板 追加スレッド
INSERT INTO threads (board_id, title, post_count, last_posted_at) VALUES
((SELECT id FROM boards WHERE name = 'アニメ'), '今期アニメの覇権は何？', 10, NOW() - INTERVAL '3 minutes'),
((SELECT id FROM boards WHERE name = 'アニメ'), '神作画だったアニメ挙げてけ', 8, NOW() - INTERVAL '22 minutes'),
((SELECT id FROM boards WHERE name = 'アニメ'), 'ラノベ原作アニメ総合', 6, NOW() - INTERVAL '50 minutes');

-- 覇権アニメスレのレス
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 1, '名無しさん', 'ANIME001', '今期の覇権アニメ決めようぜ', NOW() - INTERVAL '3 hours' FROM threads t WHERE t.title = '今期アニメの覇権は何？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 2, '名無しさん', 'ANIME002', '○○○○が強すぎる', NOW() - INTERVAL '2 hours 50 minutes' FROM threads t WHERE t.title = '今期アニメの覇権は何？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 3, '名無しさん', 'ANIME003', '>>2
分かる、毎週楽しみ', NOW() - INTERVAL '2 hours 40 minutes' FROM threads t WHERE t.title = '今期アニメの覇権は何？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 4, '名無しさん', 'ANIME004', '△△△△も捨てがたい', NOW() - INTERVAL '2 hours 20 minutes' FROM threads t WHERE t.title = '今期アニメの覇権は何？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 5, '名無しさん', 'ANIME005', '今期豊作すぎない？', NOW() - INTERVAL '2 hours' FROM threads t WHERE t.title = '今期アニメの覇権は何？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 6, '名無しさん', 'ANIME001', '>>5
確かに見るもの多すぎて時間足りない', NOW() - INTERVAL '1 hour 30 minutes' FROM threads t WHERE t.title = '今期アニメの覇権は何？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 7, '名無しさん', 'ANIME006', '原作勢だけど○○○○のアニメ化完璧だわ', NOW() - INTERVAL '1 hour' FROM threads t WHERE t.title = '今期アニメの覇権は何？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 8, '名無しさん', 'ANIME007', 'OPEDも良曲揃いだよな', NOW() - INTERVAL '40 minutes' FROM threads t WHERE t.title = '今期アニメの覇権は何？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 9, '名無しさん', 'ANIME008', '>>8
今期のOPランキング作りたい', NOW() - INTERVAL '20 minutes' FROM threads t WHERE t.title = '今期アニメの覇権は何？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 10, '名無しさん', 'ANIME002', '円盤売上で決まるから待て', NOW() - INTERVAL '3 minutes' FROM threads t WHERE t.title = '今期アニメの覇権は何？';

-- 神作画スレのレス
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 1, '名無しさん', 'SAKUGA01', '作画が神だったアニメ教えて', NOW() - INTERVAL '5 hours' FROM threads t WHERE t.title = '神作画だったアニメ挙げてけ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 2, '名無しさん', 'SAKUGA02', '鬼滅の刃は外せない
ufotableすごい', NOW() - INTERVAL '4 hours 30 minutes' FROM threads t WHERE t.title = '神作画だったアニメ挙げてけ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 3, '名無しさん', 'SAKUGA03', 'モブサイコ100の戦闘シーン', NOW() - INTERVAL '4 hours' FROM threads t WHERE t.title = '神作画だったアニメ挙げてけ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 4, '名無しさん', 'SAKUGA04', '>>3
ボンズの本気見たわ', NOW() - INTERVAL '3 hours 30 minutes' FROM threads t WHERE t.title = '神作画だったアニメ挙げてけ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 5, '名無しさん', 'SAKUGA05', '呪術廻戦の渋谷事変', NOW() - INTERVAL '2 hours' FROM threads t WHERE t.title = '神作画だったアニメ挙げてけ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 6, '名無しさん', 'SAKUGA06', 'Fate/Zeroのライダー戦', NOW() - INTERVAL '1 hour 30 minutes' FROM threads t WHERE t.title = '神作画だったアニメ挙げてけ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 7, '名無しさん', 'SAKUGA01', 'みんなufotable好きすぎワロタ', NOW() - INTERVAL '1 hour' FROM threads t WHERE t.title = '神作画だったアニメ挙げてけ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 8, '名無しさん', 'SAKUGA07', '京アニの日常作画も神だぞ', NOW() - INTERVAL '22 minutes' FROM threads t WHERE t.title = '神作画だったアニメ挙げてけ';

-- ラノベ原作スレのレス
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 1, '名無しさん', 'LNOVE001', 'ラノベ原作で成功したアニメって何だと思う？', NOW() - INTERVAL '4 hours' FROM threads t WHERE t.title = 'ラノベ原作アニメ総合';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 2, '名無しさん', 'LNOVE002', 'SAOは外せない', NOW() - INTERVAL '3 hours 30 minutes' FROM threads t WHERE t.title = 'ラノベ原作アニメ総合';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 3, '名無しさん', 'LNOVE003', 'このすばも良かった', NOW() - INTERVAL '3 hours' FROM threads t WHERE t.title = 'ラノベ原作アニメ総合';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 4, '名無しさん', 'LNOVE004', '>>3
ギャグのテンポ完璧だった', NOW() - INTERVAL '2 hours 30 minutes' FROM threads t WHERE t.title = 'ラノベ原作アニメ総合';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 5, '名無しさん', 'LNOVE005', 'リゼロは原作超えたと思う', NOW() - INTERVAL '1 hour 30 minutes' FROM threads t WHERE t.title = 'ラノベ原作アニメ総合';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 6, '名無しさん', 'LNOVE001', '最近だと無職転生が良かった', NOW() - INTERVAL '50 minutes' FROM threads t WHERE t.title = 'ラノベ原作アニメ総合';

-- ゲーム板 追加スレッド
INSERT INTO threads (board_id, title, post_count, last_posted_at) VALUES
((SELECT id FROM boards WHERE name = 'ゲーム'), 'スマホゲー課金沼から抜け出せない', 9, NOW() - INTERVAL '7 minutes'),
((SELECT id FROM boards WHERE name = 'ゲーム'), 'Steam おすすめゲーム 2026', 7, NOW() - INTERVAL '28 minutes'),
((SELECT id FROM boards WHERE name = 'ゲーム'), 'レトロゲーム好き集まれ', 6, NOW() - INTERVAL '1 hour 15 minutes');

-- 課金沼スレのレス
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 1, '名無しさん', 'GACHA001', 'ガチャに10万溶かした
助けて', NOW() - INTERVAL '3 hours' FROM threads t WHERE t.title = 'スマホゲー課金沼から抜け出せない';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 2, '名無しさん', 'GACHA002', '>>1
何のゲーム？', NOW() - INTERVAL '2 hours 50 minutes' FROM threads t WHERE t.title = 'スマホゲー課金沼から抜け出せない';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 3, '名無しさん', 'GACHA001', '>>2
原○', NOW() - INTERVAL '2 hours 40 minutes' FROM threads t WHERE t.title = 'スマホゲー課金沼から抜け出せない';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 4, '名無しさん', 'GACHA003', '>>3
あれは沼だからな...
天井まで行っちゃうよな', NOW() - INTERVAL '2 hours 20 minutes' FROM threads t WHERE t.title = 'スマホゲー課金沼から抜け出せない';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 5, '名無しさん', 'GACHA004', '月の課金上限決めとけ', NOW() - INTERVAL '2 hours' FROM threads t WHERE t.title = 'スマホゲー課金沼から抜け出せない';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 6, '名無しさん', 'GACHA005', '無課金でも楽しめるゲームやれ', NOW() - INTERVAL '1 hour 30 minutes' FROM threads t WHERE t.title = 'スマホゲー課金沼から抜け出せない';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 7, '名無しさん', 'GACHA001', '>>5-6
ありがとう
来月から上限決める', NOW() - INTERVAL '1 hour' FROM threads t WHERE t.title = 'スマホゲー課金沼から抜け出せない';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 8, '名無しさん', 'GACHA006', '買い切りゲーやれ
精神衛生上いい', NOW() - INTERVAL '30 minutes' FROM threads t WHERE t.title = 'スマホゲー課金沼から抜け出せない';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 9, '名無しさん', 'GACHA007', '>>8
これ
Steamセールで買えば安い', NOW() - INTERVAL '7 minutes' FROM threads t WHERE t.title = 'スマホゲー課金沼から抜け出せない';

-- Steam スレのレス
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 1, '名無しさん', 'STEAM001', 'Steamで面白いゲーム教えて
ジャンル問わず', NOW() - INTERVAL '4 hours' FROM threads t WHERE t.title = 'Steam おすすめゲーム 2026';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 2, '名無しさん', 'STEAM002', 'Balatro
ローグライクポーカー、中毒性やばい', NOW() - INTERVAL '3 hours 30 minutes' FROM threads t WHERE t.title = 'Steam おすすめゲーム 2026';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 3, '名無しさん', 'STEAM003', 'Vampire Survivors
安いし時間泥棒', NOW() - INTERVAL '3 hours' FROM threads t WHERE t.title = 'Steam おすすめゲーム 2026';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 4, '名無しさん', 'STEAM004', '>>3
500円であれだけ遊べるのすごい', NOW() - INTERVAL '2 hours 30 minutes' FROM threads t WHERE t.title = 'Steam おすすめゲーム 2026';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 5, '名無しさん', 'STEAM005', 'Factorio
工場ゲー好きならマスト', NOW() - INTERVAL '1 hour 30 minutes' FROM threads t WHERE t.title = 'Steam おすすめゲーム 2026';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 6, '名無しさん', 'STEAM006', '>>5
時間溶けすぎて仕事に支障出たわ', NOW() - INTERVAL '1 hour' FROM threads t WHERE t.title = 'Steam おすすめゲーム 2026';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 7, '名無しさん', 'STEAM001', 'いっぱいありがとう
ウィッシュリストに入れとく', NOW() - INTERVAL '28 minutes' FROM threads t WHERE t.title = 'Steam おすすめゲーム 2026';

-- レトロゲースレのレス
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 1, '名無しさん', 'RETRO001', 'レトロゲー好きおる？
最近またFF6やってる', NOW() - INTERVAL '5 hours' FROM threads t WHERE t.title = 'レトロゲーム好き集まれ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 2, '名無しさん', 'RETRO002', '>>1
FF6最高だよな
オペラのシーン今でも泣ける', NOW() - INTERVAL '4 hours 30 minutes' FROM threads t WHERE t.title = 'レトロゲーム好き集まれ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 3, '名無しさん', 'RETRO003', 'クロノトリガーやってる
何周目か分からん', NOW() - INTERVAL '4 hours' FROM threads t WHERE t.title = 'レトロゲーム好き集まれ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 4, '名無しさん', 'RETRO004', 'スーファミ時代のスクエニは神だった', NOW() - INTERVAL '3 hours' FROM threads t WHERE t.title = 'レトロゲーム好き集まれ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 5, '名無しさん', 'RETRO005', 'ロックマンXシリーズ好き', NOW() - INTERVAL '2 hours' FROM threads t WHERE t.title = 'レトロゲーム好き集まれ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 6, '名無しさん', 'RETRO001', '>>5
X4まで神ゲーだよな', NOW() - INTERVAL '1 hour 15 minutes' FROM threads t WHERE t.title = 'レトロゲーム好き集まれ';

-- 雑談板 追加スレッド
INSERT INTO threads (board_id, title, post_count, last_posted_at) VALUES
((SELECT id FROM boards WHERE name = '雑談'), '深夜に暇な人集合', 12, NOW() - INTERVAL '2 minutes'),
((SELECT id FROM boards WHERE name = '雑談'), '今日あった良いこと書いてけ', 8, NOW() - INTERVAL '15 minutes'),
((SELECT id FROM boards WHERE name = '雑談'), '独り言スレ', 15, NOW() - INTERVAL '1 minute');

-- 深夜スレのレス
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 1, '名無しさん', 'NIGHT001', '眠れないから誰か話そう', NOW() - INTERVAL '3 hours' FROM threads t WHERE t.title = '深夜に暇な人集合';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 2, '名無しさん', 'NIGHT002', 'ノシ', NOW() - INTERVAL '2 hours 55 minutes' FROM threads t WHERE t.title = '深夜に暇な人集合';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 3, '名無しさん', 'NIGHT003', 'いるぞ', NOW() - INTERVAL '2 hours 50 minutes' FROM threads t WHERE t.title = '深夜に暇な人集合';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 4, '名無しさん', 'NIGHT001', '何してる？', NOW() - INTERVAL '2 hours 45 minutes' FROM threads t WHERE t.title = '深夜に暇な人集合';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 5, '名無しさん', 'NIGHT002', '>>4
YouTube見てる', NOW() - INTERVAL '2 hours 40 minutes' FROM threads t WHERE t.title = '深夜に暇な人集合';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 6, '名無しさん', 'NIGHT003', 'ゲームしてた', NOW() - INTERVAL '2 hours 30 minutes' FROM threads t WHERE t.title = '深夜に暇な人集合';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 7, '名無しさん', 'NIGHT004', '夜食食べてる', NOW() - INTERVAL '2 hours' FROM threads t WHERE t.title = '深夜に暇な人集合';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 8, '名無しさん', 'NIGHT001', '>>7
何食べてる？', NOW() - INTERVAL '1 hour 50 minutes' FROM threads t WHERE t.title = '深夜に暇な人集合';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 9, '名無しさん', 'NIGHT004', '>>8
カップ麺', NOW() - INTERVAL '1 hour 45 minutes' FROM threads t WHERE t.title = '深夜に暇な人集合';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 10, '名無しさん', 'NIGHT005', '深夜のカップ麺は犯罪的に美味い', NOW() - INTERVAL '1 hour' FROM threads t WHERE t.title = '深夜に暇な人集合';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 11, '名無しさん', 'NIGHT002', '>>10
分かる', NOW() - INTERVAL '30 minutes' FROM threads t WHERE t.title = '深夜に暇な人集合';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 12, '名無しさん', 'NIGHT001', 'そろそろ寝るわ
おやすみ', NOW() - INTERVAL '2 minutes' FROM threads t WHERE t.title = '深夜に暇な人集合';

-- 良いこと書いてけスレのレス
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 1, '名無しさん', 'GOOD0001', '今日あった良いこと書いてけ
小さいことでもOK', NOW() - INTERVAL '6 hours' FROM threads t WHERE t.title = '今日あった良いこと書いてけ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 2, '名無しさん', 'GOOD0002', '昼飯美味かった', NOW() - INTERVAL '5 hours' FROM threads t WHERE t.title = '今日あった良いこと書いてけ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 3, '名無しさん', 'GOOD0003', '仕事早く終わった', NOW() - INTERVAL '4 hours' FROM threads t WHERE t.title = '今日あった良いこと書いてけ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 4, '名無しさん', 'GOOD0004', '推しの新曲が良かった', NOW() - INTERVAL '3 hours' FROM threads t WHERE t.title = '今日あった良いこと書いてけ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 5, '名無しさん', 'GOOD0005', '筋トレ続いてる', NOW() - INTERVAL '2 hours' FROM threads t WHERE t.title = '今日あった良いこと書いてけ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 6, '名無しさん', 'GOOD0006', '>>5
えらい', NOW() - INTERVAL '1 hour 30 minutes' FROM threads t WHERE t.title = '今日あった良いこと書いてけ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 7, '名無しさん', 'GOOD0001', 'みんな良い日だったみたいで何より', NOW() - INTERVAL '1 hour' FROM threads t WHERE t.title = '今日あった良いこと書いてけ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 8, '名無しさん', 'GOOD0007', '天気が良かった', NOW() - INTERVAL '15 minutes' FROM threads t WHERE t.title = '今日あった良いこと書いてけ';

-- 独り言スレのレス
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 1, '名無しさん', 'SOLO0001', '独り言書くスレ
返信不要', NOW() - INTERVAL '24 hours' FROM threads t WHERE t.title = '独り言スレ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 2, '名無しさん', 'SOLO0002', '腹減った', NOW() - INTERVAL '20 hours' FROM threads t WHERE t.title = '独り言スレ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 3, '名無しさん', 'SOLO0003', '今日も疲れた', NOW() - INTERVAL '18 hours' FROM threads t WHERE t.title = '独り言スレ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 4, '名無しさん', 'SOLO0004', 'コーヒー美味い', NOW() - INTERVAL '15 hours' FROM threads t WHERE t.title = '独り言スレ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 5, '名無しさん', 'SOLO0005', '明日休みだ', NOW() - INTERVAL '12 hours' FROM threads t WHERE t.title = '独り言スレ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 6, '名無しさん', 'SOLO0001', '掃除しなきゃ', NOW() - INTERVAL '10 hours' FROM threads t WHERE t.title = '独り言スレ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 7, '名無しさん', 'SOLO0006', '眠い', NOW() - INTERVAL '8 hours' FROM threads t WHERE t.title = '独り言スレ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 8, '名無しさん', 'SOLO0007', '散歩行ってきた', NOW() - INTERVAL '6 hours' FROM threads t WHERE t.title = '独り言スレ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 9, '名無しさん', 'SOLO0008', '晩御飯何にしよう', NOW() - INTERVAL '4 hours' FROM threads t WHERE t.title = '独り言スレ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 10, '名無しさん', 'SOLO0002', 'また腹減った', NOW() - INTERVAL '3 hours' FROM threads t WHERE t.title = '独り言スレ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 11, '名無しさん', 'SOLO0009', '風呂入るか', NOW() - INTERVAL '2 hours' FROM threads t WHERE t.title = '独り言スレ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 12, '名無しさん', 'SOLO0010', 'いい湯だった', NOW() - INTERVAL '1 hour 30 minutes' FROM threads t WHERE t.title = '独り言スレ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 13, '名無しさん', 'SOLO0003', '明日何しよう', NOW() - INTERVAL '1 hour' FROM threads t WHERE t.title = '独り言スレ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 14, '名無しさん', 'SOLO0011', 'アイス食べたい', NOW() - INTERVAL '30 minutes' FROM threads t WHERE t.title = '独り言スレ';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 15, '名無しさん', 'SOLO0001', 'そろそろ寝る', NOW() - INTERVAL '1 minute' FROM threads t WHERE t.title = '独り言スレ';

-- 質問板 追加スレッド
INSERT INTO threads (board_id, title, post_count, last_posted_at) VALUES
((SELECT id FROM boards WHERE name = '質問'), '引っ越し初めてなんだが', 7, NOW() - INTERVAL '33 minutes'),
((SELECT id FROM boards WHERE name = '質問'), 'クレジットカードどれがいい？', 8, NOW() - INTERVAL '18 minutes');

-- 引っ越しスレのレス
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 1, '名無しさん', 'HIKKOSI1', '初めて引っ越しするんだけど何から始めればいい？', NOW() - INTERVAL '5 hours' FROM threads t WHERE t.title = '引っ越し初めてなんだが';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 2, '名無しさん', 'HIKKOSI2', '>>1
まず物件探しだろ
SUUMOとか見ろ', NOW() - INTERVAL '4 hours 30 minutes' FROM threads t WHERE t.title = '引っ越し初めてなんだが';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 3, '名無しさん', 'HIKKOSI3', '内見は絶対行け
写真と違うことある', NOW() - INTERVAL '4 hours' FROM threads t WHERE t.title = '引っ越し初めてなんだが';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 4, '名無しさん', 'HIKKOSI4', '初期費用結構かかるから覚悟しとけ', NOW() - INTERVAL '3 hours' FROM threads t WHERE t.title = '引っ越し初めてなんだが';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 5, '名無しさん', 'HIKKOSI1', '>>4
いくらくらい？', NOW() - INTERVAL '2 hours 30 minutes' FROM threads t WHERE t.title = '引っ越し初めてなんだが';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 6, '名無しさん', 'HIKKOSI4', '>>5
家賃の5〜6ヶ月分は見といた方がいい', NOW() - INTERVAL '2 hours' FROM threads t WHERE t.title = '引っ越し初めてなんだが';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 7, '名無しさん', 'HIKKOSI1', '>>6
マジか...貯金しとくわ', NOW() - INTERVAL '33 minutes' FROM threads t WHERE t.title = '引っ越し初めてなんだが';

-- クレカスレのレス
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 1, '名無しさん', 'CARD0001', 'クレジットカード作りたい
おすすめある？', NOW() - INTERVAL '4 hours' FROM threads t WHERE t.title = 'クレジットカードどれがいい？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 2, '名無しさん', 'CARD0002', '>>1
何に使う？', NOW() - INTERVAL '3 hours 50 minutes' FROM threads t WHERE t.title = 'クレジットカードどれがいい？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 3, '名無しさん', 'CARD0001', '>>2
普段の買い物とネットショッピング', NOW() - INTERVAL '3 hours 40 minutes' FROM threads t WHERE t.title = 'クレジットカードどれがいい？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 4, '名無しさん', 'CARD0003', '楽天カードが無難
ポイント貯まりやすい', NOW() - INTERVAL '3 hours' FROM threads t WHERE t.title = 'クレジットカードどれがいい？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 5, '名無しさん', 'CARD0004', '三井住友カードもいいぞ
コンビニでポイント高い', NOW() - INTERVAL '2 hours' FROM threads t WHERE t.title = 'クレジットカードどれがいい？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 6, '名無しさん', 'CARD0005', 'PayPayカードも還元率いい', NOW() - INTERVAL '1 hour 30 minutes' FROM threads t WHERE t.title = 'クレジットカードどれがいい？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 7, '名無しさん', 'CARD0006', '年会費無料のやつから始めとけ', NOW() - INTERVAL '1 hour' FROM threads t WHERE t.title = 'クレジットカードどれがいい？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 8, '名無しさん', 'CARD0001', 'みんなありがとう
楽天カード申し込んでみる', NOW() - INTERVAL '18 minutes' FROM threads t WHERE t.title = 'クレジットカードどれがいい？';

-- AI板 追加スレッド
INSERT INTO threads (board_id, title, post_count, last_posted_at) VALUES
((SELECT id FROM boards WHERE name = 'AI・機械学習'), '画像生成AI使ってる人', 7, NOW() - INTERVAL '25 minutes'),
((SELECT id FROM boards WHERE name = 'AI・機械学習'), 'AIで仕事なくなる？', 9, NOW() - INTERVAL '8 minutes');

-- 画像生成スレのレス
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 1, '名無しさん', 'GENAI001', '画像生成AI何使ってる？
Midjourney？Stable Diffusion？', NOW() - INTERVAL '4 hours' FROM threads t WHERE t.title = '画像生成AI使ってる人';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 2, '名無しさん', 'GENAI002', 'Midjourney使ってる
クオリティ高い', NOW() - INTERVAL '3 hours 30 minutes' FROM threads t WHERE t.title = '画像生成AI使ってる人';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 3, '名無しさん', 'GENAI003', 'SD派
ローカルで動かせるのがいい', NOW() - INTERVAL '3 hours' FROM threads t WHERE t.title = '画像生成AI使ってる人';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 4, '名無しさん', 'GENAI004', '>>3
グラボ何使ってる？', NOW() - INTERVAL '2 hours 30 minutes' FROM threads t WHERE t.title = '画像生成AI使ってる人';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 5, '名無しさん', 'GENAI003', '>>4
RTX3060 12GB', NOW() - INTERVAL '2 hours' FROM threads t WHERE t.title = '画像生成AI使ってる人';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 6, '名無しさん', 'GENAI005', 'DALL-E 3も結構いいよ', NOW() - INTERVAL '1 hour' FROM threads t WHERE t.title = '画像生成AI使ってる人';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 7, '名無しさん', 'GENAI001', 'みんな色々使ってるんだな
参考になる', NOW() - INTERVAL '25 minutes' FROM threads t WHERE t.title = '画像生成AI使ってる人';

-- AI仕事スレのレス
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 1, '名無しさん', 'AIJOB001', 'AIで仕事なくなる論争
実際どう思う？', NOW() - INTERVAL '5 hours' FROM threads t WHERE t.title = 'AIで仕事なくなる？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 2, '名無しさん', 'AIJOB002', '一部の仕事は確実に影響受けると思う', NOW() - INTERVAL '4 hours 30 minutes' FROM threads t WHERE t.title = 'AIで仕事なくなる？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 3, '名無しさん', 'AIJOB003', 'なくなるというより変わる
AI使いこなせる人が勝つ', NOW() - INTERVAL '4 hours' FROM threads t WHERE t.title = 'AIで仕事なくなる？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 4, '名無しさん', 'AIJOB004', '>>3
これな
抵抗するより適応した方がいい', NOW() - INTERVAL '3 hours 30 minutes' FROM threads t WHERE t.title = 'AIで仕事なくなる？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 5, '名無しさん', 'AIJOB005', 'プログラマーだけど
AIのおかげで効率上がってる', NOW() - INTERVAL '3 hours' FROM threads t WHERE t.title = 'AIで仕事なくなる？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 6, '名無しさん', 'AIJOB006', '>>5
Copilot使ってる？', NOW() - INTERVAL '2 hours' FROM threads t WHERE t.title = 'AIで仕事なくなる？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 7, '名無しさん', 'AIJOB005', '>>6
Cursorメインで使ってる
Copilotより便利', NOW() - INTERVAL '1 hour 30 minutes' FROM threads t WHERE t.title = 'AIで仕事なくなる？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 8, '名無しさん', 'AIJOB007', '結局道具だからな
使う人次第', NOW() - INTERVAL '30 minutes' FROM threads t WHERE t.title = 'AIで仕事なくなる？';
INSERT INTO posts (thread_id, post_number, name, poster_id, content, posted_at)
SELECT t.id, 9, '名無しさん', 'AIJOB001', '前向きな意見多くて安心した', NOW() - INTERVAL '8 minutes' FROM threads t WHERE t.title = 'AIで仕事なくなる？';

-- リアクション追加
INSERT INTO reactions (post_id, reaction_type, count)
SELECT p.id, 'like', FLOOR(RANDOM() * 15 + 1)::int
FROM posts p
WHERE p.post_number = 1
ON CONFLICT (post_id, reaction_type) DO UPDATE SET count = reactions.count + EXCLUDED.count;

INSERT INTO reactions (post_id, reaction_type, count)
SELECT p.id, 'laugh', FLOOR(RANDOM() * 8 + 1)::int
FROM posts p
WHERE p.content LIKE '%ワロタ%' OR p.content LIKE '%www%' OR RANDOM() < 0.25
ON CONFLICT (post_id, reaction_type) DO UPDATE SET count = reactions.count + EXCLUDED.count;

INSERT INTO reactions (post_id, reaction_type, count)
SELECT p.id, 'think', FLOOR(RANDOM() * 6 + 1)::int
FROM posts p
WHERE p.content LIKE '%なるほど%' OR p.content LIKE '%分かる%' OR RANDOM() < 0.2
ON CONFLICT (post_id, reaction_type) DO UPDATE SET count = reactions.count + EXCLUDED.count;

INSERT INTO reactions (post_id, reaction_type, count)
SELECT p.id, 'fire', FLOOR(RANDOM() * 5 + 1)::int
FROM posts p
WHERE RANDOM() < 0.15
ON CONFLICT (post_id, reaction_type) DO UPDATE SET count = reactions.count + EXCLUDED.count;

INSERT INTO reactions (post_id, reaction_type, count)
SELECT p.id, 'sad', FLOOR(RANDOM() * 4 + 1)::int
FROM posts p
WHERE p.content LIKE '%泣%' OR p.content LIKE '%悲%' OR RANDOM() < 0.1
ON CONFLICT (post_id, reaction_type) DO UPDATE SET count = reactions.count + EXCLUDED.count;

-- 完了メッセージ
SELECT '大量ダミーデータ追加完了！' as message;
SELECT COUNT(*) as total_threads FROM threads;
SELECT COUNT(*) as total_posts FROM posts;
SELECT COUNT(*) as total_reactions FROM reactions;
