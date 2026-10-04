# Services & Remote Access

## Background Detection

Open `autodarts` and install/manage the service through its **Service** section.
Do not use a legacy `autodarts service install` command: current upstream directs
service setup through the interactive screen.

On Linux, this is a systemd **user service**. Once installed:

```sh
systemctl --user status autodarts.service
journalctl --user -u autodarts.service -f
```

To stop or start background detection:

```sh
systemctl --user stop autodarts.service
systemctl --user start autodarts.service
```

These commands do not need sudo. They require an installed service and an
available user systemd session. Closing the launcher is not a service-stop command.

!!! warning "One detection process per camera set"
    Do not run the old system service, a separate foreground detector, and the
    Desktop App against the same cameras. Competing processes cause camera
    access failures.

## Run Without A Login Session

Systemd user services normally depend on the user's session. For a dedicated host
that must run before login and after logout, enable lingering if appropriate:

```sh
sudo loginctl enable-linger "$USER"
loginctl show-user "$USER" -p Linger
```

This is a host administration choice, not something the launcher changes silently.
The service must also be installed and enabled through the terminal app.

## Manage Another Computer's Board

Install the official headless CLI on the computer you will manage from. Discover
available boards with:

```sh
autodarts remote
```

Select the board from the terminal list. If discovery does not find it, provide
the board host's address directly:

```sh
autodarts remote -H 192.168.0.42
```

Replace the example IP with the actual LAN address. This is the command documented
in the official headless guide. The launcher's `config` command targets the local
machine; it does not forward remote options.

## Manage Over SSH

Connect to the board host, then run its terminal app:

```sh
ssh your-user@your-board-host
autodarts
```

If `autodarts` is not on that session's PATH, use `~/.local/bin/autodarts`.
Use the configuration command rather than the launcher's default action over SSH
when you do not want to open a local browser.
