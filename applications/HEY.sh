#!/bin/bash

if ! declare -F omakub_return >/dev/null 2>&1; then
  omakub_return() { return 0 2>/dev/null || exit 0; }
fi

HEY_BROWSER=$(command -v google-chrome || command -v chromium || true)
if [ -z "$HEY_BROWSER" ]; then
  echo "Skipping HEY shortcut: neither google-chrome nor chromium is installed."
  omakub_return
fi

cat <<EOF >~/.local/share/applications/HEY.desktop
[Desktop Entry]
Version=1.0
Name=HEY
Comment=HEY Email + Calendar
Exec=${HEY_BROWSER} --app="https://app.hey.com/" --name=HEY --class=HEY
Terminal=false
Type=Application
Icon=/home/$USER/.local/share/omakub/applications/icons/HEY.png
Categories=GTK;
MimeType=text/html;text/xml;application/xhtml_xml;
StartupNotify=true
EOF
