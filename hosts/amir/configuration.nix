{ host, ... }:

{
  networking.hostName = host;

  imports = [
    ./hardware-configuration.nix
    ../../modules
    ../../modules/nvidiaRTX5070TiLaptop.nix
  ];

  system.stateVersion = "25.11";
}
