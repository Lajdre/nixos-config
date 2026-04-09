{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    # wezterm.url = "github:wez/wezterm?dir=nix";
  };

  outputs =
    inputs@{
      nixpkgs,
      # nixpkgs-stable,
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
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.lono = import ./hosts/${host}/home.nix;
                home-manager.backupFileExtension = "backup";
                home-manager.extraSpecialArgs = { inherit host; };
              }
            ];
          };
        }) hosts
      );
    };
}
