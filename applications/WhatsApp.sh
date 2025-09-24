#!/bin/bash

if ! declare -F omakub_return >/dev/null 2>&1; then
  omakub_return() { return 0 2>/dev/null || exit 0; }
fi

WHATSAPP_BROWSER=$(command -v google-chrome || command -v chromium || true)
if [ -z "$WHATSAPP_BROWSER" ]; then
  echo "Skipping WhatsApp shortcut: neither google-chrome nor chromium is installed."
  omakub_return
  return
fi

cat <<EOF >~/.local/share/applications/WhatsApp.desktop
[Desktop Entry]
Version=1.0
Name=WhatsApp
Comment=WhatsApp Messenger
Exec=${WHATSAPP_BROWSER} --app="https://web.whatsapp.com" --name=WhatsApp --class=Whatsapp
Terminal=false
Type=Application
Icon=/home/$USER/.local/share/omakub/applications/icons/WhatsApp.png
Categories=GTK;
MimeType=text/html;text/xml;application/xhtml_xml;
StartupNotify=true
EOF
