{ config, pkgs, ... }: {
  imports = [
    ../discord
    ../btop
    ../firefox
    ../games
    ../git.nix
    ../gtk.nix
    ../nvim
    ../shell.nix
    ../wezterm
    ../git.nix
  ];

  home.username = "haydengray";
  home.homeDirectory = "/home/haydengray";

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
