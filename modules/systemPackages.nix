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
      awww
      rofi
      wl-clipboard
      swaynotificationcenter
      libnotify
      brave
      hyprsunset
      pavucontrol
      alsa-utils
      hyprshutdown

      # apps
      swayimg
      vivaldi
      libreoffice
      webcord
      vesktop
      gimp3
      zathura
      firefox
      element-desktop

      # utils
      brightnessctl
      zenity
      xarchiver
      overskride
      gcolor3
      v4l-utils
      impala

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
