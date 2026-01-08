import { type ClassValue, clsx } from "clsx"
import { twMerge } from "tailwind-merge"

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}

// IPアドレスから日替わりIDを生成（サーバーサイドでのみ使用）
export function generatePosterId(ip: string): string {
  // サーバーサイドでのみcryptoを使用
  if (typeof window === 'undefined') {
    const crypto = require('crypto');
    const today = new Date().toISOString().split('T')[0];
    const salt = process.env.ID_SALT || 'default-salt-change-this';
    const hash = crypto.createHash('sha256').update(`${ip}-${today}-${salt}`).digest('hex');
    return hash.substring(0, 8).toUpperCase();
  }
  // クライアントサイドでは呼ばれないはず
  return 'XXXXXXXX';
}

// レスの本文内のURLをリンク化
export function linkifyUrls(text: string): string {
  const urlRegex = /(https?:\/\/[^\s]+)/g;
  return text.replace(urlRegex, '<a href="$1" target="_blank" rel="noopener noreferrer" class="text-cyan-400 hover:text-cyan-300 hover:underline transition-colors">$1</a>');
}

// レスアンカーをリンク化
export function linkifyAnchors(text: string): string {
  const anchorRegex = /&gt;&gt;(\d+)/g;
  return text.replace(anchorRegex, '<a href="#post-$1" class="text-indigo-400 hover:text-indigo-300 hover:underline transition-colors font-medium">&gt;&gt;$1</a>');
}

// HTMLエスケープ
export function escapeHtml(text: string): string {
  return text
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#039;');
}

// 投稿内容を処理
export function processPostContent(text: string): string {
  let processed = escapeHtml(text);
  processed = linkifyUrls(processed);
  processed = linkifyAnchors(processed);
  return processed;
}

// 日時フォーマット
export function formatDate(dateString: string): string {
  const date = new Date(dateString);
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, '0');
  const day = String(date.getDate()).padStart(2, '0');
  const hours = String(date.getHours()).padStart(2, '0');
  const minutes = String(date.getMinutes()).padStart(2, '0');
  const seconds = String(date.getSeconds()).padStart(2, '0');
  const dayOfWeek = ['日', '月', '火', '水', '木', '金', '土'][date.getDay()];
  
  return `${year}/${month}/${day}(${dayOfWeek}) ${hours}:${minutes}:${seconds}`;
}

// 投稿者IDから色を生成（ダークモード/ライトモード対応）
export function getIdColor(posterId: string, isDark: boolean = true): { bg: string; text: string } {
  // IDのハッシュから色相を決定
  let hash = 0;
  for (let i = 0; i < posterId.length; i++) {
    hash = posterId.charCodeAt(i) + ((hash << 5) - hash);
  }
  
  const hue = Math.abs(hash) % 360;
  
  if (isDark) {
    return {
      bg: `hsla(${hue}, 70%, 20%, 0.5)`,
      text: `hsl(${hue}, 80%, 70%)`
    };
  } else {
    // ライトモード用: 濃い背景に白文字
    return {
      bg: `hsl(${hue}, 50%, 40%)`,
      text: '#ffffff'
    };
  }
}

// カテゴリーアイコンを取得
export function getCategoryIcon(category: string): string {
  const icons: Record<string, string> = {
    'ニュース': '📰',
    '技術': '💻',
    '趣味': '🎮',
    '生活': '🏠',
    'その他': '💬',
  };
  return icons[category] || '📋';
}

// 板アイコンを取得
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

// リアクションの絵文字を取得
export function getReactionEmoji(type: string): string {
  const emojis: Record<string, string> = {
    'like': '👍',
    'laugh': '😂',
    'think': '🤔',
    'sad': '😢',
    'fire': '🔥',
  };
  return emojis[type] || '👍';
}

// 勢いを計算（1時間あたりのレス数）
export function calculateMomentum(postCount: number, createdAt: string): number {
  const created = new Date(createdAt).getTime();
  const now = Date.now();
  const hoursDiff = Math.max(1, (now - created) / (1000 * 60 * 60));
  return Math.round((postCount / hoursDiff) * 10) / 10;
}

// HOTかどうかを判定（厳しめの条件）
export function isHot(postCount: number, createdAt: string): boolean {
  const momentum = calculateMomentum(postCount, createdAt);
  // 勢いが2.0以上（1時間に2レス以上）または投稿数が50件以上
  return momentum >= 2.0 || postCount >= 50;
}
