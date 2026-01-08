import { useEffect, useState } from 'react';
import Head from 'next/head';
import Link from 'next/link';
import { motion } from 'framer-motion';
import { MessageSquare, TrendingUp, Sparkles, Star, Moon, Sun, Clock } from 'lucide-react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Skeleton } from '@/components/ui/skeleton';
import { getBoardIcon, getCategoryIcon, formatDate } from '@/lib/utils';

interface Board {
  id: number;
  name: string;
  description: string;
  category: string;
  thread_count: number;
  last_updated: string | null;
}

interface FavoriteThread {
  id: number;
  title: string;
  boardId: number;
  boardName: string;
  postCount: number;
  lastPostedAt: string;
}

interface GroupedBoards {
  [category: string]: Board[];
}

export default function Home() {
  const [boards, setBoards] = useState<Board[]>([]);
  const [loading, setLoading] = useState(true);
  const [isDark, setIsDark] = useState(true);
  const [favorites, setFavorites] = useState<FavoriteThread[]>([]);

  // テーマの初期化
  useEffect(() => {
    const savedTheme = localStorage.getItem('theme');
    const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
    const initialDark = savedTheme ? savedTheme === 'dark' : prefersDark;
    setIsDark(initialDark);
    document.documentElement.classList.toggle('dark', initialDark);
  }, []);

  // お気に入りスレッドの読み込み
  useEffect(() => {
    const loadFavorites = async () => {
      const favoriteIds = JSON.parse(localStorage.getItem('favorites') || '[]');
      const favoriteThreads = JSON.parse(localStorage.getItem('favoriteThreads') || '[]');
      setFavorites(favoriteThreads.filter((t: FavoriteThread) => favoriteIds.includes(t.id)));
    };
    loadFavorites();
  }, []);

  // テーマ切り替え
  const toggleTheme = () => {
    const newDark = !isDark;
    setIsDark(newDark);
    localStorage.setItem('theme', newDark ? 'dark' : 'light');
    document.documentElement.classList.toggle('dark', newDark);
  };

  // お気に入り削除
  const removeFavorite = (threadId: number) => {
    const favoriteIds = JSON.parse(localStorage.getItem('favorites') || '[]');
    const newFavoriteIds = favoriteIds.filter((id: number) => id !== threadId);
    localStorage.setItem('favorites', JSON.stringify(newFavoriteIds));
    
    const favoriteThreads = JSON.parse(localStorage.getItem('favoriteThreads') || '[]');
    const newFavoriteThreads = favoriteThreads.filter((t: FavoriteThread) => t.id !== threadId);
    localStorage.setItem('favoriteThreads', JSON.stringify(newFavoriteThreads));
    
    setFavorites(favorites.filter(f => f.id !== threadId));
  };

  useEffect(() => {
    fetchBoards();
  }, []);

  const fetchBoards = async () => {
    try {
      const response = await fetch('/api/boards');
      const data = await response.json();
      setBoards(Array.isArray(data) ? data : []);
    } catch (error) {
      console.error('Error fetching boards:', error);
      setBoards([]);
    } finally {
      setLoading(false);
    }
  };

  // カテゴリごとにグループ化
  const groupedBoards = boards.reduce<GroupedBoards>((acc, board) => {
    if (!acc[board.category]) {
      acc[board.category] = [];
    }
    acc[board.category].push(board);
    return acc;
  }, {});

  // カテゴリも最終更新順にソート
  const sortedCategories = Object.keys(groupedBoards).sort((a, b) => {
    const aLatest = groupedBoards[a][0]?.last_updated;
    const bLatest = groupedBoards[b][0]?.last_updated;
    if (!aLatest && !bLatest) return 0;
    if (!aLatest) return 1;
    if (!bLatest) return -1;
    return new Date(bLatest).getTime() - new Date(aLatest).getTime();
  });

  return (
    <>
      <Head>
        <title>5chBBS - 匿名掲示板</title>
        <meta name="description" content="5ch風の匿名掲示板" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
      </Head>

      <div className={`min-h-screen transition-colors duration-300 ${isDark ? 'bg-[#0a0a0f]' : 'bg-slate-200'}`}>
        {/* Animated background */}
        <div className="fixed inset-0 overflow-hidden pointer-events-none">
          {isDark ? (
            <>
              <div className="absolute -top-40 -right-40 w-80 h-80 rounded-full blur-[100px] bg-indigo-500/20" />
              <div className="absolute top-1/2 -left-40 w-80 h-80 rounded-full blur-[100px] bg-cyan-500/20" />
              <div className="absolute -bottom-40 right-1/3 w-80 h-80 rounded-full blur-[100px] bg-purple-500/20" />
            </>
          ) : (
            <>
              <div className="absolute -top-40 -right-40 w-96 h-96 rounded-full blur-[150px] bg-indigo-400/20" />
              <div className="absolute top-1/2 -left-40 w-96 h-96 rounded-full blur-[150px] bg-sky-400/15" />
              <div className="absolute -bottom-40 right-1/3 w-96 h-96 rounded-full blur-[150px] bg-violet-400/15" />
            </>
          )}
        </div>

        {/* Header */}
        <header className={`relative z-10 border-b ${
          isDark 
            ? 'border-white/10 bg-black/20 backdrop-blur-xl' 
            : 'border-slate-300 bg-white shadow-sm'
        }`}>
          <div className="container mx-auto px-4 py-6">
            <div className="flex items-center justify-between">
              <motion.div
                initial={{ opacity: 0, y: -20 }}
                animate={{ opacity: 1, y: 0 }}
                className="flex items-center gap-3"
              >
                <div className="relative">
                  <MessageSquare className={`w-10 h-10 ${isDark ? 'text-indigo-400' : 'text-indigo-600'}`} />
                  <Sparkles className={`w-4 h-4 absolute -top-1 -right-1 ${isDark ? 'text-cyan-400' : 'text-amber-500'}`} />
                </div>
                <div>
                  <h1 className={`text-3xl font-bold ${isDark ? 'gradient-text' : 'text-slate-800'}`}>5chBBS</h1>
                  <p className={`text-sm ${isDark ? 'text-white/60' : 'text-slate-500'}`}>匿名で自由に語り合える掲示板</p>
                </div>
              </motion.div>
              
              {/* Theme Toggle */}
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
            </div>
          </div>
        </header>

        {/* Main Content */}
        <main className="relative z-10 container mx-auto px-4 py-8">
          {/* Favorites Section */}
          {favorites.length > 0 && (
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              className="mb-8"
            >
              <Card className={`overflow-hidden ${
                isDark 
                  ? '' 
                  : 'bg-white border-slate-300 shadow-md'
              }`}>
                <CardHeader className={`border-b ${
                  isDark 
                    ? 'border-white/10 bg-yellow-500/10' 
                    : 'border-slate-200 bg-amber-50'
                }`}>
                  <CardTitle className="text-xl flex items-center gap-2">
                    <Star className="w-6 h-6 text-amber-500 fill-amber-500" />
                    <span className={isDark ? 'text-yellow-400' : 'text-amber-700'}>お気に入りスレッド</span>
                  </CardTitle>
                </CardHeader>
                <CardContent className="pt-4">
                  <div className="space-y-2">
                    {favorites.map((thread) => (
                      <div
                        key={thread.id}
                        className={`group flex items-center justify-between p-3 rounded-lg transition-all ${
                          isDark ? 'hover:bg-white/5' : 'hover:bg-slate-100'
                        }`}
                      >
                        <Link href={`/board/${thread.boardId}/thread/${thread.id}`} className="flex-1 min-w-0">
                          <div className="flex items-center gap-3">
                            <Badge variant="outline" className={`text-xs shrink-0 ${!isDark && 'border-slate-400 text-slate-600 bg-slate-100'}`}>
                              {thread.boardName}
                            </Badge>
                            <span className={`font-medium truncate ${
                              isDark 
                                ? 'text-white group-hover:text-indigo-300' 
                                : 'text-slate-800 group-hover:text-indigo-600'
                            }`}>
                              {thread.title}
                            </span>
                          </div>
                          <div className={`flex items-center gap-3 mt-1 text-xs ${isDark ? 'text-white/40' : 'text-slate-500'}`}>
                            <span className="flex items-center gap-1">
                              <MessageSquare className="w-3 h-3" />
                              {thread.postCount} レス
                            </span>
                            {thread.lastPostedAt && (
                              <span className="flex items-center gap-1">
                                <Clock className="w-3 h-3" />
                                {formatDate(thread.lastPostedAt)}
                              </span>
                            )}
                          </div>
                        </Link>
                        <Button
                          variant="ghost"
                          size="icon"
                          onClick={(e) => {
                            e.preventDefault();
                            removeFavorite(thread.id);
                          }}
                          className="shrink-0 text-amber-500 hover:text-amber-600"
                        >
                          <Star className="w-4 h-4 fill-current" />
                        </Button>
                      </div>
                    ))}
                  </div>
                </CardContent>
              </Card>
            </motion.div>
          )}

          {loading ? (
            <div className="space-y-8">
              {[1, 2, 3].map((i) => (
                <Card key={i} className={!isDark ? 'bg-white border-slate-300 shadow-md' : ''}>
                  <CardHeader>
                    <Skeleton className="h-8 w-32" />
                  </CardHeader>
                  <CardContent>
                    <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
                      {[1, 2, 3].map((j) => (
                        <Skeleton key={j} className="h-32 rounded-xl" />
                      ))}
                    </div>
                  </CardContent>
                </Card>
              ))}
            </div>
          ) : (
            <div className="space-y-8">
              {sortedCategories.map((category, categoryIndex) => {
                const categoryBoards = groupedBoards[category];
                return (
                  <motion.div
                    key={category}
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ delay: categoryIndex * 0.1 }}
                  >
                    <Card className={`overflow-hidden ${
                      isDark 
                        ? '' 
                        : 'bg-white border-slate-300 shadow-md'
                    }`}>
                      <CardHeader className={`border-b ${
                        isDark 
                          ? 'border-white/10 bg-white/5' 
                          : 'border-slate-200 bg-slate-50'
                      }`}>
                        <CardTitle className="text-xl flex items-center gap-2">
                          <span className="text-2xl">{getCategoryIcon(category)}</span>
                          <span className={isDark ? 'gradient-text' : 'text-slate-700'}>{category}</span>
                        </CardTitle>
                      </CardHeader>
                      <CardContent className="pt-6">
                        <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
                          {categoryBoards.map((board, index) => (
                            <motion.div
                              key={board.id}
                              initial={{ opacity: 0, scale: 0.9 }}
                              animate={{ opacity: 1, scale: 1 }}
                              transition={{ delay: (categoryIndex * 0.1) + (index * 0.05) }}
                              whileHover={{ scale: 1.02, y: -4 }}
                              whileTap={{ scale: 0.98 }}
                            >
                              <Link href={`/board/${board.id}`}>
                                <div className={`group relative h-full p-4 rounded-xl border transition-all duration-300 cursor-pointer overflow-hidden ${
                                  isDark 
                                    ? 'bg-white/5 border-white/10 hover:border-indigo-500/50 hover:bg-white/10' 
                                    : 'bg-slate-50 border-slate-300 hover:border-indigo-400 hover:bg-white hover:shadow-lg'
                                }`}>
                                  {/* Glow effect on hover */}
                                  <div className={`absolute inset-0 bg-gradient-to-br transition-all duration-300 ${
                                    isDark 
                                      ? 'from-indigo-500/0 to-cyan-500/0 group-hover:from-indigo-500/10 group-hover:to-cyan-500/10'
                                      : 'from-indigo-500/0 to-purple-500/0 group-hover:from-indigo-500/5 group-hover:to-purple-500/5'
                                  }`} />
                                  
                                  <div className="relative">
                                    <div className="flex items-center gap-2 mb-2">
                                      <span className="text-2xl">{getBoardIcon(board.name)}</span>
                                      <h3 className={`font-bold transition-colors ${
                                        isDark 
                                          ? 'text-white group-hover:text-indigo-300' 
                                          : 'text-slate-800 group-hover:text-indigo-600'
                                      }`}>
                                        {board.name}
                                      </h3>
                                    </div>
                                    <p className={`text-sm mb-3 line-clamp-2 ${isDark ? 'text-white/50' : 'text-slate-500'}`}>
                                      {board.description}
                                    </p>
                                    <div className="flex items-center gap-2">
                                      <Badge variant="outline" className={`text-xs ${!isDark && 'border-slate-400 text-slate-600 bg-white'}`}>
                                        <MessageSquare className="w-3 h-3 mr-1" />
                                        {board.thread_count || 0} スレッド
                                      </Badge>
                                      {board.thread_count >= 10 && (
                                        <Badge variant="hot" className="text-xs">
                                          <TrendingUp className="w-3 h-3 mr-1" />
                                          HOT
                                        </Badge>
                                      )}
                                    </div>
                                  </div>
                                </div>
                              </Link>
                            </motion.div>
                          ))}
                        </div>
                      </CardContent>
                    </Card>
                  </motion.div>
                );
              })}
            </div>
          )}
        </main>

        {/* Footer */}
        <footer className={`relative z-10 mt-16 border-t ${
          isDark 
            ? 'border-white/10 bg-black/20 backdrop-blur-xl' 
            : 'border-slate-300 bg-white'
        }`}>
          <div className={`container mx-auto px-4 py-6 text-center text-sm ${isDark ? 'text-white/40' : 'text-slate-500'}`}>
            <p>© 2026 5chBBS - 完全匿名掲示板</p>
          </div>
        </footer>
      </div>
    </>
  );
}
