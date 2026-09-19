{ ... }:

{
  programs.wlogout = {
    enable = true;
    layout = [
      {
        "label" = "lock";
        "action" = "swaylock";
        "text" = "Lock";
        "keybind" = "l";
      }
      {
        "label" = "hibernate";
        "action" = "";
        "text" = "";
        "keybind" = "h";
        # "action" = "systemctl hibernate";
        # "text" = "Hibernate";
      }
      {
        "label" = "logout";
        "action" = "hyprshutdown";
        "text" = "Logout";
        "keybind" = "o";
      }
      {
        "label" = "shutdown";
        "action" = "hyprshutdown --post-cmd poweroff";
        "text" = "Shutdown";
        "keybind" = "s";
      }
      {
        "label" = "reboot";
        "action" = "hyprshutdown --post-cmd reboot";
        "text" = "Reboot";
        "keybind" = "r";
      }
      {
        "label" = "suspend";
        "action" = "";
        "text" = "";
        "keybind" = "u";
        # "action" : "swaylock -f && systemctl suspend",
        # "action" = "systemctl suspend";
        # "text" = "Suspend";
      }
    ];
  };

  home.file.".config/wlogout/assets/" = {
    source = ./assets;
    recursive = true;
  };

  home.file.".config/wlogout/style.css" = {
    text = ''
      * {
        background-image: none;
        box-shadow: none;
      }

      window {
        background-color: rgba(12, 12, 12, 0.9);
      }

      button {
        border-radius: 0;
        border-color: black;
        text-decoration-color: #FFFFFF;
        color: #FFFFFF;
        /* background-color: #1E1E1E; */
        background-color: #3700B3;
        border-style: solid;
        border-width: 1px;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
      }

      /* button:focus*/
      button:hover, button:active {
         /* background-color: #3700B3; */
         background-color: #154c79;
         outline-style: none;
      }

      #lock {
        background-image: image(url("assets/scorpicore.png"));
      }

      #logout {
        background-image: image(url("assets/naga_queen.png"));
        background-size: 35%;
      }

      #suspend {
        background-image: image(url("assets/a1.png"));
      }

      #hibernate {
        background-image: image(url("assets/a1_mirror.png"));
      }

      #shutdown {
        background-image: image(url("assets/royal_griffin.png"));
        background-size: 45%;
      }

      #reboot {
        background-image: image(url("assets/greater_basilisk.png"));
      }
    '';
  };
}
