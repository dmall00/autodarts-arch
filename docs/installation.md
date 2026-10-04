# Installation

## Requirements

- Arch Linux or an Arch-based distribution with `makepkg` and systemd.
- A normal user account with camera access and internet access for installation.
- Supported upstream hardware: the official headless guide lists Linux x86_64,
  arm64, and armv7l builds. The launcher package is architecture-independent;
  detection availability depends on upstream builds.
- A browser for Play, or another device for playing and completing sign-in.

!!! note "A headless board can still have a desktop"
    Here, headless means detection is managed through a terminal instead of the
    Desktop App. You can use this launcher on your everyday Linux desktop or
    configure a dedicated host over SSH.

## Build The Arch Package

Install build tools, then build as your normal user:

```sh
sudo pacman -S --needed base-devel git
git clone https://github.com/dmall00/autodarts-arch.git
cd autodarts-arch
makepkg -si
```

`makepkg -si` builds and installs the launcher, requesting administrator
privileges for dependencies and package installation. Do not run `makepkg` as root.

Start **Autodarts Launcher** from the application menu or run:

```sh
autodarts-launcher
```

On first launch, it downloads the official installer over HTTPS and runs it with
`--headless`. The stable detection release is installed for your user. This step
does not normally need sudo, but removing a legacy system-wide installation can.
Do not run the launcher or the v2 installer as root.

## Make The CLI Available In Fish

The launcher adds `~/.local/bin` to its own PATH. For direct upstream commands in
fish, run this once:

```fish
fish_add_path ~/.local/bin
autodarts --version
autodarts --help
```

`fish_add_path` persists the directory for later fish sessions. Bash users can
add `export PATH="$HOME/.local/bin:$PATH"` to their shell profile. You can also
use the full path `~/.local/bin/autodarts` without changing your shell setup.

The launcher uses Bash via its shebang; invoking it from fish is supported.

## Installed Files

| Location | Owner/purpose |
| --- | --- |
| `/usr/bin/autodarts-launcher` | Arch package: launcher command |
| `/usr/share/applications/autodarts.desktop` | Arch package: menu entry |
| `/usr/share/icons/hicolor/128x128/apps/autodarts.png` | Arch package: icon |
| `~/.local/share/autodarts/` | Upstream installer: headless bundle |
| `~/.local/bin/autodarts` | Upstream installer: CLI link |
| `~/.config/autodarts/` | Upstream board settings; preserve during migration |

Installing the binary does **not** install a background service. Continue with
[board setup](board-setup.md), then use the terminal screen's **Service** section
if needed.

## Upstream Alternatives

If you do not need the Arch launcher, install the official headless CLI directly:

```sh
curl -fsSL https://autodarts.sh | bash -s -- --headless
```

For a graphical board configuration window, use the
[official Desktop App](https://autodarts.com/downloads) instead. Avoid running
Desktop detection and headless detection against the same cameras simultaneously.
