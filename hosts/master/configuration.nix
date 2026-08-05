{ ... }:

{
  networking.hostName = "master";

  imports = [
    ./hardware-configuration.nix
    ../../modules
    ../../modules/nvidia.nix
    ../../modules/printer.nix
  ];

  system.stateVersion = "24.05";
}
