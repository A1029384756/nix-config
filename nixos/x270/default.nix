{ ... }:
{
  imports = [
    ../base.nix
    ../host.nix
    ../services.nix
    ../gnome.nix
    /etc/nixos/hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = true;

  programs.fish.enable = true;

  system.stateVersion = "23.05";
}
