#!/bin/bash

# Variables
WAYDROID_SERVICE_NAME="waydroid-youtube"
SERVICE_FILE="$WAYDROID_SERVICE_NAME.service"
SERVICE_DIR="$HOME/.config/systemd/user"
SERVICE_PATH="$SERVICE_DIR/$SERVICE_FILE"

# Create the service directory if it doesn't exist
mkdir -p "$SERVICE_DIR"

# Create the service file
cat << EOF > "$SERVICE_PATH"
[Unit]
Description=Waydroid Service
After=waydroid-user.service

[Service]
Type=forking
ExecStart=/bin/bash -c '/usr/bin/waydroid app launch com.google.android.youtube'
ExecStop=/bin/bash -c '/usr/bin/waydroid session stop'
Restart=on-failure
RestartSec=8

[Install]
WantedBy=default.target
EOF

# Start the service
systemctl --user enable --now "$SERVICE_PATH"
