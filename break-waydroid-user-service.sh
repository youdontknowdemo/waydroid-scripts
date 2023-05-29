#!/bin/bash

# Stop and disable the service
systemctl --user stop "waydroid-user.service"
systemctl --user disable "waydroid-user.service"
systemctl stop "waydroid-user.service"
systemctl disable "waydroid-user.service"

# Remove the service file
rm "/home/view/.config/systemd/user/waydroid-user.service"
rm "/etc/systemd/system/waydroid-user.service"

# Reload systemd user configuration
systemctl --user daemon-reload

# Remove the symlinks
SYMLINKS=(
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
