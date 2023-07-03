{ config, pkgs, ... }: {
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable; 
    modesetting.enable = true;
    open = false;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}
