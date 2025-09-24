#!/bin/bash

if ! declare -F omakub_return >/dev/null 2>&1; then
  omakub_return() { return 0 2>/dev/null || exit 0; }
fi

# Temporarily switch away from using Typora repo which is broken.
#
# wget -qO - https://typora.io/linux/public-key.asc | sudo tee /etc/apt/trusted.gpg.d/typora.asc >/dev/null || true
#
# sudo add-apt-repository -y 'deb https://typora.io/linux ./'
# sudo add-apt-repository -y 'deb https://typora.io/linux ./'
# sudo apt update -y
# sudo apt install -y typora

# Install with deb package for supported architectures
if [ "$OMAKUB_DEB_ARCH" != "amd64" ] && [ "$OMAKUB_DEB_ARCH" != "arm64" ]; then
  echo "Skipping Typora install: no package available for architecture $OMAKUB_DEB_ARCH"
  omakub_return
  return
fi

cd /tmp
wget -O typora.deb "https://downloads.typora.io/linux/typora_1.10.8_${OMAKUB_DEB_ARCH}.deb"
sudo apt install -y /tmp/typora.deb
rm typora.deb
cd -

# Add iA Typora theme
mkdir -p ~/.config/Typora/themes
cp ~/.local/share/omakub/configs/typora/ia_typora.css ~/.config/Typora/themes/
cp ~/.local/share/omakub/configs/typora/ia_typora_night.css ~/.config/Typora/themes/
