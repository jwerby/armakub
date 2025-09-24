#!/bin/bash

if ! declare -F omakub_return >/dev/null 2>&1; then
  omakub_return() { return 0 2>/dev/null || exit 0; }
fi

if [ "$OMAKUB_ARCH" != "x86_64" ]; then
  echo "Skipping Minecraft launcher install: no native package available for architecture $OMAKUB_ARCH."
  omakub_return
  return
fi

sudo apt install -y openjdk-8-jdk

cd /tmp
wget https://launcher.mojang.com/download/Minecraft.deb
sudo apt install -y ./Minecraft.deb
rm Minecraft.deb
cd -
