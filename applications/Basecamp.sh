#!/bin/bash

if ! declare -F omakub_return >/dev/null 2>&1; then
  omakub_return() { return 0 2>/dev/null || exit 0; }
fi

BASE_BROWSER=$(command -v google-chrome || command -v chromium || true)
if [ -z "$BASE_BROWSER" ]; then
  echo "Skipping Basecamp shortcut: neither google-chrome nor chromium is installed."
  omakub_return
  return
fi

cat <<EOF >~/.local/share/applications/Basecamp.desktop
[Desktop Entry]
Version=1.0
Name=Basecamp
Comment=Basecamp Project Management
Exec=${BASE_BROWSER} --app="https://launchpad.37signals.com" --name=Basecamp --class=Basecamp
Terminal=false
Type=Application
Icon=/home/$USER/.local/share/omakub/applications/icons/Basecamp.png
Categories=GTK;
MimeType=text/html;text/xml;application/xhtml_xml;
StartupNotify=true
EOF
