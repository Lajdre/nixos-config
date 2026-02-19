{
  description = "Home Manager configuration of lono";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      # system = "x86_64-linux";
      # pkgs = nixpkgs.legacyPackages.${system};
      pkgs = nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      homeConfigurations."lono" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./standaloneHome.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
