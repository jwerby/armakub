#!/bin/bash

set -e

ascii_art='________                  __        ___.
\_____  \   _____ _____  |  | ____ _\_ |__
 /   |   \ /     \\__   \ |  |/ /  |  \ __ \
/    |    \  Y Y  \/ __ \|    <|  |  / \_\ \
\_______  /__|_|  (____  /__|_ \____/|___  /
        \/      \/     \/     \/         \/
'

echo -e "$ascii_art"
echo "=> Omakub is for fresh Ubuntu 24.04+ installations only!"
echo -e "\nBegin installation (or abort with ctrl+c)..."

sudo apt-get update >/dev/null
sudo apt-get install -y git >/dev/null

echo "Cloning Omakub..."
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
