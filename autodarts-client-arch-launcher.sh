#!/bin/bash

show_usage() {
    echo "Usage: autodarts-launcher [command]"
    echo ""
    echo "Commands:"
    echo "  (none)    Start autodarts and open the browser"
    echo "  update    Re-pull and reinstall autodarts from https://autodarts.sh"
    echo ""
}

BASE_URL="https://autodarts.sh"

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
        echo ""

        INSTALL_SCRIPT=$(mktemp)
        curl -fsSL "$BASE_URL/sh/install.sh" -o "$INSTALL_SCRIPT"
        bash "$INSTALL_SCRIPT" --headless
        rm -f "$INSTALL_SCRIPT"

        echo ""
        echo "Installation complete!"
        echo "After re-login, you can run this launcher."
        exit 0
    fi
}

update_autodarts() {
    SERVICE_TYPE=$(detect_service_type)

    if [ "$SERVICE_TYPE" != "none" ]; then
        echo "Stopping autodarts service..."
        if [ "$SERVICE_TYPE" = "user" ]; then
            systemctl --user stop autodarts 2>/dev/null
        else
            if ! systemctl stop autodarts 2>/dev/null; then
                systemctl stop autodarts 2>/dev/null
            fi
        fi
        echo "Service stopped."
    fi

    echo "Updating autodarts..."
    echo ""

    INSTALL_SCRIPT=$(mktemp)
    curl -fsSL "$BASE_URL/sh/install.sh" -o "$INSTALL_SCRIPT"
    bash "$INSTALL_SCRIPT" --headless
    rm -f "$INSTALL_SCRIPT"

    echo ""
    echo "Update complete!"

    SERVICE_TYPE=$(detect_service_type)
    if [ "$SERVICE_TYPE" != "none" ]; then
        echo "Starting autodarts service..."
        if [ "$SERVICE_TYPE" = "user" ]; then
            systemctl --user start autodarts
        else
            if ! systemctl start autodarts 2>/dev/null; then
                systemctl start autodarts
            fi
        fi
        echo "Service started."
    else
        echo ""
        echo "Service not found after update."
        echo "Please log out and log back in for group permissions to take effect."
    fi

    exit 0
}

cleanup() {
    # Only try to stop if service actually exists
    if [ "$SERVICE_TYPE" != "none" ]; then
        echo ""
        echo "Stopping autodarts service..."
        if [ "$SERVICE_TYPE" = "user" ]; then
            systemctl --user stop autodarts 2>/dev/null
        else
            # For system service, try without sudo first
            if systemctl stop autodarts 2>/dev/null; then
                echo "Service stopped."
            else
                echo "Service stopped."
            fi
        fi
    fi
}

case "${1:-}" in
    update)
        update_autodarts
        ;;
    -h|--help|"")
        ;;
    *)
        echo "Unknown command: $1"
        echo ""
        show_usage
        exit 1
        ;;
esac

trap cleanup EXIT

# Check and install if needed (only prompts for sudo if not installed)
install_autodarts

# Re-detect service type after potential installation
SERVICE_TYPE=$(detect_service_type)

echo "Starting autodarts service..."
if [ "$SERVICE_TYPE" = "user" ]; then
    systemctl --user start autodarts
else
    # Try without sudo first, fall back to user service
    if ! systemctl start autodarts 2>/dev/null; then
        echo "System service detected. Trying to start user service..."
        systemctl --user start autodarts
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
        journalctl -u autodarts -f
    fi
fi
