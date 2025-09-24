#!/bin/bash

if ! declare -F omakub_return >/dev/null 2>&1; then
  omakub_return() { return 0 2>/dev/null || exit 0; }
fi

# Lazygit provides prebuilt binaries for x86_64 and arm64 only
case "$OMAKUB_ARCH" in
  x86_64)
    LAZYGIT_ARCH="Linux_x86_64"
    ;;
  aarch64)
    LAZYGIT_ARCH="Linux_arm64"
    ;;
  *)
    echo "Skipping lazygit install: no release available for architecture $OMAKUB_ARCH"
    omakub_return
    ;;
esac

cd /tmp
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -sLo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_${LAZYGIT_ARCH}.tar.gz"
tar -xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit.tar.gz lazygit
mkdir -p ~/.config/lazygit/
touch ~/.config/lazygit/config.yml
cd -
