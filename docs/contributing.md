# Documentation & Sources

## Preview This Site

The documentation uses MkDocs Material with search, light/dark themes, copyable
command blocks, and responsive navigation. Pages live in `docs/`; site navigation
is defined in `mkdocs.yml`.

Create a local Python environment and install the pinned documentation dependency:

```sh
python -m venv .venv
.venv/bin/python -m pip install -r requirements-docs.txt
.venv/bin/mkdocs serve
```

Open `http://127.0.0.1:8000`. These explicit paths work from fish or Bash without
activating the environment. To validate and build a static site:

```sh
.venv/bin/mkdocs build --strict
```

The result is in `site/`, which is ignored by git. It can be published by any static
web host; this repository does not require a hosting account to preview the docs.

## Check The Package

```sh
bash -n autodarts-client-arch-launcher.sh
desktop-file-validate autodarts.desktop
makepkg --force
```

Package installation is a separate step needing administrator privileges. Build
and inspect changes before replacing the installed launcher. Do not test detection
against occupied cameras or change another user's background service unexpectedly.

## Source Of Truth

Official documentation was fetched and checked on **2026-10-04**. These guides
summarize the upstream workflow; they do not replace upstream documentation.

| Source | What it verifies |
| --- | --- |
| [Headless installation](https://docs.autodarts.com/getting-started/detection/headless-installation/) | Install flags, interactive sign-in, service section, remote access, updating, migration |
| [Shared first-time setup](https://docs.autodarts.com/getting-started/detection/autodarts-desktop/#first-time-setup) | Board naming, camera choices, calibration, test throws |
| [Board Manager deprecation](https://docs.autodarts.com/getting-started/detection/autodarts-desktop/#board-manager-earlier-versions) | Port-3180 configuration is unsupported from v2 onward |
| [Official downloads](https://autodarts.com/downloads) | Desktop and headless installation paths |
| [Official installer](https://autodarts.sh/sh/install.sh) | Per-user installation and installed paths |

The installed v2.0.2 `autodarts --help` was also checked for the foreground `run`
command and CLI options. The headless guide does not document all terminal
keybindings; do not invent configuration subcommands or assume Desktop screenshots
exactly match the terminal screen.

Older `docs.autodarts.io` pages may describe the pre-v2 Board Manager. Prefer the
current v2 references above. Update the verification date and links when changing
documented upstream behavior.
