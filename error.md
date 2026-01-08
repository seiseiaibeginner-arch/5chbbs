# ミラーリング表示問題の原因推測

## 症状
- トップページで各カテゴリカード内に「5chBBS」「匿名で自由に語り合える掲示板」が繰り返し表示される
- 本来表示されるべきカテゴリ名（ニュース、技術、趣味など）や板一覧が表示されない

## 推測される原因

### 1. APIからのデータ取得失敗（最有力）
- `/api/boards` APIがエラーを返しているか、空のデータを返している可能性
- Supabaseへの接続に問題がある（環境変数、ネットワーク、RLSポリシー）
- `boards`配列が空のため、`sortedCategories`も空になり、カテゴリカードが表示されない

### 2. Supabase RLS（Row Level Security）の問題
- テーブルのRLSポリシーが正しく設定されていない
- 匿名ユーザー（anon key）でのアクセスがブロックされている可能性

### 3. 環境変数の問題
- `.env.local`の環境変数が正しく読み込まれていない
- `NEXT_PUBLIC_SUPABASE_URL` または `NEXT_PUBLIC_SUPABASE_ANON_KEY` が不正

### 4. Next.jsのハイドレーションエラー
- サーバーサイドとクライアントサイドでレンダリング結果が異なる
- コンポーネントのマウント順序の問題

### 5. CSSの重複/オーバーレイ問題
- ヘッダーコンポーネントが意図せず複数回レンダリングされている
- z-indexやposition設定の問題でヘッダーが重なって見えている

## 確認すべきこと

1. **ブラウザのコンソールでエラーを確認**
   - F12 → Console タブを開いてエラーメッセージを確認

2. **APIの応答を直接確認**
   - ブラウザで `http://localhost:3000/api/boards` にアクセス
   - JSONデータが正しく返ってくるか確認

3. **Supabaseダッシュボードで確認**
   - Table Editor → boards テーブルにデータがあるか
   - Authentication → Policies でRLSが正しく設定されているか

4. **環境変数の確認**
   - `.env.local` ファイルの内容が正しいか
   - サーバー起動時に `.env.local` が読み込まれているか（ターミナルに `Environments: .env.local` と表示されるか）

---

# 原因特定と解決（2026-01-08）

## ✅ 特定された原因：ハイドレーションエラー（SSR/CSR不一致）

### 比較分析

| 項目 | 正常動作版（絵文字） | 問題発生版（Lucide Icons） |
|------|---------------------|--------------------------|
| アイコンデータ | 文字列（`'⚡'`, `'🎮'`） | Reactコンポーネント（`LucideIcon`型） |
| 取得方法 | `lib/utils.ts`の関数 | ページ内で定義したオブジェクト |
| レンダリング | `{getBoardIcon(name)}` | `<BoardIcon name={name} />` |
| SSR/CSR | 完全一致 | 不一致の可能性 |

### 問題のコード

```typescript
// 問題が発生したコード
const boardIcons: Record<string, LucideIcon> = {
  'ニュース速報': Zap,
  'プログラミング': Code2,
  // ...
};

const BoardIcon = ({ name, className }: { name: string; className?: string }) => {
  const Icon = boardIcons[name] || FileText;  // ← ここが問題
  return <Icon className={className} />;
};
```

### 原因の詳細

1. **動的コンポーネント選択の問題**
   - `boardIcons[name]` の評価がサーバーとクライアントで異なる可能性
   - `undefined`時のフォールバック（`FileText`）のタイミングがズレる

2. **Lucideアイコンの内部状態**
   - Lucideアイコンは内部でSVGを生成するコンポーネント
   - SSRで生成されたHTMLとCSRで生成されたHTMLが一致しない場合、ハイドレーションエラーが発生

3. **DOMの崩壊**
   - ハイドレーションエラーが発生すると、Reactは既存のDOMを再利用しようとする
   - 結果として、ヘッダーの内容（「5chBBS」）が各カードにも表示される奇妙な状態になった

### 絵文字が安全な理由

- **文字列はプリミティブ値**：サーバーとクライアントで100%同じ出力
- **コンポーネントではない**：Reactのライフサイクルに依存しない
- **ハイドレーションエラーが起きない**

## 🔧 解決方法

### 採用した解決策：絵文字版に戻す

```typescript
// lib/utils.ts - 正常動作するコード
export function getBoardIcon(boardName: string): string {
  const icons: Record<string, string> = {
    'ニュース速報': '⚡',
    '芸能ニュース': '🌟',
    '国際ニュース': '🌍',
    'プログラミング': '👨‍💻',
    'Web開発': '🌐',
    'AI・機械学習': '🤖',
    'アニメ': '🎬',
    'ゲーム': '🎮',
    '音楽': '🎵',
    '料理': '🍳',
    '健康': '💪',
    '旅行': '✈️',
    '雑談': '💬',
    '質問': '❓',
    '創作': '🎨',
  };
  return icons[boardName] || '📋';
}
```

### 将来的にLucide Iconsを使いたい場合の代替案

#### 方法1: `next/dynamic`で動的インポート（SSR無効化）

```typescript
import dynamic from 'next/dynamic';

const BoardIcon = dynamic(() => import('@/components/BoardIcon'), {
  ssr: false,
  loading: () => <span>📋</span>
});
```

#### 方法2: アイコンを静的にインポートしてswitch文で切り替え

```typescript
import { Zap, Star, Globe, Code2 } from 'lucide-react';

function BoardIcon({ name, className }: { name: string; className?: string }) {
  switch (name) {
    case 'ニュース速報':
      return <Zap className={className} />;
    case '芸能ニュース':
      return <Star className={className} />;
    // ...
    default:
      return <FileText className={className} />;
  }
}
```

#### 方法3: `useEffect`内でのみアイコンを設定（クライアントサイドのみ）

```typescript
const [Icon, setIcon] = useState<LucideIcon | null>(null);

useEffect(() => {
  setIcon(boardIcons[name] || FileText);
}, [name]);

if (!Icon) return <span>📋</span>;
return <Icon className={className} />;
```

## 📝 教訓

1. **動的コンポーネント選択は慎重に**
   - SSRとCSRの一致を常に意識する
   - 特にオブジェクトからコンポーネントを動的に取得する場合は注意

2. **文字列（絵文字）は安全**
   - プリミティブ値はハイドレーションエラーを起こさない
   - パフォーマンス的にも軽量

3. **問題が発生したらシンプルなバージョンに戻す**
   - 段階的に機能を追加して問題を切り分ける
