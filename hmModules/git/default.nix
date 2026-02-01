{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Lajdre";
        email = "AndreAndreM@proton.me";
      };
      init = {
        defaultBranch = "master";
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
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
}
