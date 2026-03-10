#!/bin/bash

# FTP credentials for InfinityFree
# Note: These are the panel credentials. FTP credentials may differ!
HOST="ftp.infinityfree.com"
USER="if0_40977177"
PASS="Illovemom545"

# Directory to upload
LOCAL_DIR="/Users/akarsh545/Workspaces/science-lens-ai/science-lens-ai-code/dist"
REMOTE_DIR="/htdocs"

echo "🚀 Starting FTP upload to InfinityFree..."
echo "📁 Uploading from: $LOCAL_DIR"
echo "🌐 Uploading to: $HOST$REMOTE_DIR"
echo ""
echo "⚠️  If authentication fails, you need to get FTP-specific credentials from:"
echo "    InfinityFree Panel → Account → FTP Details"
echo ""

# Function to upload a file without SSL
upload_file() {
    local file="$1"
    local remotepath="$2"

    echo "⬆️  Uploading: $(basename $file)"

    # Use curl without SSL and with explicit port
    curl -T "$file" \
         -u "$USER:$PASS" \
         "ftp://$HOST$remotepath" \
         --ftp-create-dirs \
         -k \
         --connect-timeout 30 \
         --max-time 120
}

# Test connection first
echo "🔌 Testing FTP connection..."
curl -u "$USER:$PASS" "ftp://$HOST/" -k --list-only > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo ""
    echo "❌ FTP authentication failed!"
    echo ""
    echo "The credentials from your screenshot are for the control panel, NOT FTP."
    echo ""
    echo "To get your FTP credentials:"
    echo "1. Log in to InfinityFree control panel"
    echo "2. Go to 'FTP Details' in the left menu"
    echo "3. Copy the FTP Host, FTP Username, and FTP Password"
    echo "4. Update the upload script with those credentials"
    echo ""
    echo "Alternatively, you can use the InfinityFree File Manager in the control panel"
    echo "to manually upload the contents of the 'dist' folder to the 'htdocs' folder."
    exit 1
fi

echo "✅ Connection successful!"
echo ""

# Upload main files
echo "📄 Uploading main files..."
upload_file "$LOCAL_DIR/index.html" "$REMOTE_DIR/index.html"
upload_file "$LOCAL_DIR/robots.txt" "$REMOTE_DIR/robots.txt"
upload_file "$LOCAL_DIR/favicon.ico" "$REMOTE_DIR/favicon.ico"
upload_file "$LOCAL_DIR/placeholder.svg" "$REMOTE_DIR/placeholder.svg"

# Upload assets
echo "📦 Uploading assets..."
for file in "$LOCAL_DIR"/assets/*; do
    filename=$(basename "$file")
    upload_file "$file" "$REMOTE_DIR/assets/$filename"
done

# Try to upload .htaccess if it exists
if [ -f "$LOCAL_DIR/.htaccess" ]; then
    echo "📄 Uploading .htaccess..."
    upload_file "$LOCAL_DIR/.htaccess" "$REMOTE_DIR/.htaccess"
fi

echo ""
echo "✅ Upload complete!"
echo "🌐 Your website should be live at: http://scilens.page.gd"
echo "🌐 Or: https://scilens.page.gd"
