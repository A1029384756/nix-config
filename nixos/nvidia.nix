{ config, pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.beta; 
    modesetting.enable = true;
    open = false;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
}
