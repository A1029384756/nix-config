{ config, pkgs, ... }: {
  imports = [
    ../shell.nix
  ];

  home.packages = with pkgs; [
    awscli2
    ripgrep
    eza
    bat
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
