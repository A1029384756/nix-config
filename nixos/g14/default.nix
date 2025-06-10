{ pkgs, ... }:
{
  imports = [
    ../base.nix
    ../host.nix
    ../nvidia.nix
    ../services.nix
    ../gnome.nix
    /etc/nixos/hardware-configuration.nix
  ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    plymouth.enable = true;
  };

  programs.fish.enable = true;

  services = {
    supergfxd.enable = true;
    asusd = {
      enable = true;
      enableUserService = true;
    };
  };
  systemd.services.supergfxd.path = [ pkgs.pciutils ];

  system.stateVersion = "23.11";
}
