{ pkgs, ... }:
{
  imports = [
    ../discord
    ../firefox
    ../games
    ../git.nix
    ../gnome.nix
    ../hyprland
    ../kitty.nix
    ../nvim
    ../shell.nix
    ../theme.nix
  ];

  home.packages = with pkgs; [
    bottles
    brave
    mission-center
    spotify
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
