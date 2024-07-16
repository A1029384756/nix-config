{ ... }:
{
  imports = [
    ../shell.nix
    ../nvim.nix
    ../kitty.nix
    ../wezterm.nix
  ];

  home.file.".config/aerospace/aerospace.toml".source = ./aerospace.toml;

  fonts.fontconfig.enable = true;
  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
