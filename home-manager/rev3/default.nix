{ pkgs, ... }: {
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
  ];

  home.packages = with pkgs; [
    brave
    mission-center
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
