#!/bin/bash

if ! declare -F omakub_return >/dev/null 2>&1; then
  omakub_return() { return 0 2>/dev/null || exit 0; }
fi

# Virtualbox allows you to run VMs for other flavors of Linux or even Windows
# See https://ubuntu.com/tutorials/how-to-run-ubuntu-desktop-on-a-virtual-machine-using-virtualbox#1-overview
# for a guide on how to run Ubuntu inside it.

if [ "$OMAKUB_ARCH" != "x86_64" ]; then
  echo "Skipping VirtualBox install: Oracle only supports x86_64 builds."
  omakub_return
fi

sudo apt install -y virtualbox virtualbox-ext-pack
sudo usermod -aG vboxusers ${USER}
