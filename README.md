# Autodarts Launcher for Arch Linux

A simple launcher for [Autodarts](https://autodarts.io) on Arch-based distributions. Created because Autodarts only provides a `.deb` installer for desktop Linux, this package wraps the installer and provides a convenient way to start, use, and update the Autodarts client.

## What It Does

When launched, the script:

1. Checks if Autodarts is installed. If not, downloads and runs the official installer from `get.autodarts.io` and then exits so you can re-login for group permissions to take effect.
2. Starts the Autodarts systemd service (user or system scope, auto-detected).
3. Opens `https://play.autodarts.io` and `http://127.0.0.1:3180/config` in your browser.
4. Streams live service logs to the terminal.
5. Stops the service cleanly when you exit with `Ctrl+C`.

Polkit rules are included so service management works without password prompts after installation.

## Installation

```bash
git clone https://github.com/dmall00/autodarts-client-arch-launcher.git
cd autodarts-client-arch-launcher
makepkg -si
```

The `-si` flags build and install the package, automatically handling dependencies (`xdg-utils`, `systemd`, `curl`, `polkit`).

## Usage

Launch from your application menu or run:

```bash
autodarts-launcher
```

### Update Autodarts

To update Autodarts to the latest version:

```bash
autodarts-launcher update
```

This will:

1. Stop the running Autodarts service.
2. Download and run the latest installer from `get.autodarts.io`.
3. Restart the service automatically.

## Upgrading the Launcher Package

To upgrade the launcher itself (not Autodarts), pull the latest version and reinstall:

```bash
git pull
makepkg -si
```
