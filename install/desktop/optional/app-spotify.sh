#!/bin/bash

if ! declare -F omakub_return >/dev/null 2>&1; then
  omakub_return() { return 0 2>/dev/null || exit 0; }
fi

# Stream music using https://spotify.com
if [ "$OMAKUB_DEB_ARCH" = "arm64" ]; then
  echo "Installing Spotify via Flatpak on ARM64."
  flatpak install -y flathub com.spotify.Client
  omakub_return
fi

if [ "$OMAKUB_DEB_ARCH" != "amd64" ]; then
  echo "Skipping Spotify install: no package available for architecture $OMAKUB_DEB_ARCH"
  omakub_return
fi

curl -sS https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb [signed-by=/etc/apt/trusted.gpg.d/spotify.gpg] https://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update -y
sudo apt install -y spotify-client
