{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    # package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    # package = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSOR = "1";
    NIXOS_OZONE_WL = "1";
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  # services.xserver.enable = true;
  # Enable the KDE Plasma Desktop Environment.
  # services.desktopManager.plasma6.enable = true;
  # services.displayManager.sddm.enable = false;
  # Configure keymap in X11
  # services.xserver.xkb = {
  #   layout = "pl";
  #   variant = "";
  # };
}
