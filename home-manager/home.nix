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
    font = {
      name = "Ubuntu";
      package = pkgs.ubuntu_font_family;
      size = 11;
    };
    cursorTheme = {
      name = "Catppuccin-Mocha-Dark-Cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
      size = 8;
    };
    theme = {
      name = "Catppuccin-Mocha-Standard-Mauve-dark";
      package = pkgs.callPackage ../pkgs/gtk.nix { };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  systemd.user.startServices = "sd-switch";
  home.stateVersion = "23.05";
                                    }
