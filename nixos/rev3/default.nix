{ pkgs, ... }: {
  imports =
    [ 
    ../base.nix
    ../fonts.nix
    ../gnome.nix
    ../host.nix
    ../nvidia.nix
    ../services.nix
    ../vm.nix
    /etc/nixos/hardware-configuration.nix
    ];
  
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    plymouth.enable = true;
    kernelParams = [ "nvidia_drm.fbdev=1" ];
    kernelPackages = pkgs.linuxPackages_latest;
  };

  programs.fish.enable = true;

  system.stateVersion = "23.11";
}
