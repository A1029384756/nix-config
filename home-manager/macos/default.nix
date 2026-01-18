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
    isWork = true;
    fonts.fontconfig.enable = true;
    programs.home-manager.enable = true;
    home.stateVersion = "23.11";
  };
}
