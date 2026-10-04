# Configure Your Board

## Open The Terminal App

```sh
autodarts-launcher config
```

Or invoke upstream directly:

```sh
autodarts
```

This opens an **interactive terminal screen**, not the old Board Manager web page.
The official [headless setup guide](https://docs.autodarts.com/getting-started/detection/headless-installation/#setting-it-up)
describes the workflow below.

!!! important "Use the interactive app, not invented subcommands"
    Camera setup and calibration are done in the terminal screen. Upstream does
    not document `autodarts cameras` or `autodarts calibrate` commands.
    `autodarts run` runs detection in the foreground; plain `autodarts` is the
    entry point for interactive configuration.

## 1. Sign In

The terminal displays a QR code, a web address, and a short code. Scan the QR code
with your phone, or open the displayed address on any device and sign in to your
Autodarts account. Follow the confirmation flow shown on screen.

V2 connects the board through sign-in. You no longer need to copy a Board ID and
API key into the retired browser Board Manager.

## 2. Create Or Claim A Board

Give a new board a name, or choose an existing board to move to this machine.
For migration, preserve the old settings directory; upstream documents carrying
over the board's sign-in. See [migration](troubleshooting.md#migrating-from-legacy-detection).

## 3. Select Your Cameras

Follow the setup flow in the terminal screen. The headless documentation refers
to the [shared first-time setup](https://docs.autodarts.com/getting-started/detection/autodarts-desktop/#first-time-setup):
for each feed, select its camera, resolution, frame rate, and standby time.

Camera count comes from your hardware. Check that each selected camera is aimed
at the board and that no other detection process has opened the same cameras.

## 4. Calibrate

Complete the calibration flow for each camera. In the shared setup guide, the
highlighted segment overlay is rotated until it aligns with the board's **20**
segment, using the rotation controls.

!!! note "Shared workflow, different interface"
    The official headless guide links to Desktop's camera/calibration steps but
    does not detail every terminal keybinding or screen. Use the controls shown
    by your installed terminal app. Desktop screenshots explain the operations,
    not identical terminal buttons.

## 5. Test Real Throws

Throw a few real darts and confirm detection reports the expected segments.
Remove the darts and check the board returns to the appropriate ready state.
If detection is incorrect, revisit camera selection and calibration before playing.

Open [Autodarts Play](https://play.autodarts.com), sign in with the same account,
and select the board for autoscoring. The Play website is the match interface;
board setup stays in the terminal app or Desktop App.

## 6. Choose How It Runs

Without a service, the board runs while the terminal app is open. To keep it
running in the background, open **Service** in the terminal app and install the
service there.

The launcher does not stop an installed service when it closes. For a dedicated
host, see [services and remote access](operations.md) for logs, lifecycle commands,
and the systemd user-session considerations.
