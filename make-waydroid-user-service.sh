# Create the service file
cat << EOF > "$SERVICE_PATH"
[Unit]
Description=Waydroid Service
After=network.target

[Service]
ExecStart=/bin/bash -c 'while pgrep -x "waydroid.com.google.android.youtube.kids" >/dev/null; do sleep 3; done'
ExecStartPost=-/bin/bash -c 'systemd-run --user --scope /usr/bin/waydroid app launch com.google.android.apps.youtube.kids'
Restart=always
RestartSec=3

[Install]
WantedBy=default.target
EOF

# Start the service
systemctl --user enable --now "$SERVICE_PATH"
