{ ... }: {
  imports = [
    ../firefox
    ../git.nix
    ../nvim
    ../shell.nix
  ];

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";
  home.stateVersion = "23.05";
}
