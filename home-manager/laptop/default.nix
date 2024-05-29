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
