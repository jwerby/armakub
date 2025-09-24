#!/bin/bash

set -e

read -r -d '' ascii_art <<'EOF' || true
    _                            _         _
   / \   _ __ _ __ ___   __ _| | __ _| |_
  / _ \ | '__| '_ ` _ \ / _` | |/ _` | __|
 / ___ \| |  | | | | | | (_| | | (_| | |_
/_/   \_\_|  |_| |_| |_|\__,_|_|\__,_|\__|
EOF

echo -e "$ascii_art"
echo "=> Armakub is for fresh Ubuntu 24.04+ installations only!"
echo -e "\nBegin installation (or abort with ctrl+c)..."

sudo apt-get update >/dev/null
sudo apt-get install -y git >/dev/null

echo "Cloning Armakub..."
rm -rf ~/.local/share/omakub

OMAKUB_REMOTE=${OMAKUB_REMOTE:-https://github.com/jwerby/armakub.git}
git clone "$OMAKUB_REMOTE" ~/.local/share/omakub >/dev/null

if [ -n "$OMAKUB_REF" ]; then
	cd ~/.local/share/omakub
	git fetch origin "$OMAKUB_REF" && git checkout "$OMAKUB_REF"
	cd -
fi

echo "Installation starting..."
source ~/.local/share/omakub/install.sh
