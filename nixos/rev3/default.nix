{ pkgs, ... }:
{
  imports = [
    ../base.nix
    ../containers.nix
    ../host.nix
    ../hyprland.nix
    ../gnome.nix
    ../nautilus.nix
    ../nvidia.nix
    ../services.nix
    ../stylix.nix
    ../vm.nix
    /etc/nixos/hardware-configuration.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 10;
    };
    plymouth.enable = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };
  programs.fish.enable = true;

  system.stateVersion = "23.11";
}
