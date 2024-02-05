{ config, pkgs, ... }: {
  imports = [
    ../shell.nix
    ../nvim
    ../yabai
  ];

  home.packages = with pkgs; [
    awscli2
    ripgrep
    eza
    bat
    mise
    jq
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
