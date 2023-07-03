{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./git.nix
    ./shell.nix
    ./wezterm.nix
    ./nvim/nvim.nix
    ./waybar/waybar.nix
    ./wofi/wofi.nix
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
    yuzu
    gnome.nautilus
  ];

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";
  home.stateVersion = "23.05";
}
