{ pkgs, ... }: {
  imports = [
    ../discord
    ../firefox
    ../games
    ../git.nix
    ../gnome.nix
    ../nvim
    ../shell.nix
    ../wezterm
  ];

  home.packages = with pkgs; [ 
    mate.engrampa
  ];

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";
  home.stateVersion = "23.05";
}
