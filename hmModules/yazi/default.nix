{ pkgs, ... }:
let
  yazi-plugins = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "b12a9ab085a8c2fe2b921e1547ee667b714185f9";
    hash = "sha256-LWN0riaUazQl3llTNNUMktG+7GLAHaG/IxNj1gFhDRE=";
  };
in
{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "y";

    settings = {
      mgr = {
        show_hidden = false;
      };
      opener = {
        pdf_opener = [
          {
            run = "zathura %s";
            orphan = true;
          }
          {
            run = "brave %s";
            orphan = true;
          }
          {
            run = "firefox %s";
            orphan = true;
          }
          {
            run = "vivaldi %s";
            orphan = true;
          }
        ];
      };
      open = {
        prepend_rules = [
          {
            url = "*.pdf";
            use = [
              "pdf_opener"
            ];
          }
        ];
      };
    };

    plugins = {
      smart-enter = "${yazi-plugins}/smart-enter.yazi";
    };

    keymap = {
      input.prepend_keymap = [
        {
          on = "<Esc>";
          run = "close";
          desc = "Cancel input";
        }
      ];
      mgr.prepend_keymap = [
        {
          desc = "Open shell here";
          on = "!";
          run = ''shell "$SHELL" --block'';
        }
        {
          on = "<C-n>";
          run = ''shell 'ripdrag "$@" -x 2>/dev/null &' --confirm'';
        }
        # {
        #   desc = "Enter the child directory, or open the file";
        #   on = "l";
        #   run = "plugin smart-enter";
        # }
      ];
    };
  };
}
