# VNC setup

Run an Xfce desktop over TigerVNC on an Ubuntu host whose console runs GNOME
(Wayland), and connect to it remotely through an SSH tunnel.

## Server

Install TigerVNC and Xfce, then set a password (VNC truncates it to 8
characters; answer `n` to the view-only prompt):

    sudo apt install tigervnc-standalone-server xfce4
    vncpasswd

Create `~/.config/tigervnc/xstartup` and make it executable:

    #!/bin/sh
    # Isolate from the console GNOME (Wayland) session.
    unset WAYLAND_DISPLAY
    export GDK_BACKEND=x11
    export XDG_SESSION_TYPE=x11
    xrdb "$HOME/.Xresources"
    exec dbus-run-session -- startxfce4

Start and stop the server:

    vncserver :2
    vncserver -kill :2

The server listens on localhost only (port 5902 for display `:2`).

### Why the xstartup is needed

- Without it, `/etc/X11/Xsession` runs `x-session-manager`, which points to
  `gnome-session`. That aborts with "A graphical session is already running!"
  because the console GNOME session is active, and the VNC session exits
  within seconds.
- `~/.vnc/xstartup` is ignored by this TigerVNC; it reads
  `~/.config/tigervnc/xstartup`.
- `dbus-run-session` gives Xfce its own session bus rather than the shared
  GNOME one.
- If `WAYLAND_DISPLAY` is inherited, GTK programs such as `xfce4-panel` use
  Wayland and draw over the console GNOME desktop instead of the VNC display.
  Unsetting it and forcing `GDK_BACKEND=x11` keeps them on the VNC display.

### Troubleshooting

- Server log: `~/.config/tigervnc/<host>:2.log`; session errors:
  `~/.xsession-errors`.
- After a failed attempt, Xfce processes can outlive `vncserver -kill`. Kill
  any stale `xfce4-session` and `xfce4-panel` before restarting, or they keep
  drawing over the GNOME desktop.
- To reset the password, run `vncpasswd` again; no restart is needed.

## Connecting remotely

The traffic is unencrypted, so always tunnel over SSH.

    ssh -N -L 5902:localhost:5902 user@host

Then connect a VNC viewer to `localhost:5902`. With the TigerVNC viewer the
tunnel can be built in:

    xtigervncviewer -via user@host -SecurityTypes VncAuth localhost::5902

If port 5902 is busy locally, forward another, e.g. `-L 5999:localhost:5902`.

### macOS

The built-in Screen Sharing (`open vnc://localhost:5902`) fails with "The
software on the remote computer appears to be incompatible with this version of
Screen Sharing", because TigerVNC offers plain `VncAuth`. Use the TigerVNC
viewer instead:

    brew install --cask tigervnc-viewer

### Windows

Use the TigerVNC viewer or RealVNC Viewer against `localhost:5902` with the
tunnel running.
