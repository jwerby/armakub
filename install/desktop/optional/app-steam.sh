#!/bin/bash

if ! declare -F omakub_return >/dev/null 2>&1; then
  omakub_return() { return 0 2>/dev/null || exit 0; }
fi

# Play games from https://store.steampowered.com/
if [ "$OMAKUB_ARCH" != "x86_64" ]; then
  echo "Skipping Steam install: Valve does not provide native packages for architecture $OMAKUB_ARCH."
  omakub_return
  return
fi

cd /tmp
wget https://cdn.akamai.steamstatic.com/client/installer/steam.deb
sudo apt install -y ./steam.deb
rm steam.deb
cd -
