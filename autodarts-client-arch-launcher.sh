#!/bin/bash

LAUNCHER_VERSION="2.0.0"
INSTALL_URL="https://autodarts.sh/sh/install.sh"

show_usage() {
    echo "Usage: autodarts-launcher [command]"
    echo ""
    echo "Commands:"
    echo "  (none)     Open Autodarts Play and the board's terminal app"
    echo "  config     Open the terminal app without opening a browser"
    echo "  update     Update Autodarts detection using its official CLI"
    echo "  --version  Show the launcher version (not the detection version)"
    echo "  --help     Show this help"
}

if [ "$#" -gt 1 ]; then
    show_usage >&2
    exit 1
fi

case "${1:-}" in
    -h|--help)
        show_usage
        exit 0
        ;;
    -v|--version)
        echo "autodarts-launcher $LAUNCHER_VERSION"
        exit 0
        ;;
    ""|config|update)
        ;;
    *)
        echo "Unknown command: $1" >&2
        show_usage >&2
        exit 1
        ;;
esac

# The upstream installer puts the CLI here, even when the login PATH omits it.
export PATH="$HOME/.local/bin:$PATH"

if ! command -v autodarts >/dev/null 2>&1; then
    echo "Installing Autodarts v2 headless for your user..."
    INSTALL_SCRIPT=$(mktemp) || exit 1
    trap 'rm -f "$INSTALL_SCRIPT"' EXIT
    if ! curl -fsSL "$INSTALL_URL" -o "$INSTALL_SCRIPT"; then
        echo "Could not download the Autodarts installer." >&2
        exit 1
    fi
    if ! bash "$INSTALL_SCRIPT" --headless; then
        echo "Autodarts installation failed." >&2
        exit 1
    fi
    rm -f "$INSTALL_SCRIPT"
    trap - EXIT
    if ! command -v autodarts >/dev/null 2>&1; then
        echo "Installer finished, but the autodarts command was not found." >&2
        exit 1
    fi
    # A fresh installation already downloaded the latest detection release.
    if [ "${1:-}" = "update" ]; then
        exit 0
    fi
fi

if [ "${1:-}" = "update" ]; then
    exec autodarts update
fi

if [ -z "${1:-}" ]; then
    xdg-open "https://play.autodarts.com" &
fi

echo "Opening the Autodarts terminal app. Configure background operation in its Service section."
exec autodarts
