{
  pkgs,
  lib,
  ...
}:

{
  environment.systemPackages = (
    with pkgs;
    [
      # core
      waybar
      awww
      rofi
      wl-clipboard
      swaynotificationcenter
      libnotify
      brave
      hyprsunset
      pavucontrol
      alsa-utils

      # apps
      swayimg
      vivaldi
      libreoffice
      webcord
      vesktop
      gimp3
      zathura
      firefox

      # utils
      brightnessctl
      zenity
      xarchiver
      overskride
      gcolor3
      simple-mtpfs
      v4l-utils

      # screenshot utils
      grim
      slurp
      swappy
      hyprpicker

      # escape hatch
      distrobox

      # for yazi
      kitty
    ]
  );

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "vivaldi"
    ];

  # ++
  #
  #   (with pkgs-stable; [
  #     hello
  #   ])
  #
  # ++
  #
  #   [
  #     inputs.wezterm.packages.${pkgs.system}.default
  #   ];
}
