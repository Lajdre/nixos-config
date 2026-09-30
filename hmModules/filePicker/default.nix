{ pkgs, ... }:

{
  home.file.".config/xdg-desktop-portal-termfilechooser/config" = {
    text = ''
      [filechooser]
      cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
      default_dir=$HOME/downloads
      env=TERMCMD=${pkgs.kitty}/bin/kitty -T FilePicker
      open_mode = suggested
      save_mode = last
    '';
  };
}
