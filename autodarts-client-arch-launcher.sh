#!/bin/bash

# Detect if autodarts is a user service or system service
detect_service_type() {
    if systemctl --user list-unit-files | grep -q "autodarts.service"; then
        echo "user"
    elif systemctl list-unit-files | grep -q "autodarts.service"; then
        echo "system"
    else
        echo "none"
    fi
}

install_autodarts() {
    SERVICE_TYPE=$(detect_service_type)
    if [ "$SERVICE_TYPE" = "none" ]; then
        echo "Autodarts not found. Installing latest version..."
        echo "This requires sudo privileges for installation..."
        
        # Download and run installation script (compatible with all shells)
        INSTALL_SCRIPT=$(mktemp)
        curl -sL get.autodarts.io -o "$INSTALL_SCRIPT"
        sudo bash "$INSTALL_SCRIPT"
        rm -f "$INSTALL_SCRIPT"
        
        echo "Autodarts installed successfully."
        echo ""
        echo "Installation complete!"
        echo "Please log out and log back in for group permissions to take effect."
        echo "After re-login, you can run this launcher without sudo."
        exit 0
    fi
}

cleanup() {
    # Only try to stop if service actually exists
    if [ "$SERVICE_TYPE" != "none" ]; then
        echo "Stopping autodarts service..."
        if [ "$SERVICE_TYPE" = "user" ]; then
            systemctl --user stop autodarts 2>/dev/null
        else
            systemctl stop autodarts 2>/dev/null
        fi
        echo "Service stopped."
    fi
}

trap cleanup EXIT

install_autodarts

# Re-detect service type after potential installation
SERVICE_TYPE=$(detect_service_type)

echo "Starting autodarts service..."
if [ "$SERVICE_TYPE" = "user" ]; then
    systemctl --user start autodarts
else
    systemctl start autodarts
fi

sleep 2

echo "Opening play.autodarts.io in the browser..."
xdg-open "https://play.autodarts.io"
echo "Opening local config interface in the browser..."
xdg-open "http://192.168.178.33:3180/config"

echo "Showing autodarts service logs. Press Ctrl+C to exit and stop the service."

if [ "$SERVICE_TYPE" = "user" ]; then
    journalctl --user -u autodarts -f
else
    journalctl -u autodarts -f
fi