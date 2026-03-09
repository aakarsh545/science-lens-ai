# Vercel Deployment Guide for Science Lens

## Environment Variables Required

Add these in your Vercel Project Settings → Environment Variables:

```
VITE_SUPABASE_URL=https://kljndbehjwfdyewgxgaw.supabase.co
VITE_SUPABASE_PUBLISHABLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtsam5kYmVoandmZHlld2d4Z2F3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjY1NTk1MTksImV4cCI6MjA4MjEzNTUxOX0.3R0SkWwe-uExB1SCOwyb1T3DThBWUYW-1MyAPkhJb8o
VITE_SUPABASE_PROJECT_ID=kljndbehjwfdyewgxgaw
```

## Deployment Steps

### Option 1: Using Vercel CLI (Recommended)

1. Login to Vercel:
```bash
vercel login
```

2. Deploy:
```bash
vercel --prod
```

3. Follow the prompts to set up your project

### Option 2: Using Vercel Dashboard

1. Go to https://vercel.com/new
2. Import your Git repository or upload project
3. Add environment variables (see above)
4. Click "Deploy"

## Custom Domain Setup

After deployment:

1. Go to your Project Settings → Domains
2. Click "Add Domain"
3. Enter: `scilens.page.gd`
4. Vercel will show you DNS records to add
5. Go to your domain registrar (where you bought scilens.page.gd)
6. Add the DNS records (usually a CNAME pointing to cname.vercel-dns.com)

## Build Output

- **Output Directory:** `dist`
- **Build Command:** `npm run build`
- **Install Command:** `npm install`

## Troubleshooting

If you see errors:
1. Make sure all environment variables are set
2. Make sure VITE_SUPABASE_PUBLISHABLE_KEY is the full JWT token
3. Check build logs in Vercel dashboard
