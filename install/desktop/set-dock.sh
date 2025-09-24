#!/bin/bash

# Favorite apps for dock
browser_favorite=""
if command -v google-chrome >/dev/null 2>&1; then
	browser_favorite="google-chrome.desktop"
elif command -v chromium >/dev/null 2>&1; then
	browser_favorite="chromium_chromium.desktop"
fi

apps=()
[ -n "$browser_favorite" ] && apps+=("$browser_favorite")
apps+=(
	"Alacritty.desktop"
	"Neovim.desktop"
	"code.desktop"
	"WhatsApp.desktop"
	"signal-desktop.desktop"
	"Zoom.desktop"
	"spotify.desktop"
	"steam.desktop"
	"pinta_pinta.desktop"
	"md.obsidian.Obsidian.desktop"
	"Activity.desktop"
	"Docker.desktop"
	"Omakub.desktop"
	"1password.desktop"
	"org.gnome.Settings.desktop"
	"org.gnome.Nautilus.desktop"
	"localsend_app.desktop"
)

# Array to hold installed favorite apps
installed_apps=()

# Directory where .desktop files are typically stored
desktop_dirs=(
	"/var/lib/flatpak/exports/share/applications"
	"/usr/share/applications"
	"/usr/local/share/applications"
	"$HOME/.local/share/applications"
)

# Check if a .desktop file exists for each app
for app in "${apps[@]}"; do
	for dir in "${desktop_dirs[@]}"; do
		if [ -f "$dir/$app" ]; then
			installed_apps+=("$app")
			break
		fi
	done
done

# Convert the array to a format suitable for gsettings
favorites_list=$(printf "'%s'," "${installed_apps[@]}")
favorites_list="[${favorites_list%,}]"

# Set the favorite apps
gsettings set org.gnome.shell favorite-apps "$favorites_list"
