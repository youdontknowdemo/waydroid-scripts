#!/bin/bash


# Stop and disable the service
systemctl --user stop "waydroid-ytkids.service"
systemctl --user disable "waydroid-ytkids.service"
systemctl stop "waydroid-ytkids.service"
systemctl disable "waydroid-ytkids.service"

# Remove the service file
rm "/home/view/.config/systemd/user/waydroid-ytkids.service"
rm "/etc/systemd/system/waydroid-ytkids.service"

# Reload systemd user configuration
systemctl --user daemon-reload

# Remove the symlinks
SYMLINKS=(
    "/home/view/.config/systemd/user/default.target.wants/waydroid-ytkids.service"
    "/home/view/.config/systemd/user/waydroid-ytkids.service"
    "/etc/systemd/system/user/default.target.wants/waydroid-ytkids.service"
    "/etc/systemd/system/user/waydroid-ytkids.service"
)

for symlink in "${SYMLINKS[@]}"; do
    if [[ -L "$symlink" ]]; then
        rm "$symlink"
    fi
done
