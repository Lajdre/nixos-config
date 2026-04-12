{ ... }:

{
  home.file.".config/scripts/screenshots.sh" = {
    source = ./screenshots.sh;
    executable = true;
  };

  home.file.".config/scripts/pickWall.sh" = {
    source = ./pickWall.sh;
    executable = true;
  };

  home.file.".config/scripts/setup_dev.sh" = {
    source = ./setup_dev.sh;
    executable = true;
  };

  home.file.".config/scripts/jump.fish" = {
    source = ./jump.fish;
    executable = true;
  };

  home.file.".config/scripts/clone.fish" = {
    source = ./clone.fish;
    executable = true;
  };

  home.file.".config/scripts/initSystemStructure.sh" = {
    source = ./initSystemStructure.sh;
    executable = true;
  };

  home.file.".config/scripts/wall.sh" = {
    text = ''
      #!/usr/bin/env bash

      WK_FILE="$HOME/.config/.wk"

      if [ ! -f "$WK_FILE" ] ; then
        image_dir="$HOME/cave/walls"

        if [ ! -d "$image_dir" ]; then
          notify-send "directory $image_dir does not exist. exiting."
          exit 1
        fi

        random_image=$(find "$image_dir" -type f | shuf -n 1)

        if [ -z "$random_image" ]; then
          notify-send "no files found in $image_dir. exiting."
          exit 1
        fi

        sleep 2.5

        awww img "$random_image" --transition-step 1
      fi
    '';
    executable = true;
  };
}
