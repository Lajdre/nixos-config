{ ... }:

{
  services.udev.extraRules = ''
    ACTION=="change", SUBSYSTEM=="drm", TAG+="systemd", ENV{SYSTEMD_USER_WANTS}="hypr-display-switcher.service"
  '';

  # systemd.user.services.hypr-display-switcher = {
  #   description = "Enables/disables builtin display on hotplug";
  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStart = "~/.config/scripts/hypr-display-switcher.sh";
  #     # ExecStart = "hypr-display-switcher.sh";
  #     # ExecStart =
  #     #   let
  #     #     script = pkgs.writeShellScript "hypr-display-switcher" ''
  #     #       FALLBACK_BUILDIN_DISPLAY_NAME="eDP-1"
  #     #
  #     #       BUILDIN_DISPLAY_NAME="''${HYPR_BUILDIN_DISPLAY_NAME:-$FALLBACK_BUILDIN_DISPLAY_NAME}"
  #     #       BUILDIN_MONITOR_CONFIG="''${HYPR_BUILDIN_MONITOR_CONFIG:-$BUILDIN_DISPLAY_NAME, highresxhighrr, 0x0, 1}"
  #     #       echo $BUILDIN_DISPLAY_NAME
  #     #       echo $BUILDIN_MONITOR_CONFIG
  #     #
  #     #       echo "DISPLAY=<''${BUILDIN_DISPLAY_NAME}>"
  #     #       echo "CONFIG=<''${BUILDIN_MONITOR_CONFIG}>"
  #     #       echo "DISPLAY=<''$BUILDIN_DISPLAY_NAME>"
  #     #       echo "CONFIG=<''$BUILDIN_MONITOR_CONFIG>"
  #     #
  #     #       BUILDIN_DISPLAY_NAME="''${BUILDIN_DISPLAY_NAME#\"}"
  #     #       echo $BUILDIN_DISPLAY_NAME
  #     #       BUILDIN_DISPLAY_NAME="''${BUILDIN_DISPLAY_NAME%\"}"
  #     #       echo $BUILDIN_DISPLAY_NAME
  #     #       BUILDIN_MONITOR_CONFIG="''${BUILDIN_MONITOR_CONFIG#\"}"
  #     #       echo $BUILDIN_MONITOR_CONFIG
  #     #       BUILDIN_MONITOR_CONFIG="''${BUILDIN_MONITOR_CONFIG%\"}"
  #     #       echo $BUILDIN_MONITOR_CONFIG
  #     #
  #     #       # echo $BUILDIN_DISPLAY_NAME
  #     #       # echo $BUILDIN_DISPLAY_NAME
  #     #       # echo $BUILDIN_MONITOR_CONFIG
  #     #       # echo $BUILDIN_MONITOR_CONFIG
  #     #
  #     #       num_of_monitors=$(
  #     #         ${pkgs.hyprland}/bin/hyprctl monitors all -j | ${pkgs.jq}/bin/jq length
  #     #       )
  #     #
  #     #       if [[ $num_of_monitors -gt 1 ]]; then
  #     #         ${pkgs.hyprland}/bin/hyprctl keyword monitor "$BUILDIN_DISPLAY_NAME, disable"
  #     #       else
  #     #         ${pkgs.hyprland}/bin/hyprctl keyword monitor "$BUILDIN_MONITOR_CONFIG"
  #     #       fi
  #     #     '';
  #     #   in
  #     #   "${script}";
  #   };
  # };
}

# { pkgs, ... }:
#
# {
#   services.udev.extraRules = ''
#     ACTION=="change", SUBSYSTEM=="drm", TAG+="systemd", ENV{SYSTEMD_USER_WANTS}="hypr-display-switcher.service"
#   '';
#
#   systemd.user.services.hypr-display-switcher = {
#     description = "Enables/disables builtin display on hotplug";
#     serviceConfig = {
#       Type = "oneshot";
#       ExecStart =
#         let
#           script = pkgs.writeShellScript "hypr-display-switcher" ''
#
#             FALLBACK_BUILDIN_DISPLAY_NAME="eDP-1"
#
#             BUILDIN_DISPLAY_NAME="${HYPR_BUILDIN_DISPLAY_NAME:-$FALLBACK_BUILDIN_DISPLAY_NAME}"
#             BUILDIN_MONITOR_CONFIG="${HYPR_BUILDIN_MONITOR_CONFIG:-$BUILDIN_DISPLAY_NAME, highresxhighrr, 0x0, 1}"
#
#             num_of_monitors=$(
#               ${pkgs.hyprland}/bin/hyprctl monitors all -j | ${pkgs.jq}/bin/jq length
#             )
#
#             if [[ $num_of_monitors -gt 1 ]]; then
#               ${pkgs.hyprland}/bin/hyprctl keyword monitor "$BUILDIN_DISPLAY_NAME, disable"
#             else
#               ${pkgs.hyprland}/bin/hyprctl keyword monitor "$BUILDIN_MONITOR_CONFIG"
#             fi
#
#           '';
#         in
#         "${script}";
#     };
#   };
#
# }
# ExecStart = "${script}";
# export HYPRLAND_INSTANCE_SIGNATURE=$(ls /tmp/hypr/ | head -1)

# FALLBACK_BUILDIN_DISPLAY_NAME="eDP-1"
# FALLBACK_BUILDIN_MONITOR_CONFIG="$FALLBACK_BUILDIN_DISPLAY_NAME, highresxhighrr, 0x0, 1"
#
# num_of_monitors=$(${pkgs.hyprland}/bin/hyprctl monitors all -j | ${pkgs.jq}/bin/jq length)
#
# if [[ $num_of_monitors -gt 1 ]]; then
#   ${pkgs.hyprland}/bin/hyprctl keyword monitor "$HYPR_BUILDIN_DISPLAY_NAME, disable"
# else
#   if [[ -z "$HYPR_BUILDIN_MONITOR_CONFIG" ]]; then
#     ${pkgs.hyprland}/bin/hyprctl keyword monitor "$HYPR_BUILDIN_MONITOR_CONFIG"
#   else
#     ${pkgs.hyprland}/bin/hyprctl keyword monitor "$FALLBACK_BUILDIN_MONITOR_CONFIG"
#   fi
# fi

# home.file.".config/scripts/hypr-display-switcher.sh" = {
#   text = ''
#     #!/usr/bin/env bash
#     FALLBACK_BUILDIN_DISPLAY_NAME="eDP-1"
#
#     BUILDIN_DISPLAY_NAME="''${HYPR_BUILDIN_DISPLAY_NAME:-$FALLBACK_BUILDIN_DISPLAY_NAME}"
#     BUILDIN_MONITOR_CONFIG="''${HYPR_BUILDIN_MONITOR_CONFIG:-$BUILDIN_DISPLAY_NAME, highresxhighrr, 0x0, 1}"
#     echo $BUILDIN_DISPLAY_NAME
#     echo $BUILDIN_MONITOR_CONFIG
#
#     # echo "DISPLAY=<''${BUILDIN_DISPLAY_NAME}>"
#     # echo "CONFIG=<''${BUILDIN_MONITOR_CONFIG}>"
#     # echo "DISPLAY=<''$BUILDIN_DISPLAY_NAME>"
#     # echo "CONFIG=<''$BUILDIN_MONITOR_CONFIG>"
#     #
#     # BUILDIN_DISPLAY_NAME="''${BUILDIN_DISPLAY_NAME#\"}"
#     # echo $BUILDIN_DISPLAY_NAME
#     # BUILDIN_DISPLAY_NAME="''${BUILDIN_DISPLAY_NAME%\"}"
#     # echo $BUILDIN_DISPLAY_NAME
#     # BUILDIN_MONITOR_CONFIG="''${BUILDIN_MONITOR_CONFIG#\"}"
#     # echo $BUILDIN_MONITOR_CONFIG
#     # BUILDIN_MONITOR_CONFIG="''${BUILDIN_MONITOR_CONFIG%\"}"
#     # echo $BUILDIN_MONITOR_CONFIG
#
#     # echo $BUILDIN_DISPLAY_NAME
#     # echo $BUILDIN_DISPLAY_NAME
#     # echo $BUILDIN_MONITOR_CONFIG
#     # echo $BUILDIN_MONITOR_CONFIG
#
#     num_of_monitors=$(
#       ${pkgs.hyprland}/bin/hyprctl monitors all -j | ${pkgs.jq}/bin/jq length
#     )
#
#     if [[ $num_of_monitors -gt 1 ]]; then
#       ${pkgs.hyprland}/bin/hyprctl keyword monitor "$BUILDIN_DISPLAY_NAME, disable"
#     else
#       ${pkgs.hyprland}/bin/hyprctl keyword monitor "$BUILDIN_MONITOR_CONFIG"
#     fi
#   '';
#   executable = true;
# };

# ''
#   monitor = eDP-1, 2560x1600@180, 0x0, 1.25
#   env = HYPR_BUILDIN_DISPLAY_NAME, eDP-1
#   env = HYPR_BUILDIN_MONITOR_CONFIG, eDP-1, 2560x1600@180, 0x0, 1.25
#   exec-once = ${hyprDisplaySwitcherExe}
# ''
#
