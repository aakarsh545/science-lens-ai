import { useState } from 'react'
import { useNavigate, Link } from 'react-router-dom'
import { supabase } from '@/integrations/supabase/client'

export default function LoginPage() {
  const navigate = useNavigate()
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState<string | null>(null)

  const handleSignIn = async (e: React.FormEvent) => {
    e.preventDefault()
    setError(null)
    setLoading(true)

    try {
      const { data, error: signInError } = await supabase.auth.signInWithPassword({
        email: email.trim(),
        password,
      })

      if (signInError) {
        if (signInError.message === 'Invalid login credentials') {
          setError('Invalid email or password')
        } else {
          setError(signInError.message)
        }
        setLoading(false)
        return
      }

      if (data.session) {
        // Successfully signed in - redirect to dashboard
        navigate('/dashboard', { replace: true })
      }
    } catch (err) {
      setError('An unexpected error occurred. Please try again.')
    } finally {
      setLoading(false)
    }
  }

  const handleGoogleSignIn = async () => {
    setError(null)
    setLoading(true)

    const { error } = await supabase.auth.signInWithOAuth({
      provider: 'google',
      options: {
        redirectTo: window.location.origin + '/auth/callback',
      },
    })

    if (error) {
      setError(error.message)
      setLoading(false)
    }
  }

  const canSubmit = email && password && !loading

  return (
    <div className="min-h-screen bg-slate-950">
      <div className="min-h-screen flex items-center justify-center px-4 py-24">
        <div className="max-w-md w-full">
          <div className="text-center mb-12">
            <h2 className="text-3xl font-semibold text-white mb-2 tracking-tight">
              Welcome back
            </h2>
            <p className="text-slate-400">Sign in to continue learning</p>
          </div>

          {error && (
            <div className="mb-4 rounded-lg bg-red-500/10 border border-red-500/50 p-3 text-sm text-red-400">
              {error}
            </div>
          )}

          <button
            type="button"
            onClick={handleGoogleSignIn}
            disabled={loading}
            className="w-full rounded-lg bg-white px-4 py-3 text-sm font-medium text-slate-900 hover:bg-slate-100 transition-all disabled:cursor-not-allowed disabled:opacity-50 focus:outline-none"
          >
            <span className="flex items-center justify-center gap-3">
              <svg width="18" height="18" viewBox="0 0 48 48" aria-hidden="true">
                <path fill="#EA4335" d="M24 9.5c3.54 0 6.73 1.22 9.24 3.61l6.9-6.9C36.02 2.38 30.37 0 24 0 14.62 0 6.51 5.38 2.56 13.22l8.02 6.23C12.47 13.38 17.77 9.5 24 9.5z" />
                <path fill="#4285F4" d="M46.5 24c0-1.6-.14-3.14-.4-4.64H24v9.06h12.66c-.55 2.96-2.22 5.48-4.73 7.18l7.27 5.64C43.2 37.06 46.5 31.04 46.5 24z" />
                <path fill="#FBBC05" d="M10.58 28.55A14.5 14.5 0 0 1 9.5 24c0-1.58.27-3.1.75-4.55l-8.02-6.23A23.95 23.95 0 0 0 0 24c0 3.87.93 7.53 2.56 10.78l8.02-6.23z" />
                <path fill="#34A853" d="M24 48c6.37 0 11.72-2.1 15.62-5.76l-7.27-5.64c-2.03 1.36-4.63 2.16-8.35 2.16-6.23 0-11.53-3.88-13.42-9.21l-8.02 6.23C6.51 42.62 14.62 48 24 48z" />
              </svg>
              Continue with Google
            </span>
          </button>

          <div className="my-6 flex items-center gap-3">
            <div className="h-px flex-1 bg-slate-800" />
            <span className="text-xs uppercase tracking-widest text-slate-500">or</span>
            <div className="h-px flex-1 bg-slate-800" />
          </div>

          <form onSubmit={handleSignIn} className="space-y-4">
            <div>
              <label htmlFor="email" className="mb-1.5 block text-sm font-medium text-slate-300">
                Email
              </label>
              <input
                id="email"
                type="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                required
                className="w-full rounded-lg border border-slate-700 bg-slate-800 px-3 py-2 text-sm text-white placeholder-slate-500 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
                placeholder="you@example.com"
              />
            </div>

            <div>
              <label htmlFor="password" className="mb-1.5 block text-sm font-medium text-slate-300">
                Password
              </label>
              <input
                id="password"
                type="password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                required
                className="w-full rounded-lg border border-slate-700 bg-slate-800 px-3 py-2 text-sm text-white placeholder-slate-500 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
                placeholder="Enter your password"
              />
            </div>

            <button
              type="submit"
              disabled={!canSubmit}
              className="w-full rounded-lg bg-gradient-to-r from-blue-600 to-indigo-600 px-4 py-3 text-sm font-medium text-white hover:from-blue-500 hover:to-indigo-500 transition-all disabled:cursor-not-allowed disabled:opacity-50 focus:outline-none"
            >
              {loading ? (
                <div className="flex items-center justify-center">
                  <div className="h-4 w-4 animate-spin rounded-full border-2 border-white/30 border-t-white" />
                </div>
              ) : (
                'Sign In'
              )}
            </button>
          </form>

          <div className="mt-6 text-center">
            <p className="text-slate-400 text-sm">
              Don't have an account?{' '}
              <Link to="/signup" className="text-blue-400 hover:text-blue-300 font-medium transition-colors">
                Sign Up
              </Link>
            </p>
          </div>
        </div>
      </div>
    </div>
  )
}
