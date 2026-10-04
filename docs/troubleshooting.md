# Migration & Troubleshooting

## Migrating From Legacy Detection

Autodarts 0.x used the browser Board Manager and a system-wide service. V2 uses
the terminal/Desktop app and a user-level installation. Stop and remove the old
installation before configuring v2 so the two do not compete for cameras.

Follow the official
[migration instructions](https://docs.autodarts.com/getting-started/detection/headless-installation/#upgrading-from-the-previous-version).
They describe disabling the old system service and removing its legacy files.
Those system-wide cleanup commands require sudo; this launcher does not manually
perform them. The official installer may also request privileges for legacy cleanup.

!!! warning "Preserve your settings"
    Keep `~/.config/autodarts`. Upstream documents picking up the existing board's
    sign-in on first start. Back up your settings before migrating; do not use
    purge/uninstall commands as a shortcut for upgrading.

When upgrading this Arch launcher package to 2.0.0, its old packaged polkit rule
is no longer installed. V2 user services do not need that system-wide permission.

## Board Manager Is No Longer Supported

This is expected from detection version 2 onward. Do not use
`http://localhost:3180/config` or the old Board Manager link in Play. Run:

```sh
autodarts-launcher config
```

Or use the official Desktop App. See the upstream
[deprecation explanation](https://docs.autodarts.com/getting-started/detection/autodarts-desktop/#board-manager-earlier-versions).

## Command Not Found

The upstream command is installed in `~/.local/bin`. In fish:

```fish
fish_add_path ~/.local/bin
autodarts --version
```

Alternatively run `~/.local/bin/autodarts`. The launcher handles this PATH itself.
If the launcher still opens the old configuration page, rebuild/install the new
package: source edits alone do not change `/usr/bin/autodarts-launcher`.

## Service Not Found

Installing the binary does not install a service. Open `autodarts` and use its
**Service** section. Check the user service, not the legacy system service:

```sh
systemctl --user status autodarts.service
```

If systemctl cannot reach the user bus, check that you are running as the correct
logged-in user, not through sudo or a different account. See
[background operation](operations.md) for dedicated hosts.

## Cameras Or Detection Fail

Check that the terminal app has the correct camera selections, that your user can
access the video devices, and that no legacy detector or separate Desktop instance
is occupying the cameras. Revisit calibration and test real throws. For background
detection, inspect logs:

```sh
journalctl --user -u autodarts.service -f
```

The launcher only starts the upstream app; camera hardware and detection behavior
belong to upstream Autodarts.

## Download Or Update Fails

Check internet connectivity and the installer's error output. The launcher fails
with a nonzero status on download/installation failure rather than announcing
success. When already installed, update output and status come from the official
`autodarts update` command. The launcher does not stop services before downloading.

## Remove The Launcher

```sh
sudo pacman -R autodarts-client-arch-launcher
```

This removes the Arch launcher package, not the separately installed upstream
detector or your settings. To remove those, follow the official
[headless uninstall guide](https://docs.autodarts.com/getting-started/detection/headless-installation/#uninstalling).
