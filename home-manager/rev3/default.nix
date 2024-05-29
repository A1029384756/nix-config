{ pkgs, ... }: {
  imports = [
    ../discord
    ../btop
    ../firefox
    ../games
    ../git.nix
    ../gnome.nix
    ../nvim
    ../shell.nix
    ../wezterm
    ../git.nix
  ];

  home.username = "haydengray";
  home.homeDirectory = "/home/haydengray";

  home.packages = with pkgs; [
    awscli2
    bat
    brave
    eza
    fd
    jq
    mise
    mission-center
    nodejs
    ripgrep
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
