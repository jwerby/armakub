#!/bin/bash

if ! declare -F omakub_return >/dev/null 2>&1; then
  omakub_return() { return 0 2>/dev/null || exit 0; }
fi

if [ "$OMAKUB_DEB_ARCH" = "arm64" ]; then
  echo "Installing Signal via Flatpak on ARM64."
  flatpak install -y flathub org.signal.Signal
  omakub_return
  return
fi

if [ "$OMAKUB_DEB_ARCH" != "amd64" ]; then
  echo "Skipping Signal desktop install: no package available for architecture $OMAKUB_DEB_ARCH"
  omakub_return
  return
fi

wget -qO- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor >signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg >/dev/null
echo "deb [arch=${OMAKUB_DEB_ARCH} signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main" |
	sudo tee /etc/apt/sources.list.d/signal-xenial.list
rm signal-desktop-keyring.gpg
sudo apt update
sudo apt install -y signal-desktop
