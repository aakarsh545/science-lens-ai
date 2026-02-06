# Backup Hosting Options for Science Lens AI

**Current Status:**
- **Current Site:** https://science-lens-ai-code.vercel.app
- **Desired Domain:** scilens.page.gd
- **Tech Stack:** React + Vite (SPA)
- **Previous Attempt:** InfinityFree (failed)

**Document Created:** January 25, 2026
**Purpose:** Backup hosting options in case Vercel custom domain doesn't work out

---

## Quick Comparison Table

| Platform | Bandwidth | Build Minutes | Custom Domains | SSL | File Limit | Best For |
|----------|-----------|---------------|----------------|-----|------------|----------|
| **Cloudflare Pages** | Unlimited | 500/month | 100 per project | Free | 20,000 files | High traffic, global CDN |
| **Netlify** | 100 GB/month | 300/month | Unlimited | Free | Unlimited | Easy setup, form handling |
| **Vercel** (current) | 100 GB/month | 6,000/month | Unlimited | Free | Unlimited | Next.js/React focus |
| **Firebase Hosting** | 10 GB/month | Limited | Unlimited | Free | Unlimited | Google ecosystem integration |
| **GitHub Pages** | 100 GB/month | Unlimited | 1 per repo | Free | 1 GB | Open source projects |

---

## Option 1: Cloudflare Pages (RECOMMENDED)

### Overview
Cloudflare Pages offers the most generous free tier with **unlimited bandwidth**, making it ideal for high-traffic React SPAs. It provides a global CDN with excellent performance.

### Free Tier Limits (2025)
- **Bandwidth:** Unlimited
- **Build Minutes:** 500 per month
- **Concurrent Builds:** 1
- **Custom Domains:** 100 per project
- **Files:** 20,000 per site
- **SSL:** Free automatic certificates
- **Price:** Free forever

### Pros
- Unlimited bandwidth (best in class)
- Excellent global CDN performance
- Automatic SSL certificates
- Supports SPA routing out of the box
- No build minute limit worries for typical usage
- Preview deployments for pull requests

### Cons
- 1 concurrent build (can queue during active development)
- 500 build minutes/month (may be tight for heavy CI/CD)
- Fewer framework integrations than Vercel/Netlify
- Build customization less advanced than Netlify

### Deployment Instructions

#### Step 1: Prepare Your Build
```bash
# Build your Vite React app locally first
npm run build

# Verify the dist folder exists
ls -la dist/
```

#### Step 2: Connect Repository
1. Go to [Cloudflare Dashboard](https://dash.cloudflare.com/)
2. Navigate to **Workers & Pages** → **Create Application** → **Pages**
3. Click **Connect to Git**
4. Authorize GitHub and select your repository

#### Step 3: Configure Build Settings
For **Vite + React**, use these settings:

| Setting | Value |
|---------|-------|
| **Framework Preset** | Vite |
| **Build Command** | `npm run build` |
| **Build Output Directory** | `dist` |
| **Root Directory** | `/` (leave empty) |

#### Step 4: Deploy
1. Click **Save and Deploy**
2. Wait for build to complete (~1-2 minutes)
3. Get your default URL: `https://your-project.pages.dev`

#### Step 5: Add Custom Domain (scilens.page.gd)

**Option A: If using Cloudflare DNS**
1. In Cloudflare Pages → Custom domains tab
2. Click **Set up a custom domain**
3. Enter `scilens.page.gd`
4. Cloudflare auto-configures DNS and SSL

**Option B: If using external DNS (like your domain registrar)**
1. Add a **CNAME record** at your DNS provider:
   ```
   Type: CNAME
   Name: scilens
   Target: your-project.pages.dev
   TTL: 3600 (or default)
   ```

2. In Cloudflare Pages dashboard, add the custom domain
3. Wait for DNS propagation (5-30 minutes)
4. Verify SSL certificate provisioning (automatic)

#### Step 6: Verify Deployment
```bash
# Test your custom domain
curl -I https://scilens.page.gd

# Check all routes work
curl -I https://scilens.page.gd/science-lens
```

### SPA Routing Configuration
Cloudflare Pages handles SPA routing automatically. If you encounter 404s on refresh, add a `_routes.json` file:

```json
{
  "version": 1,
  "include": ["/*"],
  "exclude": ["/api/*"]
}
```

Place this in your `public/` folder or project root before building.

---

## Option 2: Netlify

### Overview
Netlify is developer-friendly with excellent Git integration and deployment features. Great for React SPAs with form handling and serverless functions support.

### Free Tier Limits (2025)
- **Bandwidth:** 100 GB per month
- **Build Minutes:** 300 per month
- **Custom Domains:** Unlimited
- **Files:** Unlimited
- **SSL:** Free automatic certificates (Let's Encrypt)
- **Form Submissions:** 100/month
- **Price:** Free forever (overage: $20/100GB)

### Pros
- Very easy setup and UI
- Excellent documentation
- Built-in form handling
- Deploy previews for every branch
- Large file uploads support
- Supports large sites (unlimited files)

### Cons
- Bandwidth cap (100GB) - $20 per additional 100GB
- Build minutes can run out with frequent deployments
- Not as fast CDN as Cloudflare globally
- Can get expensive with high traffic

### Deployment Instructions

#### Step 1: Prepare Your Build
```bash
# Build your project
npm run build

# Verify dist folder
ls -la dist/
```

#### Step 2: Connect Repository
1. Go to [Netlify](https://app.netlify.com/)
2. Click **Add new site** → **Import an existing project**
3. Connect your GitHub account
4. Select your repository

#### Step 3: Configure Build Settings
For **Vite + React**, use these settings:

| Setting | Value |
|---------|-------|
| **Branch to deploy** | main (or your default branch) |
| **Build command** | `npm run build` |
| **Publish directory** | `dist` |

#### Step 4: Deploy
1. Click **Deploy site**
2. Wait for build (~1-2 minutes)
3. Get your default URL: `https://your-site.netlify.app`

#### Step 5: Add Custom Domain (scilens.page.gd)

**Option A: Use Netlify DNS (recommended)**
1. Go to **Domain settings** → **Add custom domain**
2. Enter `scilens.page.gd`
3. Choose **Use Netlify DNS**
4. Netlify provides nameservers to add at your registrar
5. Automatic SSL and DNS configuration

**Option B: Keep current DNS provider**
1. Go to **Domain settings** → **Add custom domain**
2. Enter `scilens.page.gd`
3. Choose **Use external DNS**
4. Add CNAME record at your DNS provider:
   ```
   Type: CNAME
   Name: scilens
   Target: your-site.netlify.app
   TTL: 3600
   ```
5. Verify in Netlify dashboard
6. Automatic SSL provisioning via Let's Encrypt

#### Step 6: Configure SPA Routing (If Needed)
Create a `netlify.toml` file in your project root:

```toml
[build]
  command = "npm run build"
  publish = "dist"

[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200
  force = false
```

This ensures all routes serve `index.html` for client-side routing.

#### Step 7: Verify Deployment
```bash
# Test custom domain
curl -I https://scilens.page.gd

# Test SPA routing
curl -I https://scilens.page.gd/science-lens
curl -I https://scilens.page.gd/science-lens/learning
```

---

## Option 3: Firebase Hosting

### Overview
Firebase Hosting is part of Google's Firebase platform. Great if you're using Firebase services (Auth, Database, Functions), which you are with Supabase for some features.

### Free Tier Limits (Spark Plan - 2025)
- **Storage:** 10 GB
- **Bandwidth:** 10 GB per month
- **Custom Domains:** Unlimited
- **SSL:** Free automatic certificates
- **CDN:** Global Firebase CDN
- **Price:** Free forever (Pay as you go after limits)

### Pros
- Free custom domains with SSL
- Excellent Google CDN performance
- Great for SPAs with rewrites configuration
- Easy to deploy with Firebase CLI
- Works well with other Firebase services
- Simple pricing model

### Cons
- Very low bandwidth limit (10GB)
- Low storage limit (10GB)
- Requires Firebase CLI installation
- Not as many build/deploy features as Netlify
- Requires `firebase.json` configuration

### Deployment Instructions

#### Step 1: Install Firebase CLI
```bash
# Install Firebase CLI globally
npm install -g firebase-tools

# Login to Firebase
firebase login
```

#### Step 2: Initialize Firebase
```bash
# From your project root
firebase init hosting

# Prompts:
# - Select: Create a new project
# - Public directory: dist
# - Configure as single-page app: Yes
# - Don't overwrite index.html: No
```

This creates `firebase.json`:

```json
{
  "hosting": {
    "public": "dist",
    "ignore": ["firebase.json", "**/.*", "**/node_modules/**"],
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ]
  }
}
```

#### Step 3: Build and Deploy
```bash
# Build your Vite app
npm run build

# Deploy to Firebase
firebase deploy
```

#### Step 4: Add Custom Domain
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project → **Build** → **Hosting**
3. Click **Custom Domains** → **Add Custom Domain**
4. Enter `scilens.page.gd`
5. Firebase provides DNS instructions:
   - Add A records pointing to Firebase IPs
   - Or CNAME for subdomains

6. Wait for DNS propagation
7. SSL certificate automatically provisions

#### Step 5: Verify
```bash
curl -I https://scilens.page.gd
```

---

## Option 4: GitHub Pages

### Overview
GitHub Pages is simple hosting directly from your GitHub repository. Good for open source projects, but has limitations for SPAs.

### Free Tier Limits (2025)
- **Storage:** 1 GB per site
- **Bandwidth:** 100 GB per month
- **Custom Domains:** 1 per repository
- **SSL:** Free (via Let's Encrypt)
- **Build Minutes:** Unlimited (GitHub Actions separate)
- **Price:** Free for public repos

### Pros
- Simple if you already use GitHub
- Free for public repositories
- Automatic HTTPS
- Great for documentation sites
- Unlimited builds

### Cons
- **No native SPA routing support** (requires workarounds)
- Build updates limited to 10 per hour
- No form handling
- Limited to static sites
- GitHub Pages sites must be public for free tier
- Not suitable for private projects

### Deployment Instructions

#### Step 1: Configure Vite for GitHub Pages
Update `vite.config.ts` to set the correct base path:

```typescript
export default defineConfig({
  base: '/your-repo-name/', // or '/' for custom domain
  // ... rest of config
})
```

#### Step 2: Add Deploy Script
Add to `package.json`:

```json
{
  "scripts": {
    "deploy": "npm run build && gh-pages -d dist"
  }
}
```

Install gh-pages:
```bash
npm install -D gh-pages
```

#### Step 3: Deploy
```bash
npm run deploy
```

#### Step 4: Add Custom Domain
1. Create a file `public/CNAME` with content:
   ```
   scilens.page.gd
   ```

2. Go to repository **Settings** → **Pages**
3. Under **Custom Domain**, enter `scilens.page.gd`
4. Check **Enforce HTTPS**
5. Add CNAME at DNS provider:
   ```
   Type: CNAME
   Name: scilens
   Target: your-username.github.io
   ```

#### Step 5: SPA Routing Workaround
Since GitHub Pages doesn't support SPA routing, you have two options:

**Option A: Use HashRouter in React**
```typescript
// In your main App component
import { HashRouter } from 'react-router-dom';

<HashRouter>
  {/* Your routes */}
</HashRouter>
```

**Option B: Add 404.html redirect**
Create a `404.html` in `public/` that redirects to `index.html`:

```html
<!DOCTYPE html>
<html>
<head>
  <script>
    sessionStorage.redirect = location.href;
  </script>
  <meta http-equiv="refresh" content="0;URL='/'"></meta>
</head>
<body></body>
</html>
```

Then handle the redirect in your React app.

---

## DNS Configuration Summary

### For scilens.page.gd

Depending on which platform you choose, here are the DNS records to add at your domain registrar:

#### Cloudflare Pages
```
Type: CNAME
Name: scilens
Target: your-project.pages.dev
TTL: 3600
```

#### Netlify
```
Type: CNAME
Name: scilens
Target: your-site.netlify.app
TTL: 3600
```

#### Firebase Hosting
```
Type: CNAME
Name: scilens
Target: your-project.web.app
TTL: 3600
```

#### GitHub Pages
```
Type: CNAME
Name: scilens
Target: your-username.github.io
TTL: 3600
```

---

## Platform Recommendations

### Best Overall: Cloudflare Pages
**Use if:** You want unlimited bandwidth, excellent performance, and generous free tier.

**Perfect for:**
- High-traffic sites
- Global audiences
- Projects that might scale
- Cost-conscious deployments

**Why:** Unlimited bandwidth is the standout feature. 500 build minutes is sufficient for most projects, and the global CDN is top-tier.

### Runner Up: Netlify
**Use if:** You want easiest setup, great UI, and built-in form handling.

**Perfect for:**
- Rapid prototyping
- Teams new to deployment
- Projects with forms
- Sites needing large file uploads

**Why:** Netlify has the best developer experience and documentation. The 100GB bandwidth cap is reasonable for most projects, and the $20/100GB overage is fair.

### If Current Setup Works: Stay with Vercel
**Use if:** Custom domain works on Vercel and you're happy with it.

**Perfect for:**
- Next.js applications
- Projects using Vercel-specific features
- Teams already familiar with Vercel

**Why:** Vercel is excellent for React/Next.js. No need to migrate if it's working.

### For Budget-Conscious: Firebase Hosting
**Use if:** You're already using Firebase services or have low bandwidth needs.

**Perfect for:**
- Small projects
- Personal sites
- Prototypes
- Projects using Firebase/Auth

**Why:** Free custom domains and SSL are great, but 10GB bandwidth is very limiting.

### For Open Source: GitHub Pages
**Use if:** Your project is open source and doesn't need complex routing.

**Perfect for:**
- Documentation sites
- Public repos
- Simple static sites
- Projects already on GitHub

**Why:** Simple integration with GitHub, but SPA routing limitations make it less suitable for complex React apps.

---

## Migration Strategy: From Vercel to Backup

If Vercel custom domain doesn't work out, here's how to quickly migrate:

### Emergency Migration Checklist

1. **Choose platform** (Cloudflare Pages recommended)
2. **Build locally:** `npm run build`
3. **Test build:** `npm run preview` or serve `dist/` folder
4. **Create account** on chosen platform
5. **Connect repository**
6. **Deploy** (takes 2-3 minutes)
7. **Add custom domain**
8. **Update DNS** at domain registrar
9. **Wait for propagation** (5-30 minutes)
10. **Test all routes** thoroughly

### Testing Before DNS Switch

Before updating DNS to point to the new platform:

```bash
# Test with curl using Host header
curl -H "Host: scilens.page.gd" https://your-project.pages.dev

# Or edit /etc/hosts locally (Mac/Linux)
# Add line:
# 192.0.2.1 scilens.page.gd

# Then test in browser:
# https://scilens.page.gd
```

### DNS Switch Strategy

1. **Deploy to new platform** and verify it works
2. **Lower DNS TTL** to 300 seconds (5 minutes) 24 hours before
3. **Update DNS** to point to new platform
4. **Monitor** for DNS propagation (5-30 minutes)
5. **Test thoroughly** on custom domain
6. **Keep old deployment** active for 48 hours as rollback
7. **Delete old deployment** after confirming everything works

---

## Performance Comparison

Based on global CDN performance:

| Platform | Global CDN | Speed Ranking | Uptime SLA |
|----------|-----------|---------------|------------|
| Cloudflare Pages | 300+ locations | #1 | 99.99% |
| Vercel | 70+ locations | #2 | 99.99% |
| Netlify | Not publicly disclosed | #3 | 99.99% |
| Firebase | 100+ locations | #4 | 99.95% |

---

## Cost Comparison (If You Exceed Free Tier)

| Platform | Overage Cost | When You'd Pay |
|----------|--------------|----------------|
| Cloudflare Pages | $5/1000 requests (Workers only) | Rarely - bandwidth always free |
| Netlify | $20 per 100GB bandwidth | Consistently over 100GB/month |
| Vercel | $20/100GB bandwidth or Pro plan | Over 100GB/month or need team features |
| Firebase | Pay-as-you-go (after Spark plan) | Over 10GB storage or 10GB bandwidth |
| GitHub Pages | Free (public repos) | Never for public repos |

---

## Final Recommendation

### Primary Choice: Cloudflare Pages
**Best overall value for React SPA with custom domain.**

**Key Reasons:**
1. Unlimited bandwidth - no surprise costs
2. Excellent global performance
3. Free custom domains with SSL
4. SPA routing support out of the box
5. Generous 20,000 file limit
6. Automatic HTTPS with SSL certificates

### Backup Choice: Netlify
**If Cloudflare doesn't work out, Netlify is the best alternative.**

**Key Reasons:**
1. Easiest setup and best UI
2. Excellent documentation and community
3. Deploy previews for every branch
4. Built-in form handling (if needed)
5. 100GB bandwidth is reasonable for most projects
6. Unlimited file uploads

---

## Quick Start Commands

### Cloudflare Pages
```bash
# Build
npm run build

# Deploy via dashboard (no CLI needed)
# Or use Wrangler CLI:
npm install -g wrangler
wrangler pages publish dist --project-name=science-lens-ai
```

### Netlify
```bash
# Install CLI
npm install -g netlify-cli

# Build
npm run build

# Deploy
netlify deploy --prod --dir=dist
```

### Firebase
```bash
# Install CLI
npm install -g firebase-tools

# Initialize
firebase init hosting

# Deploy
npm run build && firebase deploy
```

---

## Troubleshooting Common Issues

### Issue: Blank Page After Deployment
**Causes:** Wrong base path in Vite config
**Solution:** Check `vite.config.ts` base path is `'/'` for custom domains

### Issue: 404 on Route Refresh
**Causes:** SPA routing not configured
**Solution:** Add redirect rules (platform-specific, see above)

### Issue: Custom Domain Not Working
**Causes:** DNS propagation or misconfiguration
**Solution:**
```bash
# Check DNS propagation
dig scilens.page.gd

# Check SSL
openssl s_client -connect scilens.page.gd:443

# Wait up to 48 hours for full propagation
```

### Issue: Build Failures
**Causes:** Node version, missing dependencies, or build errors
**Solution:**
- Check build logs in platform dashboard
- Ensure `package.json` scripts are correct
- Verify `npm run build` works locally
- Check Node.js version compatibility

### Issue: API Requests Failing
**Causes:** CORS or proxy configuration
**Solution:** Ensure your API (Supabase) allows requests from your custom domain

---

## Additional Resources

### Official Documentation
- [Cloudflare Pages Docs](https://developers.cloudflare.com/pages/)
- [Netlify Docs](https://docs.netlify.com/)
- [Firebase Hosting Docs](https://firebase.google.com/docs/hosting)
- [GitHub Pages Docs](https://docs.github.com/pages)

### Deployment Guides
- [Vite Static Deployment Guide](https://vitejs.dev/guide/static-deploy.html)
- [React Router Deployment](https://reactrouter.com/start/deployment)

### Tools
- [DNS Checker](https://dnschecker.org/) - Check DNS propagation
- [SSL Labs](https://www.ssllabs.com/ssltest/) - Test SSL configuration
- [WebPageTest](https://www.webpagetest.org/) - Performance testing

---

## Conclusion

For your Science Lens AI React SPA with custom domain `scilens.page.gd`:

1. **Try Vercel custom domain first** (current setup)
2. **If Vercel fails, migrate to Cloudflare Pages** (best free tier)
3. **Keep Netlify as backup option** (easiest setup)
4. **Avoid GitHub Pages** unless project becomes open source (SPA routing issues)

All options provide free custom domains with SSL. Cloudflare Pages offers the best value with unlimited bandwidth and excellent global performance.

---

**Last Updated:** January 25, 2026
**Next Review:** When free tier limits change or new platforms emerge
