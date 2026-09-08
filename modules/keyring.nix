{ ... }:

{
  # Secret Service (D-Bus) for Chromium/Electron apps.
  # Auto-unlocks at login via PAM (ly delegates to the login PAM stack).
  # Apps must also be pointed at it - see the password-store overlay in overlays.nix.
  services.gnome.gnome-keyring.enable = true;
}
