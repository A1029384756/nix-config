{ pkgs, ... }: {
  imports = [
    ../discord
    ../firefox
    ../games
    ../git.nix
    ../gnome.nix
    ../kitty.nix
    ../nvim
    ../shell.nix
    ../unix_alternatives.nix
  ];

  home.packages = with pkgs; [
    brave
    mission-center
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
