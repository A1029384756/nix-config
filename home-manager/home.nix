{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./btop/btop.nix
    ./git.nix
    ./hyprland/hyprland.nix
    ./nvim/nvim.nix
    ./shell.nix
    ./sway/sway.nix
    ./waybar/waybar.nix
    ./wezterm.nix
    ./wofi/wofi.nix
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
