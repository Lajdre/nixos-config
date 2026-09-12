{ ... }:

{
  imports = [
    ./system.nix
    ./ly.nix
    ./shell.nix
    ./hyprland.nix
    ./networking.nix
    ./audio.nix
    ./hardware.nix
    ./systemPackages.nix
    ./virtualisation.nix
    ./fonts.nix
    ./keyring.nix
    ./overlays.nix
    ./ld.nix
  ];
}
