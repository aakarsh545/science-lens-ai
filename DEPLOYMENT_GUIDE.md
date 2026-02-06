# Science Lens - Deployment Guide for InfinityFree

## Current Status
✅ **Website Built Successfully**
- Build completed at: 2026-01-24
- Build output location: `dist/` folder
- Deployment package: `scilens-deploy.zip`

## Option 1: Upload via InfinityFree File Manager (RECOMMENDED)

### Steps:
1. **Log in to InfinityFree Control Panel**
   - Go to: https://panel.infinityfree.net/
   - Username: `if0_40977177`
   - Password: (Your password)

2. **Open File Manager**
   - In the left sidebar, click on "File Manager" or "File Access"

3. **Navigate to htdocs**
   - Go to: `/htdocs` folder
   - This is your website's public root directory

4. **Upload Files**
   - **Method A: Upload Individual Files**
     - Click "Upload Files" or drag & drop
     - Upload ALL files from the `dist/` folder:
       - `index.html`
       - `robots.txt`
       - `favicon.ico`
       - `placeholder.svg`
       - The entire `assets/` folder (with all JS/CSS files)
       - The entire `icons/` folder (with all theme/avatar images)

   - **Method B: Upload ZIP (if available)**
     - If File Manager supports ZIP extraction, upload `scilens-deploy.zip`
     - Extract the ZIP contents to `/htdocs`

5. **Verify Upload**
   - Make sure all files are in `/htdocs`
   - File structure should look like:
     ```
     /htdocs/
       ├── index.html
       ├── robots.txt
       ├── favicon.ico
       ├── placeholder.svg
       ├── assets/
       │   ├── index-CKvdN8Fq.js
       │   ├── index-YXVYpLVc.css
       │   ├── react-vendor-VbTLe0zt.js
       │   ├── supabase-vendor-Za2Jx3-P.js
       │   ├── ui-vendor-DT5sJQcE.js
       │   ├── pdf-export-Bsa7aH9s.js
       │   └── vendor-C_1O9kIv.js
       └── icons/
           ├── avatars/
           └── themes/
     ```

## Option 2: Upload via FTP Client (FileZilla, WinSCP, etc.)

### Get FTP Credentials:
1. Log in to InfinityFree Control Panel
2. Go to "FTP Details" in the left menu
3. Note down:
   - **FTP Host** (e.g., `ftpupload.infinityfree.com` or similar)
   - **FTP Username** (different from panel username!)
   - **FTP Password** (different from panel password!)

### Using FileZilla:
1. **Download FileZilla** (if not installed): https://filezilla-project.org/

2. **Connect to FTP**
   - Host: (FTP Host from FTP Details)
   - Username: (FTP Username from FTP Details)
   - Password: (FTP Password from FTP Details)
   - Port: 21

3. **Upload Files**
   - Local site: Navigate to `dist/` folder
   - Remote site: Navigate to `/htdocs`
   - Drag & drop ALL files from local to remote

## Option 3: Get FTP Credentials for Automated Upload

If you want me to upload the files automatically, I need your **FTP-specific** credentials:

1. **Get FTP Details from InfinityFree Panel:**
   - Log in to: https://panel.infinityfree.net/
   - Go to: "FTP Details" in left menu
   - You'll see:
     - FTP Host
     - FTP Username
     - FTP Password

2. **Share FTP Credentials with me:**
   - Once you have them, share them with me
   - I'll update the upload script and deploy automatically

## After Upload - Verify Deployment

### Check Your Website:
- **URL**: http://scilens.page.gd
- **URL**: https://scilens.page.gd

### What Should Work:
✅ Homepage loads with Science Lens branding
✅ Navigation menu appears
✅ Login/Signup functionality works
✅ All assets (images, CSS, JS) load correctly

### Troubleshooting:
**If you see "404 Not Found":**
- Check that files are in `/htdocs`, not a subfolder
- Verify `index.html` exists in `/htdocs`

**If styles are missing:**
- Verify `assets/` folder was uploaded
- Check that all CSS files are present

**If you get errors:**
- Clear browser cache (Ctrl+Shift+R / Cmd+Shift+R)
- Check browser console for errors (F12)

## Important Notes:

⚠️ **Security Warning:**
- Never share your panel password publicly
- FTP credentials are separate from panel credentials
- Change passwords regularly

⚠️ **Environment Variables:**
- The `.env` file is NOT included in the build
- Supabase credentials are in the frontend code
- Make sure your Supabase project is active

⚠️ **Build Updates:**
- Whenever you make code changes, run: `npm run build`
- Upload the new files from `dist/` to InfinityFree
- The `scilens-deploy.zip` will need to be recreated

## File Locations:
- **Source Code**: `src/` folder
- **Build Output**: `dist/` folder
- **Deployment Package**: `scilens-deploy.zip` (in project root)

## Support:
If you encounter issues:
1. Check that all files uploaded correctly
2. Verify the file structure matches above
3. Check browser console for errors (F12)
4. Try clearing browser cache
5. Contact me with the specific error message

---
**Good luck! Your Science Lens website is ready to deploy! 🚀**
