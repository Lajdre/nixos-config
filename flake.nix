{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";
      hosts = [
        "master"
        "lap"
        "amir"
      ];
    in
    {
      nixosConfigurations = builtins.listToAttrs (
        map (host: {
          name = host;
          value = nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = { inherit inputs host; };

            modules = [
              ./hosts/${host}/configuration.nix
              home-manager.nixosModules.home-manager
              (
                { config, ... }:
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.lono = import ./hosts/${host}/home.nix;
                  home-manager.backupFileExtension = "backup";
                  home-manager.extraSpecialArgs = {
                    inherit host;
                    hyprlandPackage = config.programs.hyprland.package;
                  };
                }
              )
            ];
          };
        }) hosts
      );
    };
}
