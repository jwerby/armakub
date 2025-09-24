#!/bin/bash

if ! declare -F omakub_return >/dev/null 2>&1; then
  omakub_return() { return 0 2>/dev/null || exit 0; }
fi

# A Communication platform for voice, video, and text messaging https://discord.com/
if [ "$OMAKUB_DEB_ARCH" = "arm64" ]; then
  echo "Installing Discord via Flatpak on ARM64."
  flatpak install -y flathub com.discordapp.Discord
  omakub_return
fi

if [ "$OMAKUB_DEB_ARCH" != "amd64" ]; then
  echo "Skipping Discord install: no package available for architecture $OMAKUB_DEB_ARCH"
  omakub_return
fi

cd /tmp
wget "https://discord.com/api/download?platform=linux&format=deb" -O discord.deb
sudo apt install ./discord.deb -y
rm discord.deb
cd -
