#!/bin/bash

# Variables
WAYDROID_SERVICE_NAME="waydroid-user"
SERVICE_FILE="waydroid-user.service"
SERVICE_DIR="/home/view/.config/systemd/user"
SERVICE_PATH="/home/view/.config/systemd/user/waydroid.service"

# Stop and disable the service
systemctl --user stop "waydroid.service"
systemctl --user disable "waydroid.service"
systemctl --user stop "waydroid-user.service"
systemctl --user disable "waydroid-user.service"
systemctl stop "waydroid.service"
systemctl disable "waydroid.service"
systemctl stop "waydroid-user.service"
systemctl disable "waydroid-user.service"

# Remove the service file
rm "/home/view/.config/systemd/user/waydroid.service"
rm "/home/view/.config/systemd/user/waydroid-user.service"
rm "/etc/systemd/system/waydroid.service"
rm "/etc/systemd/system/waydroid-user.service"

# Reload systemd user configuration
systemctl --user daemon-reload

# Remove the symlinks
SYMLINKS=(
    "/home/view/.config/systemd/user/default.target.wants/waydroid.service"
    "/home/view/.config/systemd/user/waydroid.service"
    "/etc/systemd/system/user/default.target.wants/waydroid.service"
    "/etc/systemd/system/user/waydroid.service"
    "/home/view/.config/systemd/user/default.target.wants/waydroid-user.service"
    "/home/view/.config/systemd/user/waydroid-user.service"
    "/etc/systemd/system/user/default.target.wants/waydroid-user.service"
    "/etc/systemd/system/user/waydroid-user.service"
)

for symlink in "${SYMLINKS[@]}"; do
    if [[ -L "$symlink" ]]; then
        rm "$symlink"
    fi
done
