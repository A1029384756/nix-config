{ ... }:
{
  imports = [
    ../base.nix
    ../host.nix
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

  system.stateVersion = "23.05";
}
