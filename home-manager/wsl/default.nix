{ user, pkgs, ... }: {
  imports = [
    ../btop
    ../firefox
    ../git.nix
    ../nvim
    ../shell.nix
  ];

  home.username = user;
  home.homeDirectory = "/home/${user}";

  home.packages = with pkgs; [ 
    bat
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
