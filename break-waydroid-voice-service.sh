#!/bin/bash

# Stop and disable the service
systemctl --user stop "waydroid-voice.service"
systemctl --user disable "waydroid-voice.service"
systemctl stop "waydroid-voice.service"
systemctl disable "waydroid-voice.service"

# Remove the service file
rm "/home/view/.config/systemd/user/waydroid-voice.service"
rm "/etc/systemd/system/waydroid-voice.service"

# Reload systemd user configuration
systemctl --user daemon-reload

# Remove the symlinks
SYMLINKS=(
    "/home/view/.config/systemd/user/default.target.wants/waydroid-voice.service"
    "/home/view/.config/systemd/user/waydroid-voice.service"
    "/etc/systemd/system/user/default.target.wants/waydroid-voice.service"
    "/etc/systemd/system/user/waydroid-voice.service"
)

for symlink in "${SYMLINKS[@]}"; do
    if [[ -L "$symlink" ]]; then
        rm "$symlink"
    fi
done
