{ config, lib, ... }:

{
  options.myGit = {
    name = lib.mkOption {
      type = lib.types.str;
      default = "Lajdre";
    };
    email = lib.mkOption {
      type = lib.types.str;
      default = "AndreAndreM@proton.me";
    };
    defaultBranch = lib.mkOption {
      type = lib.types.str;
      default = "master";
    };
  };

  config = {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = config.myGit.name;
          email = config.myGit.email;
        };
        init = {
          defaultBranch = config.myGit.defaultBranch;
        };
        pull = {
          rebase = true;
        };
        push = {
          autoSetupRemote = true;
        };
      };
      lfs = {
        enable = true;
      };
      signing.format = "openpgp";
    };

    programs.delta = {
      enable = true;
      enableGitIntegration = true;
    };
  };
}
