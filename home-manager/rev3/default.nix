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
    spotify
  ];

  xdg.desktopEntries."com.spotify.Client" = {
    name = "Spotify";
    comment = "Spotify Client";
    icon = "com.spotify.Client";
    exec = "spotify";
    categories = ["Audio"];
    terminal = false;
  };

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
