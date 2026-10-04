# Autodarts Arch

<div class="hero" markdown>
<span class="eyebrow">Community launcher / Version 2.0.0</span>

## Your board. Your terminal.

A small Arch Linux package that connects the official Autodarts v2 terminal app
with your desktop. Configure cameras in the terminal, play in the browser, and
keep detection running the way you choose.

[Install the launcher](installation.md) / [Configure your board](board-setup.md)
</div>

## One Launcher, Two Jobs

```sh
autodarts-launcher         # Open Play and the board's terminal app
autodarts-launcher config  # Open just the board's terminal app
```

The launcher installs the official stable headless software if it is missing,
then opens its interactive screen. It adds an application-menu entry and icon,
and delegates detection updates to the official CLI.

<div class="quick-links" markdown>
<div markdown>

### Start Here

Build the Arch package and make the upstream command available in fish.

[Installation guide](installation.md)
</div>
<div markdown>

### Set Up Detection

Sign in, claim a board, select cameras, calibrate, and test real throws.

[Board setup](board-setup.md)
</div>
<div markdown>

### Run It Your Way

Use a background user service, manage a remote board, or inspect logs.

[Operations guide](operations.md)
</div>
</div>

## What This Project Is

| This package provides | Upstream Autodarts provides |
| --- | --- |
| `/usr/bin/autodarts-launcher` | The `autodarts` terminal app and detection engine |
| An Arch package and menu entry | Sign-in, board configuration, and camera calibration |
| First-run installer integration | The headless installer and detection releases |
| A shortcut to Play and configuration | The Play website and official Desktop App |

This is an unofficial convenience package, not a replacement detection engine or
the official Desktop App. The package does not bundle or pin a detection release.
The installer downloads detection into your own account.

## Why Version 2?

The original project wrapped the legacy Linux installation because upstream's
Desktop installer was a `.deb`. Upstream now provides a Linux Desktop App too.
This project's focus is the **headless/terminal management path on Arch**.

!!! warning "The old Board Manager is gone"
    Autodarts v2 does not support configuration through port 3180. Use the
    interactive terminal app or the official Desktop App. Play is for matches,
    not a replacement browser-based configuration manager.

Launcher 2.0.0 no longer opens the old configuration URL, manually starts/stops
system services, or installs broad system-wide polkit rules. Background operation
is configured through the upstream terminal app's **Service** section.

The **launcher version** and **detection version** are independent:

```sh
autodarts-launcher --version  # This project's release
autodarts --version           # Upstream detection release
```
