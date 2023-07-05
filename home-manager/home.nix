{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./btop
    ./dunst
    ./git.nix
    ./hyprland
    ./nvim
    ./shell.nix
    ./sway
    ./waybar
    ./wezterm.nix
    ./wofi
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

  gtk = {
    enable = true;
    theme = {
        name = "Catppuccin-Mocha-Standard-Mocha-Dark";
        package = pkgs.catppuccin-gtk;
      };
  };

  systemd.user.startServices = "sd-switch";
  home.stateVersion = "23.05";
}
