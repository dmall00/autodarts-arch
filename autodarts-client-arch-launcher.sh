#!/bin/bash

# Detect if autodarts is a user service or system service
detect_service_type() {
    if systemctl --user list-unit-files | grep -q "autodarts.service"; then
        echo "user"
    elif systemctl list-unit-files 2>/dev/null | grep -q "autodarts.service"; then
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
        echo ""
        
        # Download and run installation script
        INSTALL_SCRIPT=$(mktemp)
        curl -sL get.autodarts.io -o "$INSTALL_SCRIPT"
        sudo bash "$INSTALL_SCRIPT"
        rm -f "$INSTALL_SCRIPT"
        
        echo ""
        echo "Installation complete!"
        echo "Please log out and log back in for group permissions to take effect."
        echo "After re-login, you can run this launcher."
        exit 0
    fi
}

cleanup() {
    # Only try to stop if service actually exists
    if [ "$SERVICE_TYPE" != "none" ]; then
        echo ""
        echo "Stopping autodarts service..."
        if [ "$SERVICE_TYPE" = "user" ]; then
            systemctl --user stop autodarts 2>/dev/null
        else
            # For system service, check if we need sudo
            if systemctl stop autodarts 2>/dev/null; then
                echo "Service stopped."
            else
                sudo systemctl stop autodarts 2>/dev/null
                echo "Service stopped."
            fi
        fi
    fi
}

trap cleanup EXIT

# Check and install if needed (only prompts for sudo if not installed)
install_autodarts

# Re-detect service type after potential installation
SERVICE_TYPE=$(detect_service_type)

echo "Starting autodarts service..."
if [ "$SERVICE_TYPE" = "user" ]; then
    systemctl --user start autodarts
else
    # Try without sudo first, fall back to sudo if needed
    if ! systemctl start autodarts 2>/dev/null; then
        echo "System service detected. Requesting sudo for service management..."
        sudo systemctl start autodarts
    fi
fi

sleep 2

echo "Opening play.autodarts.io in the browser..."
xdg-open "https://play.autodarts.io" &

echo "Opening local config interface in the browser..."
xdg-open "http://127.0.0.1:3180/config" &

echo ""
echo "Autodarts is running. Service logs shown below."
echo "Press Ctrl+C to exit and stop the service."
echo "----------------------------------------"
echo ""

if [ "$SERVICE_TYPE" = "user" ]; then
    journalctl --user -u autodarts -f
else
    # Try without sudo first
    if ! journalctl -u autodarts -f 2>/dev/null; then
        sudo journalctl -u autodarts -f
    fi
fi
