#!/bin/bash

cat <<EOF >~/.local/share/applications/Omakub.desktop
[Desktop Entry]
Version=1.0
Name=Armakub
Comment=Armakub Controls
Exec=alacritty --config-file /home/$USER/.config/alacritty/pane.toml --class=Armakub --title=Armakub -e armakub
Terminal=false
Type=Application
Icon=/home/$USER/.local/share/omakub/applications/icons/Armakub.png
Categories=GTK;
StartupNotify=false
EOF
