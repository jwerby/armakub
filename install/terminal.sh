#!/bin/bash

# Needed for all installers
ensure_apt_ready() {
	if declare -F omakub_wait_for_apt_lock >/dev/null 2>&1; then
		omakub_wait_for_apt_lock
	fi
}

ensure_apt_ready
sudo apt update -y
ensure_apt_ready
sudo apt upgrade -y
ensure_apt_ready
sudo apt install -y curl git unzip

# Run terminal installers
for installer in ~/.local/share/omakub/install/terminal/*.sh; do source $installer; done
