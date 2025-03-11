{ ... }:
{
  imports = [
    ../shell.nix
    ../nvim.nix
    ../kitty.nix
    ../wezterm.nix
    ../git.nix
  ];

  config = {
    home.file.".config/ghostty/config".source = ./ghosty_config;
    isWork = true;

    fonts.fontconfig.enable = true;
    programs.home-manager.enable = true;
    home.stateVersion = "23.11";
  };
}
