#!/bin/bash

if ! declare -F omakub_return >/dev/null 2>&1; then
  omakub_return() { return 0 2>/dev/null || exit 0; }
fi

case "$OMAKUB_ARCH" in
  x86_64)
    ZELLIJ_PACKAGE="zellij-x86_64-unknown-linux-musl"
    ;;
  aarch64)
    ZELLIJ_PACKAGE="zellij-aarch64-unknown-linux-musl"
    ;;
  *)
    echo "Skipping Zellij install: no release available for architecture $OMAKUB_ARCH"
    omakub_return
    ;;
esac

cd /tmp
wget -O zellij.tar.gz "https://github.com/zellij-org/zellij/releases/latest/download/${ZELLIJ_PACKAGE}.tar.gz"
tar -xf zellij.tar.gz zellij
sudo install zellij /usr/local/bin
rm zellij.tar.gz zellij
cd -

mkdir -p ~/.config/zellij/themes
[ ! -f "$HOME/.config/zellij/config.kdl" ] && cp ~/.local/share/omakub/configs/zellij.kdl ~/.config/zellij/config.kdl
cp ~/.local/share/omakub/themes/tokyo-night/zellij.kdl ~/.config/zellij/themes/tokyo-night.kdl
