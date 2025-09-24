#!/bin/bash

if ! declare -F omakub_return >/dev/null 2>&1; then
  omakub_return() { return 0 2>/dev/null || exit 0; }
fi

if [ "$OMAKUB_DEB_ARCH" != "amd64" ] && [ "$OMAKUB_DEB_ARCH" != "arm64" ]; then
  echo "Skipping Brave install: no package available for architecture $OMAKUB_DEB_ARCH"
  omakub_return
  return
fi

sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=${OMAKUB_DEB_ARCH}] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update -y
sudo apt install -y brave-browser
