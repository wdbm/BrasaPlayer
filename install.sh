#!/bin/bash

sudo apt install \
    python3-gi gir1.2-gtk-4.0 \
    libgtk-4-media-gstreamer  \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad  \
    desktop-file-utils

chmod +x ./brasaplayer
mkdir -p ${HOME}/.local/bin
cp ./brasaplayer ${HOME}/.local/bin/brasaplayer

mkdir -p ${HOME}/.local/share/icons/hicolor/scalable/apps
cp ./brasaplayer.svg ${HOME}/.local/share/icons/hicolor/scalable/apps/
gtk-update-icon-cache "${HOME}/.local/share/icons/hicolor" >/dev/null 2>&1 || true

mkdir -p ${HOME}/.local/share/applications
cat > "${HOME}/.local/share/applications/brasaplayer.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=BrasaPlayer
Comment=Video player
Exec=${HOME}/.local/bin/brasaplayer %F
TryExec=${HOME}/.local/bin/brasaplayer
Icon=brasaplayer
Terminal=false
Categories=AudioVideo;Video;Player;GTK;
MimeType=video/mp4;video/x-matroska;video/webm;video/quicktime;video/x-msvideo;video/mpeg;video/ogg;
StartupNotify=true
EOF

update-desktop-database "${HOME}/.local/share/applications"
