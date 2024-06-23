{ pkgs, ... }: {
  imports =
    [ 
    ../base.nix
    ../containers.nix
    ../fonts.nix
    ../host.nix
    ../hyprland.nix
    ../nautilus.nix
    ../nvidia.nix
    ../services.nix
    ../vm.nix
    /etc/nixos/hardware-configuration.nix
    ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    plymouth.enable = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };
  programs.fish.enable = true;

  system.stateVersion = "23.11";
}
