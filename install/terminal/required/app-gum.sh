#!/bin/bash

if ! declare -F omakub_return >/dev/null 2>&1; then
  omakub_return() { return 0 2>/dev/null || exit 0; }
fi

# Gum is used for the Omakub commands for tailoring Omakub after the initial install
if [ "$OMAKUB_DEB_ARCH" != "amd64" ] && [ "$OMAKUB_DEB_ARCH" != "arm64" ]; then
  echo "Skipping gum install: no package available for architecture $OMAKUB_DEB_ARCH"
  omakub_return
fi

cd /tmp
GUM_VERSION="0.14.3" # Use known good version
wget -qO gum.deb "https://github.com/charmbracelet/gum/releases/download/v${GUM_VERSION}/gum_${GUM_VERSION}_${OMAKUB_DEB_ARCH}.deb"
sudo apt-get install -y --allow-downgrades ./gum.deb
rm gum.deb
cd -
