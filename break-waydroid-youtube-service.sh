#!/bin/bash

# Stop and disable the service
systemctl --user stop "waydroid-youtube.service"
systemctl --user disable "waydroid-youtube.service"
systemctl stop "waydroid-youtube.service"
systemctl disable "waydroid-youtube.service"

# Remove the service file
rm "/home/view/.config/systemd/user/waydroid-youtube.service"
rm "/etc/systemd/system/waydroid-youtube.service"

# Reload systemd user configuration
systemctl --user daemon-reload

# Remove the symlinks
SYMLINKS=(
    "/home/view/.config/systemd/user/default.target.wants/waydroid-youtube.service"
    "/home/view/.config/systemd/user/waydroid-youtube.service"
    "/etc/systemd/system/user/default.target.wants/waydroid-youtube.service"
    "/etc/systemd/system/user/waydroid-youtube.service"
)

for symlink in "${SYMLINKS[@]}"; do
    if [[ -L "$symlink" ]]; then
        rm "$symlink"
    fi
done
