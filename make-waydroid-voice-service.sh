#!/bin/bash
# Launch full program in a subshell

# Variables
WAYDROID_SERVICE_NAME="waydroid-voice"
SERVICE_FILE="$WAYDROID_SERVICE_NAME.service"
SERVICE_DIR="$HOME/.config/systemd/user"
SERVICE_PATH="$SERVICE_DIR/$SERVICE_FILE"
RUNTIME_SHELL_PATH="/usr/local/bin/waydroid-voice.sh"

# Create the service directory if it doesn't exist
sudo mkdir -p "$SERVICE_DIR"

# Create the runtime shell script
sudo tee "$RUNTIME_SHELL_PATH" > /dev/null << 'EOF'
#!/bin/bash

# Process names
process_name1="waydroid"
process_name2="surfaceflinger"
process_name3="pps.googlevoice"

# Loop indefinitely
while true; do

    # Check if processes are running
    is_running1=$(pgrep -x "$process_name1" > /dev/null; echo $?)
    is_running2=$(pgrep -x "$process_name2" > /dev/null; echo $?)
    is_running3=$(pgrep -x "$process_name3" > /dev/null; echo $?)

    # Process "waydroid-container" is found, but "surfaceflinger" is not found
    if [[ $is_running1 -eq 0 && $is_running2 -ne 0 ]]; then

        (
        echo '"waydroid-container" is found, but "surfaceflinger" is not found'
        # Your subshell commands here (for when "waydroid-container" is found, but "surfaceflinger" is not found)
        (waydroid session start) &
        sleep 60
        exit
        )

    # Process "surfaceflinger" is found, but "pps.googlevoice" is not found
    elif [[ $is_running2 -eq 2 && $is_running2 -ne 3 ]]; then

        (
        echo '"surfaceflinger" is found, but "pps.googlevoice" is not found'
        # Your subshell commands here (for when "surfaceflinger" is found, but "pps.googlevoice" is not found)
        (gtk-launch waydroid.com.google.android.apps.googlevoice.desktop)
        sleep 60
        exit
        )

    # Both "surfaceflinger" and "pps.googlevoice" are found
    elif [[ $is_running2 -eq 0 && $is_running3 -eq 0 ]]; then

        (
        echo "Running subshell C for when both processes are running."
        # Your subshell commands here (for when both processes are running)
        (gtk-launch waydroid.com.google.android.apps.googlevoice.desktop)
        (gdbus call --session --dest org.gnome.Shell --object-path /de/lucaswerkmeister/ActivateWindowByTitle --method de.lucaswerkmeister.ActivateWindowByTitle.activateBySubstring 'Voice') > /dev/null 2>&1 &
        sleep 3
        exit
        )
    
    # Neither "waydroid" nor "pps.googlevoice" are found
    elif [[ $is_running1 -ne 0 && $is_running2 -ne 0 ]]; then

        (
        echo "waydroid-container is not working! restart or get your sys admin!"
        # Your subshell commands here (for when neither processes are running)
        # ()
        sleep 3
        )
    fi

    # Sleep for a while to avoid overloading the CPU
    sleep 1
done	
EOF

# Make runtime shell script executable.
sudo chmod 0755 /usr/local/bin/waydroid-voice.sh

# Create the service file
cat << EOF > "$SERVICE_PATH"
[Unit]
Description=Waydroid Voice Service
After=waydroid-container.service

[Service]
TimeoutStartSec=666
Type=forking
ExecStart=/bin/bash -c '/usr/local/bin/waydroid-voice.sh'
Restart=always
RestartSec=8

[Install]
WantedBy=default.target
EOF

# Reload the systemd manager configuration
systemctl --user daemon-reload > /dev/null 2>&1 &

# Enable and start the service
systemctl --user enable --now "$WAYDROID_SERVICE_NAME" > /dev/null 2>&1 &
