#!/bin/bash

# Nerd Font Installation Script
# This script downloads and installs JetBrainsMono Nerd Font

set -e

FONT_NAME="JetBrainsMono"
FONT_VERSION="v3.2.1"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/${FONT_VERSION}/${FONT_NAME}.zip"
FONT_DIR="$HOME/.local/share/fonts"

echo "=== Nerd Font Installer ==="
echo "Installing ${FONT_NAME} Nerd Font..."
echo ""

# Check if font already installed
if fc-list | grep -qi "${FONT_NAME}.*Nerd"; then
    echo "✓ ${FONT_NAME} Nerd Font already installed!"
    echo ""
    echo "Installed fonts:"
    fc-list | grep -i "${FONT_NAME}.*Nerd" | head -5
    echo ""
    echo "Next step: Configure your terminal to use '${FONT_NAME} Nerd Font'"
    exit 0
fi

# Create font directory
mkdir -p "${FONT_DIR}"

# Download font
echo "→ Downloading ${FONT_NAME} Nerd Font..."
if command -v wget &> /dev/null; then
    wget -q --show-progress "${FONT_URL}" -O "/tmp/${FONT_NAME}.zip"
elif command -v curl &> /dev/null; then
    curl -fLo "/tmp/${FONT_NAME}.zip" "${FONT_URL}"
else
    echo "✗ Error: wget or curl required"
    exit 1
fi

# Extract font
echo "→ Extracting fonts..."
if command -v unzip &> /dev/null; then
    unzip -q -o "/tmp/${FONT_NAME}.zip" -d "${FONT_DIR}"
else
    # Fallback to Python if unzip not available
    python3 -c "
import zipfile
import os
zipfile.ZipFile('/tmp/${FONT_NAME}.zip').extractall('${FONT_DIR}')
"
fi
rm "/tmp/${FONT_NAME}.zip"

# Remove Windows-compatible fonts (optional, saves space)
find "${FONT_DIR}" -name "*Windows Compatible*" -delete 2>/dev/null || true

# Refresh font cache
echo "→ Updating font cache..."
fc-cache -fv > /dev/null 2>&1

# Verify installation
echo ""
if fc-list | grep -qi "${FONT_NAME}.*Nerd"; then
    echo "✓ ${FONT_NAME} Nerd Font installed successfully!"
    echo ""
    echo "Installed font files:"
    fc-list | grep -i "${FONT_NAME}.*Nerd" | head -5 | awk -F: '{print "  - " $1}'
    echo ""
    echo "=== Next Steps ==="
    echo "1. Open your terminal preferences"
    echo "2. Change font to: '${FONT_NAME} Nerd Font'"
    echo "3. Restart your terminal"
    echo ""
    echo "Test icons:"
    echo "  echo -e '\\uf02d \\uf200 \\ue73c \\ue7a8 \\uf31b'"
    echo ""
else
    echo "✗ Installation may have failed. Check ${FONT_DIR}"
    exit 1
fi
