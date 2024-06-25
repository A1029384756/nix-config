{ pkgs, ... }: {
  imports = [
    ../discord
    ../firefox
    ../games
    ../git.nix
    ../hyprland
    ../kitty.nix
    ../nvim
    ../shell.nix
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
