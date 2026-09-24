{ pkgs, ... }:

{
  home.file.".config/xdg-desktop-portal-termfilechooser/config" = {
    text = ''
      [filechooser]
      cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh

      default_dir=$HOME

      # env=TERMCMD=${pkgs.foot}/bin/foot -T FilePicker
      env=TERMCMD=${pkgs.kitty}/bin/kitty -T FilePicker
      # Example for alacritty:
      # env=TERMCMD={pkgs.alacritty}/bin/alacritty -t "File Picker" -e
    '';
  };

  home.file.".config/xdg-desktop-portal/portals.conf" = {
    text = ''
      [preferred]
      org.freedesktop.impl.portal.FileChooser=termfilechooser
      # Set the default implementation for the FileChooser portal interface
    '';
  };

  home.file.".config/kitty/kitty.conf" = {
    text = ''
      font_family      Agave Nerd Font
      font_size        17.5
    '';
  };
}
