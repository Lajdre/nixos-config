{ lib, ... }:

{
  services.udev.extraRules = lib.mkIf false ''
    ACTION=="change", SUBSYSTEM=="drm", TAG+="systemd", ENV{SYSTEMD_USER_WANTS}="hypr-display-switcher.service"
  '';
}
