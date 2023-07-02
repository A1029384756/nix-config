{ config, inputs, pkgs, ... }:
{
  imports =
    [ 
    ./host.nix
    ./nvidia.nix
    ./services.nix
    ./hyprland.nix
    ./hardware-configuration.nix
    ];

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 8d";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  programs.fish.enable = true;
  programs.firefox.enable = true;
  programs.seahorse.enable = true;

  environment.systemPackages = with pkgs; [
    gcc
    git
    glibc
    sqlite
    wget
    rustup
    pfetch-rs
  ];

  system.stateVersion = "23.05";
}
