#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Give people a chance to retry running the installation
trap 'echo "Armakub installation failed! You can retry by running: source ~/.local/share/omakub/install.sh"' ERR

# Ensure apt is available (stop PackageKit and wait for locks to clear)
PACKAGEKIT_STOPPED=0
if command -v systemctl >/dev/null 2>&1; then
  if sudo systemctl is-active --quiet packagekit.service; then
    sudo systemctl stop packagekit.service >/dev/null 2>&1 || true
    PACKAGEKIT_STOPPED=1
  fi
fi

omakub_wait_for_apt_lock() {
  local locks=(/var/lib/dpkg/lock-frontend /var/lib/dpkg/lock /var/lib/apt/lists/lock)
  for lock in "${locks[@]}"; do
    while sudo fuser "$lock" >/dev/null 2>&1; do
      echo "Waiting for apt to become available (lock: $lock)..."
      sleep 2
    done
  done
}

omakub_wait_for_apt_lock
export -f omakub_wait_for_apt_lock

trap '[ "$PACKAGEKIT_STOPPED" = "1" ] && command -v systemctl >/dev/null 2>&1 && sudo systemctl start packagekit.service >/dev/null 2>&1 || true' EXIT

# Check the distribution name and version and abort if incompatible
source ~/.local/share/omakub/install/check-version.sh

# Ask for app choices
echo "Get ready to make a few choices..."
source ~/.local/share/omakub/install/terminal/required/app-gum.sh >/dev/null
source ~/.local/share/omakub/install/first-run-choices.sh
source ~/.local/share/omakub/install/identification.sh

# Desktop software and tweaks will only be installed if we're running Gnome
if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then
  # Ensure computer doesn't go to sleep or lock while installing
  gsettings set org.gnome.desktop.screensaver lock-enabled false
  gsettings set org.gnome.desktop.session idle-delay 0

  echo "Installing terminal and desktop tools..."

  # Install terminal tools
  source ~/.local/share/omakub/install/terminal.sh

  # Install desktop tools and tweaks
  source ~/.local/share/omakub/install/desktop.sh

  # Revert to normal idle and lock settings
  gsettings set org.gnome.desktop.screensaver lock-enabled true
  gsettings set org.gnome.desktop.session idle-delay 300
else
  echo "Only installing terminal tools..."
  source ~/.local/share/omakub/install/terminal.sh
fi
