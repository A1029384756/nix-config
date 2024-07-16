{ ... }:
{
  imports = [
    ../shell.nix
    ../nvim.nix
    ../kitty.nix
  ];

  home.file.".config/aerospace/aerospace.toml".source = ./aerospace.toml;

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
