# Autodarts Launcher for Arch Linux

A simple launcher for [Autodarts](https://autodarts.io) on Arch-based distributions. Created because Autodarts only provides a `.deb` installer for desktop Linux. This is a convenience package for starting the autodarts client and opening the browser when doing so.

## What It Does

- Auto-installs Autodarts if not present
- Starts the Autodarts systemd service (no sudo required after initial setup!)
- Opens the web interface and board configuration page automatically
- Shows service logs in the terminal
- Stops the service cleanly when you exit (Ctrl+C)
- Includes polkit rules to manage the service without password prompts

## Installation

```bash
git clone https://github.com/dmall00/autodarts-client-arch-launcher.git
cd autodarts-client-arch-launcher
makepkg -si
```

The `-si` flags will build and install the package, automatically handling dependencies.

## Usage

Launch from your application menu or run:

```bash
autodarts-launcher
```

## Upgrading

Pull the new version and run:

```bash
makepkg -si
```
