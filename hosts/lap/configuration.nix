{ host, ... }:

{
  networking.hostName = host;

  imports = [
    ./hardware-configuration.nix
    ../../modules
    ../../modules/hyprDisplaySwitcherLaptop.nix
  ];

  system.stateVersion = "25.05";
}
