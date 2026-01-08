import { useEffect, useState } from 'react';
import Head from 'next/head';
import Link from 'next/link';
import { useRouter } from 'next/router';
import { motion } from 'framer-motion';
import { ArrowLeft, Send, AlertCircle, FileText, Moon, Sun } from 'lucide-react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Textarea } from '@/components/ui/textarea';
import { Label } from '@/components/ui/label';

export default function NewThreadPage() {
  const router = useRouter();
  const { boardId } = router.query;
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [isDark, setIsDark] = useState(true);
  const [formData, setFormData] = useState({
    title: '',
    name: '',
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

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    setLoading(true);

    try {
      const response = await fetch(`/api/boards/${boardId}/threads`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(formData),
      });

      const data = await response.json();

      if (!response.ok) {
        throw new Error(data.error || 'スレッドの作成に失敗しました');
      }

      router.push(`/board/${boardId}/thread/${data.threadId}`);
    } catch (err: any) {
      setError(err.message);
      setLoading(false);
    }
  };

  return (
    <>
      <Head>
        <title>新規スレッド作成 - 5chBBS</title>
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
              <div className="flex-1">
                <h1 className={`text-2xl font-bold ${isDark ? 'text-white' : 'text-slate-800'}`}>新規スレッド作成</h1>
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
            </div>
          </div>
        </header>

        {/* Main Content */}
        <main className="relative z-10 container mx-auto px-4 py-8 max-w-3xl">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
          >
            <Card className={isDark ? '' : 'bg-white border-slate-300 shadow-md'}>
              <CardHeader className={`border-b ${isDark ? 'border-white/10' : 'border-slate-200'}`}>
                <CardTitle className={`flex items-center gap-2 ${isDark ? '' : 'text-slate-800'}`}>
                  <FileText className={`w-5 h-5 ${isDark ? 'text-indigo-400' : 'text-indigo-600'}`} />
                  スレッドを立てる
                </CardTitle>
                <CardDescription className={isDark ? '' : 'text-slate-500'}>
                  タイトルと最初の投稿内容を入力してください
                </CardDescription>
              </CardHeader>
              <CardContent className="pt-6">
                <form onSubmit={handleSubmit} className="space-y-6">
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

                  <div className="space-y-2">
                    <Label htmlFor="title" className={isDark ? 'text-white/80' : 'text-slate-700'}>スレッドタイトル *</Label>
                    <Input
                      id="title"
                      placeholder="タイトルを入力（100文字以内）"
                      value={formData.title}
                      onChange={(e) => setFormData({ ...formData, title: e.target.value })}
                      maxLength={100}
                      required
                      className={isDark ? 'bg-white/5 border-white/20 focus:border-indigo-500' : 'bg-white border-slate-300 focus:border-indigo-500'}
                    />
                  </div>

                  <div className="space-y-2">
                    <Label htmlFor="name" className={isDark ? 'text-white/80' : 'text-slate-700'}>名前（任意）</Label>
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
                    <Label htmlFor="content" className={isDark ? 'text-white/80' : 'text-slate-700'}>本文 *</Label>
                    <Textarea
                      id="content"
                      placeholder="本文を入力（1000文字以内）"
                      value={formData.content}
                      onChange={(e) => setFormData({ ...formData, content: e.target.value })}
                      maxLength={1000}
                      rows={8}
                      required
                      className={isDark ? 'bg-white/5 border-white/20 focus:border-indigo-500' : 'bg-white border-slate-300 focus:border-indigo-500'}
                    />
                    <p className={`text-xs ${isDark ? 'text-white/40' : 'text-slate-400'}`}>
                      {formData.content.length} / 1000文字
                    </p>
                  </div>

                  <div className="flex gap-3 justify-end">
                    <Link href={`/board/${boardId}`}>
                      <Button type="button" variant="outline">
                        キャンセル
                      </Button>
                    </Link>
                    <Button type="submit" disabled={loading} className="gap-2">
                      {loading ? (
                        <>
                          <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white"></div>
                          作成中...
                        </>
                      ) : (
                        <>
                          <Send className="w-4 h-4" />
                          スレッドを立てる
                        </>
                      )}
                    </Button>
                  </div>
                </form>
              </CardContent>
            </Card>

            {/* 注意事項 */}
            <Card className={`mt-6 ${isDark ? 'bg-indigo-500/10 border-indigo-500/30' : 'bg-indigo-50 border-indigo-200 shadow-md'}`}>
              <CardContent className="pt-6">
                <h3 className={`font-semibold mb-2 ${isDark ? 'text-indigo-300' : 'text-indigo-700'}`}>投稿する前に</h3>
                <ul className={`text-sm space-y-1 ${isDark ? 'text-white/60' : 'text-slate-600'}`}>
                  <li>• 同じタイトルのスレッドは作成できません</li>
                  <li>• 不適切な内容の投稿は削除される場合があります</li>
                  <li>• 投稿後の編集・削除はできません</li>
                </ul>
              </CardContent>
            </Card>
          </motion.div>
        </main>
      </div>
    </>
  );
}
