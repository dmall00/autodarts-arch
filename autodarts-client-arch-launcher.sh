#!/bin/bash

cleanup() {
   echo "Stopping autodarts service..."
   systemctl stop autodarts
   echo "Service stopped."
}

trap cleanup EXIT

echo "Starting autodarts service..."odarts Launcher Script
# This script starts the autodarts service, opens browser tabs,  
# shows live logs in terminal, and stops service on exit

# Cleanup function to stop the service
cleanup() {
   echo "Stopping autodarts service..."
   systemctl stop autodarts
   echo "Service stopped."
}

# Set trap to call cleanup function on script exit
trap cleanup EXIT

# Start the autodarts service
echo "Starting autodarts service..."
systemctl start autodarts

sleep 2

echo "Opening play.autodarts.io in the browser..."
xdg-open "https://play.autodarts.io"
echo "Opening local config interface in the browser..."
xdg-open "http://192.168.178.33:3180/config"

echo "Showing autodarts service logs. Press Ctrl+C to exit and stop the service."

journalctl -u autodarts -f