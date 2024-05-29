{ pkgs, ... }: {
  imports = [
    ../discord
    ../btop
    ../dunst
    ../firefox
    ../games
    ../git.nix
    ../gnome.nix
    ../hyprland
    ../nvim
    ../shell.nix
    ../sway
    ../waybar
    ../wezterm
    ../wofi
  ];

  home.packages = with pkgs; [ 
    bat
    mate.engrampa
    exa
    git-credential-manager
    jq
    ripgrep
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";
  home.stateVersion = "23.05";
}
