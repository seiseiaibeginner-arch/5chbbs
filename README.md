# 5chBBS - 匿名掲示板

5ch風の匿名掲示板システムです。会員登録不要で誰でも自由に投稿できます。

## 技術スタック

- **フロントエンド**: Next.js 14 (Pages Router) + TypeScript
- **バックエンド**: Supabase (PostgreSQL)
- **デプロイ**: Vercel + GitHub
- **スタイリング**: Tailwind CSS + shadcn/ui + Radix UI
- **アイコン**: Lucide Icons
- **アニメーション**: Framer Motion

## セットアップ

### 1. リポジトリのクローン

```bash
git clone https://github.com/your-username/5chbbs.git
cd 5chbbs
```

### 2. 依存関係のインストール

```bash
npm install
```

### 3. 環境変数の設定

`.env.local` ファイルを作成し、以下を設定：

```
NEXT_PUBLIC_SUPABASE_URL=your-supabase-project-url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-supabase-anon-key
```

### 4. Supabaseでテーブル作成

Supabaseダッシュボードの SQL Editor で `supabase/schema.sql` の内容を実行してください。

### 5. 開発サーバーの起動

```bash
npm run dev
```

### 6. アクセス

ブラウザで http://localhost:3000 にアクセス

## Vercelへのデプロイ

### 1. GitHubにプッシュ

```bash
git add .
git commit -m "Initial commit"
git push origin main
```

### 2. Vercelでインポート

1. https://vercel.com にアクセス
2. 「New Project」をクリック
3. GitHubリポジトリを選択
4. 環境変数を設定:
   - `NEXT_PUBLIC_SUPABASE_URL`
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY`
5. 「Deploy」をクリック

## 主な機能

### 板（カテゴリ）
- ニュース、技術、趣味、生活、その他の15板
- カテゴリ別にグループ化表示

### スレッド
- 新規スレッド作成
- スレッド一覧表示（最終投稿日時順）
- ページネーション（50件/ページ）
- HOTバッジ表示

### レス投稿
- 匿名投稿（名前は任意、デフォルト「名無しさん」）
- sage機能（メール欄に「sage」でスレッドが上がらない）
- レスアンカー（>>123 形式で参照）
- URLの自動リンク化
- 日替わりID（同一IPは同じIDで表示）
- 1000レスでdat落ち（書き込み終了）

### リアクション機能
- 👍 いいね
- 😂 ワロタ
- 🤔 なるほど
- 😢 かなしい
- 🔥 神

### その他
- お気に入りスレッド（ローカル保存）
- 投稿者ID色分け
- ダークモードUI
- グラスモーフィズムデザイン

## ディレクトリ構造

```
5chbbs/
├── components/ui/     # shadcn/ui コンポーネント
├── lib/
│   ├── supabase.ts    # Supabase接続
│   └── utils.ts       # ユーティリティ関数
├── pages/
│   ├── api/           # API Routes
│   ├── board/         # 板・スレッドページ
│   └── index.tsx      # トップページ
├── styles/
│   └── globals.css    # グローバルスタイル
├── supabase/
│   └── schema.sql     # テーブル定義
└── vercel.json        # Vercel設定
```

## API エンドポイント

| メソッド | パス | 説明 |
|---------|------|------|
| GET | /api/boards | 板一覧取得 |
| GET | /api/boards/[boardId] | 板詳細取得 |
| GET | /api/boards/[boardId]/threads | スレッド一覧取得 |
| POST | /api/boards/[boardId]/threads | スレッド作成 |
| GET | /api/threads/[threadId] | スレッド詳細取得 |
| GET | /api/threads/[threadId]/posts | レス一覧取得 |
| POST | /api/threads/[threadId]/posts | レス投稿 |
| GET | /api/threads/[threadId]/reactions | リアクション取得 |
| GET | /api/posts/[postId]/reactions | リアクション取得 |
| POST | /api/posts/[postId]/reactions | リアクション追加 |

## 開発コマンド

```bash
# 開発サーバー起動
npm run dev

# ビルド
npm run build

# 本番モード起動
npm start

# Lint
npm run lint
```

## 注意事項

- このプロジェクトは学習・デモ用です
- 本番環境で使用する場合は、適切なセキュリティ対策を追加してください
- 違法なコンテンツの投稿は禁止です

## ライセンス

MIT
