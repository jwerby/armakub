#!/bin/bash

if ! declare -F omakub_return >/dev/null 2>&1; then
  omakub_return() { return 0 2>/dev/null || exit 0; }
fi

case "$OMAKUB_ARCH" in
  x86_64)
    LAZYDOCKER_ARCH="Linux_x86_64"
    ;;
  aarch64)
    LAZYDOCKER_ARCH="Linux_arm64"
    ;;
  *)
    echo "Skipping lazydocker install: no release available for architecture $OMAKUB_ARCH"
    omakub_return
    ;;
esac

cd /tmp
LAZYDOCKER_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazydocker/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -sLo lazydocker.tar.gz "https://github.com/jesseduffield/lazydocker/releases/latest/download/lazydocker_${LAZYDOCKER_VERSION}_${LAZYDOCKER_ARCH}.tar.gz"
tar -xf lazydocker.tar.gz lazydocker
sudo install lazydocker /usr/local/bin
rm lazydocker.tar.gz lazydocker
cd -
