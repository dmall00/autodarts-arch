# Command Reference

## Launcher Commands

| Command | Behavior |
| --- | --- |
| `autodarts-launcher` | Open Play in the browser and the interactive board terminal app |
| `autodarts-launcher config` | Open the terminal app without launching a browser |
| `autodarts-launcher update` | Delegate to the official `autodarts update` command |
| `autodarts-launcher --help` | Show usage without installing or starting anything |
| `autodarts-launcher --version` | Show launcher version 2.0.0 |

`-h` and `-v` are also accepted. Unknown commands and extra arguments return a
nonzero status. The launcher accepts one command, not arbitrary upstream flags.
Use `autodarts` directly for upstream options or remote access.

If the upstream CLI is missing, `config`, `update`, and normal launch install the
latest stable headless release first. A fresh `update` installation already
downloads the newest release, so it does not update a second time.

## Upstream CLI

Commands documented by the current official guide and the installed v2.0.2 help:

```sh
autodarts                      # Interactive local board screen
autodarts run                  # Run detection in the foreground
autodarts remote               # Discover and manage a remote board
autodarts remote -H 192.168.0.42 # Connect directly by LAN address
autodarts update               # Install the latest detection release
autodarts --version            # Detection version, not launcher version
autodarts --help               # Options supported by your installed version
```

The v2.0.2 help also lists `--port`/`-p` (board API port), `--host`/`-H`
(board host), and `--config`/`-c` (configuration file). Consult the installed help
before overriding these; normal setup uses the user's own configuration.

## Update The Right Component

**Detection software:** use the board screen's update offer, or:

```sh
autodarts-launcher update
```

**This Arch launcher package:** from your checkout:

```sh
git pull
makepkg -si
```

The launcher does not pin detection to version 2.0.0 or 2.0.2. Its own version
identifies this project's release; the official updater controls detection.

## Try The Checkout

Before installing an edited launcher:

```sh
bash ./autodarts-client-arch-launcher.sh --help
bash ./autodarts-client-arch-launcher.sh --version
bash ./autodarts-client-arch-launcher.sh config
```

Editing this source file does not replace the installed `/usr/bin` command.
Rebuild and install the package to apply changes to the menu entry and command.
