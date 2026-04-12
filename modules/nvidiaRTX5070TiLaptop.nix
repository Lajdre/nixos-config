{ pkgs, config, ... }:

{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = [ pkgs.nvtopPackages.nvidia ];
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics = {
    enable = true;
  };
  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    prime = {
      sync.enable = true;
      amdgpuBusId = "PCI:64:0:0";
      nvidiaBusId = "PCI:63:0:0";
    };
  };
}
