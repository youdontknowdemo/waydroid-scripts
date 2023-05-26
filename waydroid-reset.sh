#!/bin/bash

# Define URL of the System and Vendor OTAs
SYSTEM_OTA_URL="https://ota.waydro.id/system"
VENDOR_OTA_URL="https://ota.waydro.id/vendor"

# System type
SYSTEM_TYPE="GAPPS"

# Stop waydroid-container.service
echo "Stopping waydroid-container.service..."
sudo systemctl stop waydroid-container.service

# Clean up directories and files
echo "Cleaning up Waydroid..."
sudo rm -rf /var/lib/waydroid /home/.waydroid ~/waydroid ~/.share/waydroid ~/.local/share/applications/*aydroid* ~/.local/share/waydroid

# Initialize Waydroid with the OTA images and the specified system type
echo "Initializing Waydroid..."
sudo waydroid init -f -c $SYSTEM_OTA_URL -v $VENDOR_OTA_URL -s $SYSTEM_TYPE
sleep 8

# Restart the service for the changes to take effect
echo "Restarting waydroid-container.service..."
sudo systemctl restart waydroid-container.service

# Start a Waydroid session
echo "Starting Waydroid session in background..."
waydroid session start &

# Sleep for 210 seconds to give Waydroid time to start
echo "Waiting 210 seconds for Waydroid to start..."
sleep 210

# Google Play certification
echo "Starting Google Play certification process..."
echo "Your Android ID is:"
echo 'ANDROID_RUNTIME_ROOT=/apex/com.android.runtime ANDROID_DATA=/data ANDROID_TZDATA_ROOT=/apex/com.android.tzdata ANDROID_I18N_ROOT=/apex/com.android.i18n sqlite3 /data/data/com.google.android.gsf/databases/gservices.db "select * from main where name = \"android_id\";"' | sudo waydroid shell
echo "Please visit the following URL to register your Android ID: https://www.google.com/android/uncertified"
sleep 8

# Set multi_windows property
echo "Setting multi_windows property..."
waydroid prop set persist.waydroid.multi_windows true

echo "Waydroid has been reset successfully."
echo "Please visit the following URL to register your Android ID: https://www.google.com/android/uncertified"
sleep 8

# Set multi_windows property
echo "Setting multi_windows property..."
sudo waydroid prop set persist.waydroid.multi_windows true

echo "Waydroid has been reset successfully. Pro-tip: clear your cache and data for google services in the android settings menu to log into google immediatly"
