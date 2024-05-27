{ config, inputs, pkgs, ... }: {
  imports =
    [ 
    ../base.nix
    ../gnome.nix
    ../host.nix
    ../nvidia.nix
    ../services.nix
    ./hardware-configuration.nix
    ];
  
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    plymouth.enable = true;
    kernelParams = [ "nvidia_drm.fbdev=1" ];
  };

  programs.fish.enable = true;

  system.stateVersion = "23.11";
}
