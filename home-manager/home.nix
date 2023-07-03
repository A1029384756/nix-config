{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./git.nix
    ./shell.nix
    ./wezterm.nix
    ./nvim/nvim.nix
    ./sway/sway.nix
    ./wofi/wofi.nix
    ./waybar/waybar.nix
    ./hyprland/hyprland.nix
  ];

  home = {
    username = "haydengray";
    homeDirectory = "/home/haydengray";
  };

  home.packages = with pkgs; [ 
    git-credential-manager
    jq
    exa
    bat
    ripgrep
    unzip
    gcc
    rustup
  ];

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";
  home.stateVersion = "23.05";
}
