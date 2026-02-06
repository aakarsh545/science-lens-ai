#!/bin/bash

echo "🚀 SCIENCE LENS - VERCEL DEPLOYMENT SCRIPT"
echo "=========================================="
echo ""

# Check if logged in to Vercel
echo "📋 Step 1: Checking Vercel login status..."
if ! vercel whoami &>/dev/null; then
    echo "⚠️  You are not logged in to Vercel."
    echo ""
    echo "Please login now:"
    echo "  1. A browser will open"
    echo "  2. Login to your Vercel account (or create one)"
    echo "  3. Come back here when done"
    echo ""
    read -p "Press Enter to open browser for login..."
    vercel login
    echo ""
fi

echo "✅ Logged in to Vercel"
echo ""

# Deploy to Vercel
echo "📦 Step 2: Deploying to Vercel..."
echo ""

# Deploy with production flag
vercel --prod --yes

echo ""
echo "✅ Deployment complete!"
echo ""
echo "🔧 NEXT STEPS:"
echo ""
echo "1. Add Environment Variables:"
echo "   Go to: https://vercel.com/dashboard"
echo "   Select your project → Settings → Environment Variables"
echo "   Add these:"
echo ""
echo "   VITE_SUPABASE_URL=https://kljndbehjwfdyewgxgaw.supabase.co"
echo "   VITE_SUPABASE_PUBLISHABLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtsam5kYmVoandmZHlld2d4Z2F3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjY1NTk1MTksImV4cCI6MjA4MjEzNTUxOX0.3R0SkWwe-uExB1SCOwyb1T3DThBWUYW-1MyAPkhJb8o"
echo "   VITE_SUPABASE_PROJECT_ID=kljndbehjwfdyewgxgaw"
echo ""
echo "2. Redeploy after adding env vars:"
echo "   vercel --prod --yes"
echo ""
echo "3. Add Custom Domain (scilens.page.gd):"
echo "   Go to: Project Settings → Domains → Add Domain"
echo "   Enter: scilens.page.gd"
echo "   Follow DNS instructions provided"
echo ""
