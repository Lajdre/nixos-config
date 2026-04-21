{ ... }:

{
  home.username = "lono";
  home.homeDirectory = "/home/lono";

  imports = [
    ../../hmModules
  ];

  myGit = {
    name = "amironczuk-trilagi";
    email = "andre.mironczuk@trilagi.com";
    defaultBranch = "main";
  };

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
