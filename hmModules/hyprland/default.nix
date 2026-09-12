{
  config,
  host,
  pkgs,
  lib,
  hyprlandPackage,
  ...
}:

let
  machines = {
    master = {
      mainMonitorName = "DP-4";
      mode = "2560x1440@60";
      scale = "1";
      hasBuiltinDisplay = false;
    };

    amir = {
      mainMonitorName = "eDP-1";
      mode = "2560x1600@180";
      scale = "1.25";
      hasBuiltinDisplay = true;
    };

    lap = {
      mainMonitorName = "eDP-1";
      mode = "1920x1080@60";
      scale = "1";
      hasBuiltinDisplay = true;
    };
  };

  machine =
    machines.${host} or {
      mainMonitorName = "eDP-1";
      mode = "highres@highrr";
      scale = "1";
      hasBuiltinDisplay = true;
    };

  mainMonitorName = machine.mainMonitorName;
  mainMonitorConfig = "${machine.mainMonitorName}, ${machine.mode}, 0x0, ${machine.scale}";
  fallbackMonitorConfig = ", highresxhighrr, auto, 1";

  hyprDisplaySwitcher = pkgs.writeShellApplication {
    name = "hypr-display-switcher";
    runtimeInputs = [
      hyprlandPackage
      pkgs.jq
      pkgs.coreutils
    ];
    text = ''
      # Some commands for reference
      # journalctl --user -u hypr-display-switcher.service -f
      # systemctl --user start|status|is-enabled hypr-display-switcher.service
      # systemctl --user show-environment
      LOG_FILE="/home/lono/tmplogservice"

      log() {
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
      }
      BUILTIN_MONITOR_NAME="${mainMonitorName}"
      BUILTIN_MONITOR_CONFIG="${mainMonitorConfig}"

      # udev will trigger this service at startup, but at this point hyprctl
      # will fail, so we just skip it. exec-once is used for the case where
      # an external monitor is plugged-in at boot.
      monitors_json=$(hyprctl monitors all -j 2>/dev/null) || exit 0

      external_count=$(echo "$monitors_json" | jq --arg name "$BUILTIN_MONITOR_NAME" \
        '[.[] | select(.name != $name)] | length')

      builtin_disabled=$(echo "$monitors_json" | jq -r --arg name "$BUILTIN_MONITOR_NAME" \
        'first(.[] | select(.name == $name) | .disabled | tostring) // "true"')

      if [[ "$external_count" -gt 0 ]]; then
        if [[ "$builtin_disabled" == "false" ]]; then
          echo "disabling built-in"
          log "disabling built-in"
          hyprctl keyword monitor "$BUILTIN_MONITOR_NAME, disable"
        else
          echo "built-in already disabled, skipping"
          log "built-in already disabled, skipping"
        fi
      else
        if [[ "$builtin_disabled" == "true" ]]; then
          echo "enabling built-in"
          log "enabling built-in"
          hyprctl keyword monitor "$BUILTIN_MONITOR_CONFIG"
        else
          echo "built-in already enabled, skipping"
          log "built-in already enabled, skipping"
        fi
      fi
    '';
  };

  hyprDisplaySwitcherExe = lib.getExe hyprDisplaySwitcher;

  monitorConfText = ''
    monitor = ${mainMonitorConfig}
    monitor = ${fallbackMonitorConfig}
  ''
  + lib.optionalString machine.hasBuiltinDisplay ''
    exec-once = ${hyprDisplaySwitcherExe}
    bind = $mainMod SHIFT, P, exec, ${hyprDisplaySwitcherExe}
    bind = $mainMod ALT, P, exec, hyprctl keyword monitor ${mainMonitorConfig}
  '';
in
{
  systemd.user.services.hypr-display-switcher = lib.mkIf machine.hasBuiltinDisplay {
    Unit.Description = "Enables/disables builtin display on hotplug";

    Service = {
      Type = "oneshot";
      ExecStart = hyprDisplaySwitcherExe;
    };
  };

  home.file.".config/hypr_per_host/conf/monitor.conf".text = monitorConfText;

  home.file.".config/hypr/" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/hmModules/hyprland/hypr/";
    recursive = true;
  };
}
