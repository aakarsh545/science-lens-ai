import { useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
import { supabase } from '@/integrations/supabase/client'

export default function AuthCallback() {
  const navigate = useNavigate()

  useEffect(() => {
    supabase.auth.getSession().then(async ({ data: { session } }) => {
      if (session) {
        const { data: profile } = await supabase
          .from('profiles')
          .select('user_id')
          .eq('user_id', session.user.id)
          .maybeSingle()

        if (!profile) {
          await supabase.from('profiles').insert({
            user_id: session.user.id,
            display_name:
              session.user.user_metadata?.full_name ||
              session.user.user_metadata?.name ||
              'User',
            avatar_url: session.user.user_metadata?.avatar_url || null,
            credits: 100,
            level: 1,
          })
        }
        navigate('/dashboard')
      } else {
        navigate('/login')
      }
    })
  }, [navigate])

  return (
    <div className="flex items-center justify-center h-screen bg-gray-950 text-white">
      <p>Signing you in...</p>
    </div>
  )
}

