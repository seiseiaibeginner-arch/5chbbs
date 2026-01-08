import { useEffect, useState, useCallback } from 'react';
import Head from 'next/head';
import Link from 'next/link';
import { useRouter } from 'next/router';
import { motion, AnimatePresence } from 'framer-motion';
import { ArrowLeft, MessageSquare, Send, AlertCircle, Star, StarOff, Moon, Sun } from 'lucide-react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Textarea } from '@/components/ui/textarea';
import { Label } from '@/components/ui/label';
import { Badge } from '@/components/ui/badge';
import { formatDate, processPostContent, getIdColor, getReactionEmoji } from '@/lib/utils';

interface Post {
  id: number;
  thread_id: number;
  post_number: number;
  name: string;
  email: string;
  posted_at: string;
  poster_id: string;
  content: string;
  is_deleted: boolean;
}

interface Thread {
  id: number;
  board_id: number;
  title: string;
  post_count: number;
  status: string;
  last_posted_at?: string;
}

interface Board {
  id: number;
  name: string;
}

interface FavoriteThread {
  id: number;
  title: string;
  boardId: number;
  boardName: string;
  postCount: number;
  lastPostedAt: string;
}

interface Reactions {
  [postId: number]: {
    like: number;
    laugh: number;
    think: number;
    sad: number;
    fire: number;
  };
}

const REACTION_TYPES = ['like', 'laugh', 'think', 'sad', 'fire'] as const;

export default function ThreadPage() {
  const router = useRouter();
  const { boardId, threadId } = router.query;
  const [thread, setThread] = useState<Thread | null>(null);
  const [board, setBoard] = useState<Board | null>(null);
  const [posts, setPosts] = useState<Post[]>([]);
  const [reactions, setReactions] = useState<Reactions>({});
  const [loading, setLoading] = useState(true);
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState('');
  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [isFavorite, setIsFavorite] = useState(false);
  const [isDark, setIsDark] = useState(true);
  const [reactedPosts, setReactedPosts] = useState<Record<string, string[]>>({});
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    content: '',
  });

  // テーマの初期化
  useEffect(() => {
    const savedTheme = localStorage.getItem('theme');
    const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
    const initialDark = savedTheme ? savedTheme === 'dark' : prefersDark;
    setIsDark(initialDark);
    document.documentElement.classList.toggle('dark', initialDark);
  }, []);

  // テーマ切り替え
  const toggleTheme = () => {
    const newDark = !isDark;
    setIsDark(newDark);
    localStorage.setItem('theme', newDark ? 'dark' : 'light');
    document.documentElement.classList.toggle('dark', newDark);
  };

  // お気に入り状態を読み込み
  useEffect(() => {
    if (threadId) {
      const favorites = JSON.parse(localStorage.getItem('favorites') || '[]');
      setIsFavorite(favorites.includes(Number(threadId)));
      
      const reacted = JSON.parse(localStorage.getItem('reactedPosts') || '{}');
      setReactedPosts(reacted);
    }
  }, [threadId]);

  const fetchBoard = useCallback(async () => {
    try {
      const response = await fetch(`/api/boards/${boardId}`);
      const data = await response.json();
      setBoard(data);
    } catch (error) {
      console.error('Error fetching board:', error);
    }
  }, [boardId]);

  const fetchThread = useCallback(async () => {
    try {
      const response = await fetch(`/api/threads/${threadId}`);
      const data = await response.json();
      setThread(data);
    } catch (error) {
      console.error('Error fetching thread:', error);
    }
  }, [threadId]);

  const fetchPosts = useCallback(async () => {
    try {
      const response = await fetch(`/api/threads/${threadId}/posts?page=${page}`);
      const data = await response.json();
      setPosts(data.posts || []);
      setTotalPages(data.totalPages || 1);
    } catch (error) {
      console.error('Error fetching posts:', error);
      setPosts([]);
    } finally {
      setLoading(false);
    }
  }, [threadId, page]);

  const fetchReactions = useCallback(async () => {
    try {
      const response = await fetch(`/api/threads/${threadId}/reactions`);
      const data = await response.json();
      setReactions(data);
    } catch (error) {
      console.error('Error fetching reactions:', error);
    }
  }, [threadId]);

  useEffect(() => {
    if (threadId && boardId) {
      fetchBoard();
      fetchThread();
      fetchPosts();
      fetchReactions();
    }
  }, [threadId, boardId, page, fetchBoard, fetchThread, fetchPosts, fetchReactions]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    setSubmitting(true);

    try {
      const response = await fetch(`/api/threads/${threadId}/posts`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(formData),
      });

      const data = await response.json();

      if (!response.ok) {
        throw new Error(data.error || 'レスの投稿に失敗しました');
      }

      setFormData({ name: '', email: '', content: '' });
      await fetchPosts();
      await fetchThread();
      
      // お気に入りに登録されている場合は情報を更新
      updateFavoriteInfo();
      
      if (thread && thread.post_count >= page * 100) {
        setPage(Math.ceil((thread.post_count + 1) / 100));
      }
    } catch (err: any) {
      setError(err.message);
    } finally {
      setSubmitting(false);
    }
  };

  const handleReaction = async (postId: number, reactionType: string) => {
    // 既にリアクション済みかチェック
    const postReactions = reactedPosts[postId] || [];
    if (postReactions.includes(reactionType)) {
      return;
    }

    try {
      const response = await fetch(`/api/posts/${postId}/reactions`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ reactionType }),
      });

      if (response.ok) {
        // ローカルの状態を更新
        setReactions(prev => ({
          ...prev,
          [postId]: {
            ...prev[postId],
            [reactionType]: (prev[postId]?.[reactionType as keyof typeof prev[number]] || 0) + 1
          }
        }));

        // リアクション済みを記録
        const newReactedPosts = {
          ...reactedPosts,
          [postId]: [...postReactions, reactionType]
        };
        setReactedPosts(newReactedPosts);
        localStorage.setItem('reactedPosts', JSON.stringify(newReactedPosts));
      }
    } catch (error) {
      console.error('Error adding reaction:', error);
    }
  };

  // お気に入り情報を更新
  const updateFavoriteInfo = () => {
    if (!thread || !board) return;
    
    const favoriteIds = JSON.parse(localStorage.getItem('favorites') || '[]');
    if (!favoriteIds.includes(Number(threadId))) return;
    
    const favoriteThreads = JSON.parse(localStorage.getItem('favoriteThreads') || '[]');
    const newFavoriteThread: FavoriteThread = {
      id: Number(threadId),
      title: thread.title,
      boardId: Number(boardId),
      boardName: board.name,
      postCount: thread.post_count + 1,
      lastPostedAt: new Date().toISOString(),
    };
    const newFavoriteThreads = [
      ...favoriteThreads.filter((t: FavoriteThread) => t.id !== Number(threadId)),
      newFavoriteThread
    ];
    localStorage.setItem('favoriteThreads', JSON.stringify(newFavoriteThreads));
  };

  const toggleFavorite = () => {
    const favoriteIds = JSON.parse(localStorage.getItem('favorites') || '[]');
    const favoriteThreads = JSON.parse(localStorage.getItem('favoriteThreads') || '[]');
    
    if (isFavorite) {
      // 削除
      const newFavoriteIds = favoriteIds.filter((id: number) => id !== Number(threadId));
      const newFavoriteThreads = favoriteThreads.filter((t: FavoriteThread) => t.id !== Number(threadId));
      localStorage.setItem('favorites', JSON.stringify(newFavoriteIds));
      localStorage.setItem('favoriteThreads', JSON.stringify(newFavoriteThreads));
    } else {
      // 追加
      const newFavoriteIds = [...favoriteIds, Number(threadId)];
      const newFavoriteThread: FavoriteThread = {
        id: Number(threadId),
        title: thread?.title || '',
        boardId: Number(boardId),
        boardName: board?.name || '',
        postCount: thread?.post_count || 0,
        lastPostedAt: thread?.last_posted_at || new Date().toISOString(),
      };
      const newFavoriteThreads = [...favoriteThreads.filter((t: FavoriteThread) => t.id !== Number(threadId)), newFavoriteThread];
      localStorage.setItem('favorites', JSON.stringify(newFavoriteIds));
      localStorage.setItem('favoriteThreads', JSON.stringify(newFavoriteThreads));
    }
    
    setIsFavorite(!isFavorite);
  };

  const scrollToPost = (postNumber: number) => {
    const element = document.getElementById(`post-${postNumber}`);
    if (element) {
      element.scrollIntoView({ behavior: 'smooth', block: 'center' });
      element.classList.add('ring-2', 'ring-indigo-500');
      setTimeout(() => {
        element.classList.remove('ring-2', 'ring-indigo-500');
      }, 2000);
    }
  };

  useEffect(() => {
    const handleAnchorClick = (e: MouseEvent) => {
      const target = e.target as HTMLElement;
      if (target.tagName === 'A' && target.getAttribute('href')?.startsWith('#post-')) {
        e.preventDefault();
        const postNumber = parseInt(target.getAttribute('href')!.replace('#post-', ''));
        scrollToPost(postNumber);
      }
    };

    document.addEventListener('click', handleAnchorClick);
    return () => document.removeEventListener('click', handleAnchorClick);
  }, []);

  if (loading || !thread) {
    return (
      <div className={`min-h-screen flex items-center justify-center ${isDark ? 'bg-[#0a0a0f]' : 'bg-slate-200'}`}>
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-indigo-500"></div>
      </div>
    );
  }

  const isArchived = thread.status !== 'active' || thread.post_count >= 1000;

  return (
    <>
      <Head>
        <title>{thread.title} - 5chBBS</title>
      </Head>

      <div className={`min-h-screen transition-colors duration-300 ${isDark ? 'bg-[#0a0a0f]' : 'bg-slate-200'}`}>
        {/* Animated background */}
        <div className="fixed inset-0 overflow-hidden pointer-events-none">
          {isDark ? (
            <>
              <div className="absolute -top-40 -right-40 w-80 h-80 rounded-full blur-[100px] bg-indigo-500/20" />
              <div className="absolute top-1/2 -left-40 w-80 h-80 rounded-full blur-[100px] bg-cyan-500/20" />
            </>
          ) : (
            <>
              <div className="absolute -top-40 -right-40 w-96 h-96 rounded-full blur-[150px] bg-indigo-400/20" />
              <div className="absolute top-1/2 -left-40 w-96 h-96 rounded-full blur-[150px] bg-sky-400/15" />
            </>
          )}
        </div>

        {/* Header */}
        <header className={`relative z-10 border-b ${
          isDark 
            ? 'border-white/10 bg-black/20 backdrop-blur-xl' 
            : 'border-slate-300 bg-white shadow-sm'
        }`}>
          <div className="container mx-auto px-4 py-4">
            <div className="flex items-center gap-4">
              <Link href={`/board/${boardId}`}>
                <Button variant="ghost" size="icon" className={isDark ? 'text-white/60 hover:text-white' : 'text-slate-600 hover:text-slate-900 hover:bg-slate-200'}>
                  <ArrowLeft className="w-5 h-5" />
                </Button>
              </Link>
              <div className="flex-1 min-w-0">
                <h1 className={`text-xl font-bold truncate ${isDark ? 'text-white' : 'text-slate-800'}`}>{thread.title}</h1>
                <p className={`text-sm ${isDark ? 'text-white/50' : 'text-slate-500'}`}>
                  {thread.post_count} レス
                  {isArchived && (
                    <span className="ml-2 text-red-500 font-medium">（書き込み終了）</span>
                  )}
                </p>
              </div>
              <Button
                variant="ghost"
                size="icon"
                onClick={toggleTheme}
                className={`rounded-full ${
                  isDark 
                    ? 'text-white/60 hover:text-white hover:bg-white/10' 
                    : 'text-slate-600 hover:text-slate-900 hover:bg-slate-200'
                }`}
              >
                {isDark ? <Sun className="w-5 h-5" /> : <Moon className="w-5 h-5" />}
              </Button>
              <Button
                variant="ghost"
                size="icon"
                onClick={toggleFavorite}
                className={isFavorite ? 'text-amber-500 hover:text-amber-600' : isDark ? 'text-white/40 hover:text-amber-400' : 'text-slate-400 hover:text-amber-500'}
              >
                {isFavorite ? <Star className="w-5 h-5 fill-current" /> : <StarOff className="w-5 h-5" />}
              </Button>
            </div>
          </div>
        </header>

        {/* Main Content */}
        <main className="relative z-10 container mx-auto px-4 py-6 max-w-4xl">
          {/* Posts */}
          <Card className={`mb-6 ${isDark ? '' : 'bg-white border-slate-300 shadow-md'}`}>
            <CardHeader className={`border-b ${isDark ? 'border-white/10' : 'border-slate-200'}`}>
              <CardTitle className={`flex items-center gap-2 text-lg ${isDark ? '' : 'text-slate-800'}`}>
                <MessageSquare className={`w-5 h-5 ${isDark ? 'text-indigo-400' : 'text-indigo-600'}`} />
                レス一覧
              </CardTitle>
            </CardHeader>
            <CardContent className="pt-4">
              <div className="space-y-4">
                <AnimatePresence>
                  {posts && posts.length > 0 && posts.map((post, index) => {
                    const idColor = getIdColor(post.poster_id, isDark);
                    const postReactions = reactions[post.id] || { like: 0, laugh: 0, think: 0, sad: 0, fire: 0 };
                    const alreadyReacted = reactedPosts[post.id] || [];

                    return (
                      <motion.div
                        key={post.id}
                        id={`post-${post.post_number}`}
                        initial={{ opacity: 0, y: 10 }}
                        animate={{ opacity: 1, y: 0 }}
                        transition={{ delay: index * 0.02 }}
                        className={`p-4 rounded-xl border transition-all duration-300 ${
                          isDark 
                            ? 'bg-white/5 border-white/10' 
                            : 'bg-slate-50 border-slate-300'
                        }`}
                      >
                        {post.is_deleted ? (
                          <p className={isDark ? 'text-white/30 italic' : 'text-slate-400 italic'}>このレスは削除されました</p>
                        ) : (
                          <>
                            <div className="flex flex-wrap items-center gap-2 text-sm mb-3">
                              <Badge variant="cyan" className="font-mono">
                                {post.post_number}
                              </Badge>
                              <span className={`font-medium ${isDark ? 'text-emerald-400' : 'text-emerald-600'}`}>{post.name}</span>
                              {post.email && (
                                <span className={isDark ? 'text-white/30' : 'text-slate-400'}>[{post.email}]</span>
                              )}
                              <span className={`text-xs ${isDark ? 'text-white/30' : 'text-slate-400'}`}>{formatDate(post.posted_at)}</span>
                              <span
                                className="font-mono text-xs px-2 py-0.5 rounded"
                                style={{ backgroundColor: idColor.bg, color: idColor.text }}
                              >
                                ID:{post.poster_id}
                              </span>
                            </div>
                            <div 
                              className={`whitespace-pre-wrap break-words leading-relaxed mb-3 ${isDark ? 'text-white/80' : 'text-slate-700'}`}
                              dangerouslySetInnerHTML={{ __html: processPostContent(post.content) }}
                            />
                            {/* Reactions */}
                            <div className={`flex flex-wrap gap-2 pt-2 border-t ${isDark ? 'border-white/10' : 'border-slate-200'}`}>
                              {REACTION_TYPES.map((type) => {
                                const count = postReactions[type] || 0;
                                const isReacted = alreadyReacted.includes(type);
                                
                                return (
                                  <motion.button
                                    key={type}
                                    whileHover={{ scale: 1.1 }}
                                    whileTap={{ scale: 0.95 }}
                                    onClick={() => handleReaction(post.id, type)}
                                    disabled={isReacted}
                                    className={`flex items-center gap-1 px-2 py-1 rounded-lg text-sm transition-all ${
                                      isReacted
                                        ? isDark 
                                          ? 'bg-indigo-500/30 text-indigo-300' 
                                          : 'bg-indigo-100 text-indigo-700'
                                        : isDark 
                                          ? 'bg-white/5 hover:bg-white/10 text-white/60 hover:text-white'
                                          : 'bg-slate-200 hover:bg-slate-300 text-slate-500 hover:text-slate-700'
                                    }`}
                                  >
                                    <span>{getReactionEmoji(type)}</span>
                                    {count > 0 && <span className="text-xs">{count}</span>}
                                  </motion.button>
                                );
                              })}
                            </div>
                          </>
                        )}
                      </motion.div>
                    );
                  })}
                </AnimatePresence>
              </div>

              {/* Pagination */}
              {totalPages > 1 && (
                <div className="flex items-center justify-center gap-2 mt-6">
                  <Button
                    variant="outline"
                    onClick={() => setPage(p => Math.max(1, p - 1))}
                    disabled={page === 1}
                  >
                    前へ
                  </Button>
                  <span className={`text-sm ${isDark ? 'text-white/60' : 'text-slate-600'}`}>
                    {page} / {totalPages}
                  </span>
                  <Button
                    variant="outline"
                    onClick={() => setPage(p => Math.min(totalPages, p + 1))}
                    disabled={page === totalPages}
                  >
                    次へ
                  </Button>
                </div>
              )}
            </CardContent>
          </Card>

          {/* Post Form */}
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.3 }}
          >
            <Card className={isDark ? '' : 'bg-white border-slate-300 shadow-md'}>
              <CardHeader className={`border-b ${isDark ? 'border-white/10' : 'border-slate-200'}`}>
                <CardTitle className={`text-lg flex items-center gap-2 ${isDark ? '' : 'text-slate-800'}`}>
                  <Send className={`w-5 h-5 ${isDark ? 'text-indigo-400' : 'text-indigo-600'}`} />
                  書き込む
                </CardTitle>
              </CardHeader>
              <CardContent className="pt-4">
                {isArchived ? (
                  <div className="flex items-center gap-3 p-4 bg-red-500/10 border border-red-500/30 rounded-lg text-red-500">
                    <AlertCircle className="w-5 h-5 flex-shrink-0" />
                    <p>このスレッドは書き込みができません（1000レス到達または終了済み）</p>
                  </div>
                ) : (
                  <form onSubmit={handleSubmit} className="space-y-4">
                    {error && (
                      <motion.div
                        initial={{ opacity: 0 }}
                        animate={{ opacity: 1 }}
                        className="p-4 bg-red-500/10 border border-red-500/30 rounded-lg text-red-500 text-sm flex items-center gap-2"
                      >
                        <AlertCircle className="w-4 h-4" />
                        {error}
                      </motion.div>
                    )}

                    <div className="grid gap-4 sm:grid-cols-2">
                      <div className="space-y-2">
                        <Label htmlFor="name" className={isDark ? 'text-white/80' : 'text-slate-700'}>名前</Label>
                        <Input
                          id="name"
                          placeholder="名無しさん"
                          value={formData.name}
                          onChange={(e) => setFormData({ ...formData, name: e.target.value })}
                          maxLength={50}
                          className={isDark ? 'bg-white/5 border-white/20 focus:border-indigo-500' : 'bg-white border-slate-300 focus:border-indigo-500'}
                        />
                      </div>
                      <div className="space-y-2">
                        <Label htmlFor="email" className={isDark ? 'text-white/80' : 'text-slate-700'}>メール</Label>
                        <Input
                          id="email"
                          placeholder="sage"
                          value={formData.email}
                          onChange={(e) => setFormData({ ...formData, email: e.target.value })}
                          maxLength={50}
                          className={isDark ? 'bg-white/5 border-white/20 focus:border-indigo-500' : 'bg-white border-slate-300 focus:border-indigo-500'}
                        />
                        <p className={`text-xs ${isDark ? 'text-white/30' : 'text-slate-400'}`}>「sage」でスレッドが上がりません</p>
                      </div>
                    </div>

                    <div className="space-y-2">
                      <Label htmlFor="content" className={isDark ? 'text-white/80' : 'text-slate-700'}>本文 *</Label>
                      <Textarea
                        id="content"
                        placeholder="本文を入力（1000文字以内）&#10;&#10;>>1 のようにレスアンカーが使えます"
                        value={formData.content}
                        onChange={(e) => setFormData({ ...formData, content: e.target.value })}
                        maxLength={1000}
                        rows={5}
                        required
                        className={isDark ? 'bg-white/5 border-white/20 focus:border-indigo-500' : 'bg-white border-slate-300 focus:border-indigo-500'}
                      />
                      <p className={`text-xs ${isDark ? 'text-white/30' : 'text-slate-400'}`}>
                        {formData.content.length} / 1000文字
                      </p>
                    </div>

                    <div className="flex justify-end">
                      <Button type="submit" disabled={submitting} className="gap-2">
                        {submitting ? (
                          <>
                            <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white"></div>
                            投稿中...
                          </>
                        ) : (
                          <>
                            <Send className="w-4 h-4" />
                            書き込む
                          </>
                        )}
                      </Button>
                    </div>
                  </form>
                )}
              </CardContent>
            </Card>
          </motion.div>
        </main>

        {/* Footer */}
        <footer className={`relative z-10 mt-8 border-t ${
          isDark 
            ? 'border-white/10 bg-black/20 backdrop-blur-xl' 
            : 'border-slate-300 bg-white'
        }`}>
          <div className={`container mx-auto px-4 py-4 text-center text-sm ${isDark ? 'text-white/30' : 'text-slate-500'}`}>
            <p>© 2026 5chBBS - 完全匿名掲示板</p>
          </div>
        </footer>
      </div>
    </>
  );
}
