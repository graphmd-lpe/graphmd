#!/bin/bash

# Git repository from HTTPS mirror restore script
# Usage: ./restore-from-backup-mirror.sh [https-url] [destination-path]

set -e

# Configuration
HTTPS_URL="${1}"
DEST_PATH="${2:-.}"

# Validate inputs
if [ -z "$HTTPS_URL" ]; then
    echo "Error: HTTPS URL not specified"
    echo "Usage: $0 <https-url> [destination-path]"
    echo "Example: $0 https://mirror.git.artbin.me/graphmd-lpe/graphmd.bundle /path/to/restore"
    exit 1
fi

# Validate HTTPS URL
if [[ ! "$HTTPS_URL" =~ ^https:// ]]; then
    echo "Error: URL must use HTTPS protocol"
    exit 1
fi

# Extract filename from URL
BACKUP_NAME=$(basename "$HTTPS_URL")

# Add .bundle extension if not present in filename
if [[ "$BACKUP_NAME" != *.bundle ]]; then
    BACKUP_NAME="${BACKUP_NAME}.bundle"
fi

echo "=== Git HTTPS Restore ==="
echo "Backup URL: $HTTPS_URL"
echo "Destination: $DEST_PATH"

# Download from HTTPS
BUNDLE_FILE="/tmp/${BACKUP_NAME}"
echo ""
echo "Downloading bundle..."
curl -fSL -o "$BUNDLE_FILE" "$HTTPS_URL"

# Verify bundle
echo ""
echo "Verifying bundle..."
git bundle verify "$BUNDLE_FILE"

# Clone from bundle
echo ""
echo "Restoring repository..."
git clone "$BUNDLE_FILE" "$DEST_PATH"

# Cleanup
rm "$BUNDLE_FILE"

echo ""
echo "✓ Restore completed successfully!"
echo "Repository restored to: $DEST_PATH"
