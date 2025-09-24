#!/bin/bash

if ! declare -F omakub_return >/dev/null 2>&1; then
  omakub_return() { return 0 2>/dev/null || exit 0; }
fi

if [ "$OMAKUB_DEB_ARCH" != "amd64" ]; then
  echo "Skipping Mainline Kernel tool install: PPA packages are available for amd64 only."
  omakub_return
fi

sudo add-apt-repository -y ppa:cappelikan/ppa
sudo apt update -y
sudo apt install -y mainline
