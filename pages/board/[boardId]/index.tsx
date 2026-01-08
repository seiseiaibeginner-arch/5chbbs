import { useEffect, useState } from 'react';
import Head from 'next/head';
import Link from 'next/link';
import { useRouter } from 'next/router';
import { motion } from 'framer-motion';
import { ArrowLeft, MessageSquare, Plus, Clock, TrendingUp, Flame, Star, Moon, Sun } from 'lucide-react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Skeleton } from '@/components/ui/skeleton';
import { Separator } from '@/components/ui/separator';
import { formatDate, getBoardIcon, isHot } from '@/lib/utils';

interface Thread {
  id: number;
  title: string;
  post_count: number;
  created_at: string;
  last_posted_at: string;
}

interface Board {
  id: number;
  name: string;
  description: string;
}

interface FavoriteThread {
  id: number;
  title: string;
  boardId: number;
  boardName: string;
  postCount: number;
  lastPostedAt: string;
}

export default function BoardPage() {
  const router = useRouter();
  const { boardId } = router.query;
  const [board, setBoard] = useState<Board | null>(null);
  const [threads, setThreads] = useState<Thread[]>([]);
  const [loading, setLoading] = useState(true);
  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [favorites, setFavorites] = useState<number[]>([]);
  const [isDark, setIsDark] = useState(true);

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

  // お気に入り読み込み
  useEffect(() => {
    const savedFavorites = JSON.parse(localStorage.getItem('favorites') || '[]');
    setFavorites(savedFavorites);
  }, []);

  // お気に入り切り替え
  const toggleFavorite = (thread: Thread, e: React.MouseEvent) => {
    e.preventDefault();
    e.stopPropagation();
    
    const favoriteIds = JSON.parse(localStorage.getItem('favorites') || '[]');
    const favoriteThreads = JSON.parse(localStorage.getItem('favoriteThreads') || '[]');
    
    if (favoriteIds.includes(thread.id)) {
      // 削除
      const newFavoriteIds = favoriteIds.filter((id: number) => id !== thread.id);
      const newFavoriteThreads = favoriteThreads.filter((t: FavoriteThread) => t.id !== thread.id);
      localStorage.setItem('favorites', JSON.stringify(newFavoriteIds));
      localStorage.setItem('favoriteThreads', JSON.stringify(newFavoriteThreads));
      setFavorites(newFavoriteIds);
    } else {
      // 追加
      const newFavoriteIds = [...favoriteIds, thread.id];
      const newFavoriteThread: FavoriteThread = {
        id: thread.id,
        title: thread.title,
        boardId: Number(boardId),
        boardName: board?.name || '',
        postCount: thread.post_count,
        lastPostedAt: thread.last_posted_at,
      };
      const newFavoriteThreads = [...favoriteThreads.filter((t: FavoriteThread) => t.id !== thread.id), newFavoriteThread];
      localStorage.setItem('favorites', JSON.stringify(newFavoriteIds));
      localStorage.setItem('favoriteThreads', JSON.stringify(newFavoriteThreads));
      setFavorites(newFavoriteIds);
    }
  };

  useEffect(() => {
    if (boardId) {
      fetchBoard();
      fetchThreads();
    }
  }, [boardId, page]);

  const fetchBoard = async () => {
    try {
      const response = await fetch(`/api/boards/${boardId}`);
      const data = await response.json();
      setBoard(data);
    } catch (error) {
      console.error('Error fetching board:', error);
    }
  };

  const fetchThreads = async () => {
    try {
      const response = await fetch(`/api/boards/${boardId}/threads?page=${page}`);
      const data = await response.json();
      setThreads(data.threads || []);
      setTotalPages(data.totalPages || 1);
    } catch (error) {
      console.error('Error fetching threads:', error);
      setThreads([]);
    } finally {
      setLoading(false);
    }
  };

  if (loading || !board) {
    return (
      <div className={`min-h-screen flex items-center justify-center ${isDark ? 'bg-[#0a0a0f]' : 'bg-slate-200'}`}>
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-indigo-500"></div>
      </div>
    );
  }

  return (
    <>
      <Head>
        <title>{board.name} - 5chBBS</title>
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
              <Link href="/">
                <Button variant="ghost" size="icon" className={isDark ? 'text-white/60 hover:text-white' : 'text-slate-600 hover:text-slate-900 hover:bg-slate-200'}>
                  <ArrowLeft className="w-5 h-5" />
                </Button>
              </Link>
              <div className="flex-1">
                <div className="flex items-center gap-2">
                  <span className="text-2xl">{getBoardIcon(board.name)}</span>
                  <h1 className={`text-2xl font-bold ${isDark ? 'text-white' : 'text-slate-800'}`}>{board.name}</h1>
                </div>
                <p className={`text-sm ${isDark ? 'text-white/50' : 'text-slate-500'}`}>{board.description}</p>
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
              <Link href={`/board/${boardId}/new`}>
                <Button className="gap-2">
                  <Plus className="w-4 h-4" />
                  新規スレッド
                </Button>
              </Link>
            </div>
          </div>
        </header>

        {/* Main Content */}
        <main className="relative z-10 container mx-auto px-4 py-8">
          <Card className={isDark ? '' : 'bg-white border-slate-300 shadow-md'}>
            <CardHeader className={`border-b ${isDark ? 'border-white/10' : 'border-slate-200'}`}>
              <CardTitle className={`flex items-center gap-2 text-lg ${isDark ? '' : 'text-slate-800'}`}>
                <TrendingUp className={`w-5 h-5 ${isDark ? 'text-indigo-400' : 'text-indigo-600'}`} />
                スレッド一覧
              </CardTitle>
            </CardHeader>
            <CardContent className="pt-4">
              {threads.length === 0 ? (
                <div className={`text-center py-12 ${isDark ? 'text-white/50' : 'text-slate-400'}`}>
                  <MessageSquare className="w-12 h-12 mx-auto mb-4 opacity-50" />
                  <p>まだスレッドがありません</p>
                  <p className="text-sm mt-2">最初のスレッドを立ててみましょう！</p>
                </div>
              ) : (
                <div className="space-y-2">
                  {threads.map((thread, index) => (
                    <motion.div
                      key={thread.id}
                      initial={{ opacity: 0, x: -20 }}
                      animate={{ opacity: 1, x: 0 }}
                      transition={{ delay: index * 0.03 }}
                    >
                      <Link href={`/board/${boardId}/thread/${thread.id}`}>
                        <div className={`group p-4 rounded-xl transition-all duration-200 border border-transparent ${
                          isDark 
                            ? 'hover:bg-white/5 hover:border-white/10' 
                            : 'hover:bg-slate-100 hover:border-slate-300'
                        }`}>
                          <div className="flex items-start justify-between gap-4">
                            <div className="flex-1 min-w-0">
                              <div className="flex items-center gap-2 mb-1">
                                {isHot(thread.post_count, thread.created_at) && (
                                  <Badge variant="hot" className="text-xs">
                                    <Flame className="w-3 h-3 mr-1" />
                                    HOT
                                  </Badge>
                                )}
                                <h3 className={`font-medium transition-colors truncate ${
                                  isDark 
                                    ? 'text-white group-hover:text-indigo-300' 
                                    : 'text-slate-800 group-hover:text-indigo-600'
                                }`}>
                                  {thread.title}
                                </h3>
                              </div>
                              <div className={`flex items-center gap-4 text-xs ${isDark ? 'text-white/40' : 'text-slate-500'}`}>
                                <span className="flex items-center gap-1">
                                  <MessageSquare className="w-3 h-3" />
                                  {thread.post_count} レス
                                </span>
                                <span className="flex items-center gap-1">
                                  <Clock className="w-3 h-3" />
                                  {formatDate(thread.last_posted_at)}
                                </span>
                              </div>
                            </div>
                            <Button
                              variant="ghost"
                              size="icon"
                              onClick={(e) => toggleFavorite(thread, e)}
                              className={`shrink-0 ${
                                favorites.includes(thread.id)
                                  ? 'text-amber-500 hover:text-amber-600'
                                  : isDark ? 'text-white/30 hover:text-amber-400' : 'text-slate-300 hover:text-amber-500'
                              }`}
                            >
                              <Star className={`w-5 h-5 ${favorites.includes(thread.id) ? 'fill-current' : ''}`} />
                            </Button>
                          </div>
                        </div>
                      </Link>
                      {index < threads.length - 1 && <Separator className={isDark ? 'bg-white/5' : 'bg-slate-200'} />}
                    </motion.div>
                  ))}
                </div>
              )}

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
        </main>
      </div>
    </>
  );
}
