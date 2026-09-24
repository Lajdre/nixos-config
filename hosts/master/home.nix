{ ... }:

{
  home.username = "lono";
  home.homeDirectory = "/home/lono";

  imports = [
    ../../hmModules
  ];

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
