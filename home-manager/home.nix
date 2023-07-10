{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./btop
    ./dunst
    ./git.nix
    ./gtk.nix
    ./hyprland
    ./nvim
    ./shell.nix
    ./sway
    ./waybar
    ./webcord
    ./wezterm.nix
    ./wofi
  ];
  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "haydengray";
    homeDirectory = "/home/${config.home.username}";
  };

  home.packages = with pkgs; [ 
    bat
    exa
    git-credential-manager
    heroic
    jq
    ripgrep
    steam
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";
  home.stateVersion = "23.05";
}
