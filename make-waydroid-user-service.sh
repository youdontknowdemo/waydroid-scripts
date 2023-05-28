#!/bin/bash
##################################################################################
##### WILL NOT WORK UNLESS: waydroid prop set persist.waydroid.multi_windows flase
##################################################################################

# Variables
WAYDROID_SERVICE_NAME="waydroid-user"
WAYDROID_BINARY_PATH="/usr/bin/waydroid"
WAYDROID_OPTIONS="session start"
SERVICE_FILE="$WAYDROID_SERVICE_NAME.service"
SERVICE_DIR="$HOME/.config/systemd/user"
SERVICE_PATH="$SERVICE_DIR/$SERVICE_FILE"

# Create the service directory if it doesn't exist
mkdir -p "$SERVICE_DIR"

# Create the service file
cat << EOF > "$SERVICE_PATH"
[Unit]
Description=Waydroid Service
After=network.target

[Service]
ExecStart=/bin/bash -c 'while pgrep -x "waydroid.com.google.android.apps.youtube.kids" >/dev/null; do sleep 3; done'
ExecStartPost=-/bin/bash -c 'systemd-run --user --scope /usr/bin/waydroid app launch com.google.android.apps.youtube.kids'
Restart=always
RestartSec=3

[Install]
WantedBy=default.target
EOF

# Start the service
systemctl --user enable --now "$SERVICE_PATH"
