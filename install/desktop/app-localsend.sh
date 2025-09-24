#!/bin/bash

if ! declare -F omakub_return >/dev/null 2>&1; then
  omakub_return() { return 0 2>/dev/null || exit 0; }
fi

cd /tmp
LOCALSEND_VERSION=$(curl -s "https://api.github.com/repos/localsend/localsend/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')

case "$OMAKUB_ARCH" in
  aarch64)
    if flatpak remote-info --arch=aarch64 flathub org.localsend.localsend >/dev/null 2>&1; then
      echo "Installing LocalSend from Flatpak on ARM64."
      flatpak install -y flathub org.localsend.localsend
    else
      echo "Skipping LocalSend install: no ARM64 build available on Flathub."
    fi
    cd -
    omakub_return
    return
    ;;
  x86_64)
    LOCALSEND_ARCH_SUFFIX="linux-x86-64"
    ;;
  *)
    echo "Skipping LocalSend install: no package available for architecture $OMAKUB_ARCH"
    cd -
    omakub_return
    return
    ;;
  esac

wget -O localsend.deb "https://github.com/localsend/localsend/releases/latest/download/LocalSend-${LOCALSEND_VERSION}-${LOCALSEND_ARCH_SUFFIX}.deb"
sudo apt install -y ./localsend.deb
rm localsend.deb
cd -
