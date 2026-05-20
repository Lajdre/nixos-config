{ config, host, ... }:

{
  home.file.".config/hypr_per_host/conf/monitor.conf".text =
    if host == "master" then
      ''
        monitor = , 2560x1440@60, 0x0, 1
      ''
    else if host == "amir" then
      ''
        monitor = eDP-1, 2560x1600@180, 0x0, 1.25
      ''
    else
      ''
        monitor = , 1920x1080@60, 0x0, 1
      '';

  home.file.".config/hypr/" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/hmModules/hyprland/hypr/";
    recursive = true;
  };
}
