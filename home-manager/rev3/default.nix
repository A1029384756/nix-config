{ pkgs, ... }: {
  imports = [
    ../discord
    ../btop.nix
    ../firefox
    ../games
    ../git.nix
    ../gnome.nix
    ../nvim
    ../shell.nix
    ../git.nix
    ../kitty.nix
  ];

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
