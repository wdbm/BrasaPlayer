#!/bin/bash

APP_ID="io.github.wdbm.brasaplayer"
APP_NAME="BrasaPlayer"

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
mkdir -p ${HOME}/.local/share/icons/hicolor/256x256/apps
cp ./brasaplayer.svg "${HOME}/.local/share/icons/hicolor/scalable/apps/${APP_ID}.svg"
cp ./brasaplayer.png "${HOME}/.local/share/icons/hicolor/256x256/apps/${APP_ID}.png"
gtk-update-icon-cache "${HOME}/.local/share/icons/hicolor" >/dev/null 2>&1 || true

mkdir -p "${HOME}/.local/share/dbus-1/services"
cat > "${HOME}/.local/share/dbus-1/services/${APP_ID}.service" <<EOF
[D-BUS Service]
Name=${APP_ID}
Exec=${HOME}/.local/bin/brasaplayer --gapplication-service
EOF

mkdir -p ${HOME}/.local/share/applications
rm -f "${HOME}/.local/share/applications/brasaplayer.desktop"
cat > "${HOME}/.local/share/applications/${APP_ID}.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=${APP_NAME}
Comment=Video player
Exec=${HOME}/.local/bin/brasaplayer %F
TryExec=${HOME}/.local/bin/brasaplayer
Icon=${APP_ID}
Terminal=false
Categories=AudioVideo;Video;Player;GTK;
MimeType=video/mp4;video/x-matroska;video/webm;video/quicktime;video/x-msvideo;video/mpeg;video/ogg;
StartupNotify=true
DBusActivatable=true
EOF

update-desktop-database "${HOME}/.local/share/applications"
