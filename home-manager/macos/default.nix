{ config, pkgs, ... }: {
  imports = [
    ../shell.nix
    ../nvim
  ];

  home.packages = with pkgs; [
    awscli2
    ripgrep
    eza
    bat
    mise
    jq
    fd
    nodejs
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
