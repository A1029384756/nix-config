{ ... }: {
  imports = [
    ../shell.nix
    ../nvim
    ../kitty.nix
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
