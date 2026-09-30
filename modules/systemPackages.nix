{
  pkgs,
  lib,
  ...
}:

{
  environment.systemPackages = with pkgs; [
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
  ];

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "vivaldi"
    ];
}
