# Autodarts Launcher for Arch Linux

A community-maintained Arch package for the **Autodarts v2 headless terminal
app**. It provides a launcher, menu entry, and icon; the official installer
downloads detection separately into your user account.

Launcher **2.0.0** opens Autodarts Play and the interactive board terminal app.
It no longer opens the deprecated browser Board Manager or manages system-wide
services. Configure background operation in the terminal app's **Service** section.

## Quick Start

```sh
sudo pacman -S --needed base-devel git
git clone https://github.com/dmall00/autodarts-arch.git
cd autodarts-arch
makepkg -si
autodarts-launcher
```

Build as your normal user. Installing the Arch package needs administrator rights;
the upstream v2 installation normally does not. Legacy system cleanup may require
sudo. Do not run the launcher as root.

```sh
autodarts-launcher config     # Configure locally without opening Play
autodarts-launcher update     # Update upstream detection
autodarts-launcher --help
autodarts-launcher --version  # Launcher version, separate from detection
```

For direct CLI access from fish, run `fish_add_path ~/.local/bin`, then `autodarts`.
The interactive setup handles sign-in, board selection, cameras, and calibration.
There are no documented `autodarts cameras` or `autodarts calibrate` subcommands.

## Documentation

The repository includes a styled, searchable MkDocs Material documentation site:

- [Project overview](docs/index.md)
- [Installation and fish setup](docs/installation.md)
- [Configure your board](docs/board-setup.md)
- [Command reference and updates](docs/commands.md)
- [Services and remote management](docs/operations.md)
- [Migration and troubleshooting](docs/troubleshooting.md)
- [Documentation development and official sources](docs/contributing.md)

Preview locally without activating a shell-specific virtual environment:

```sh
python -m venv .venv
.venv/bin/python -m pip install -r requirements-docs.txt
.venv/bin/mkdocs serve
```

Open `http://127.0.0.1:8000`. Build the static site with
`.venv/bin/mkdocs build --strict`.

## Upgrade The Launcher

From your checkout:

```sh
git pull
makepkg -si
```

Source edits do not replace `/usr/bin/autodarts-launcher` until the package is
rebuilt and installed. `autodarts-launcher update` updates detection only.

## Upstream

Board Manager on port 3180 is unsupported from Autodarts v2 onward. Use this
terminal path or the [official Desktop App](https://autodarts.com/downloads).
See the [official headless guide](https://docs.autodarts.com/getting-started/detection/headless-installation/)
for the source documentation, checked on 2026-10-04.
