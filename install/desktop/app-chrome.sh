#!/bin/bash

if ! declare -F omakub_return >/dev/null 2>&1; then
  omakub_return() { return 0 2>/dev/null || exit 0; }
fi

# Browse the web with the most popular browser. See https://www.google.com/chrome/
case "$OMAKUB_ARCH" in
  aarch64)
    echo "Google Chrome is not available for ARM64; installing Chromium instead."
    sudo snap install chromium
    xdg-settings set default-web-browser chromium_chromium.desktop || true
    omakub_return
    return
    ;;
  x86_64)
    ;;
  *)
    echo "Skipping Chrome install: no package available for architecture $OMAKUB_ARCH"
    omakub_return
    return
    ;;
esac

cd /tmp
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb
xdg-settings set default-web-browser google-chrome.desktop
cd -
