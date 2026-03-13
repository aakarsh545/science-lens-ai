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
          .select('user_id, username')
          .eq('user_id', session.user.id)
          .maybeSingle()

        if (!profile || !profile.username) {
          navigate('/signup?step=5', { replace: true })
          return
        }

        navigate('/dashboard', { replace: true })
      } else {
        navigate('/login', { replace: true })
      }
    })
  }, [navigate])

  return (
    <div className="flex items-center justify-center h-screen bg-gray-950 text-white">
      <p>Signing you in...</p>
    </div>
  )
}
