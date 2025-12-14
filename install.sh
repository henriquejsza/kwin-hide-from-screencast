#!/bin/bash

# KWin Hide from Screencast - Installation Script
# Backport of KDE Plasma 6.6's "Hide from Screencast" feature to KWin 6.3.x

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KWIN_VERSION="${KWIN_VERSION:-6.3.6}"

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║     KWin Hide from Screencast - Installer                    ║"
echo "║     Backporting Plasma 6.6 feature to KWin $KWIN_VERSION               ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

# Check if running on Arch-based distro
if command -v pacman &> /dev/null; then
    echo "[1/6] Installing build dependencies..."
    sudo pacman -S --needed --noconfirm \
        extra-cmake-modules wayland-protocols plasma-wayland-protocols \
        qt6-base qt6-wayland kf6-kconfigwidgets kf6-ki18n kf6-kglobalaccel \
        kdecoration kscreenlocker breeze git cmake make gcc
else
    echo "WARNING: This script is optimized for Arch/Manjaro."
    echo "Please install KWin build dependencies manually."
    read -p "Press Enter to continue or Ctrl+C to abort..."
fi

echo ""
echo "[2/6] Downloading KWin source code..."
if [ -d "kwin-src" ]; then
    echo "  -> kwin-src already exists, skipping download"
else
    git clone --depth 1 --branch "v$KWIN_VERSION" https://invent.kde.org/plasma/kwin.git kwin-src
fi

echo ""
echo "[3/6] Applying patch..."
cd kwin-src
git apply "$SCRIPT_DIR/kwin-hide-from-screencast.patch" || {
    echo "Patch may have already been applied or conflicts exist."
    read -p "Continue anyway? [y/N] " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
}

echo ""
echo "[4/6] Configuring build..."
mkdir -p build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release

echo ""
echo "[5/6] Building KWin (this may take 10-20 minutes)..."
make -j$(nproc)

echo ""
echo "[6/6] Installing..."
sudo make install

echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║  ✅ Installation Complete!                                   ║"
echo "║                                                              ║"
echo "║  To activate, restart KWin:                                  ║"
echo "║    • Alt+Shift+F12 (twice), or                               ║"
echo "║    • Logout and login, or                                    ║"
echo "║    • Reboot                                                  ║"
echo "║                                                              ║"
echo "║  Usage: Right-click title bar → More Actions →               ║"
echo "║         Hide from Screencast                                 ║"
echo "╚══════════════════════════════════════════════════════════════╝"
