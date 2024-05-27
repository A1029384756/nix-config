{ config, inputs, pkgs, ... }: {
  imports =
    [ 
    ../base.nix
    ../host.nix
    ../nvidia.nix
    ../services.nix
    ../wm.nix
    ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = true;

  programs.fish.enable = true;

  services.supergfxd.enable = true;
  systemd.services.supergfxd.path = [ pkgs.pciutils ];
  services.asusd = {
    enable = true;
    enableUserService = true;
  };

  system.stateVersion = "23.11";
}
