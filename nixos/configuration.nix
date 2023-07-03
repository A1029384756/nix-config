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

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  programs.fish.enable = true;

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
