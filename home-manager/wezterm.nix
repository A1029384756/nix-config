{ config, pkgs, ... }:
{
  home.file.".config/wezterm" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/dotfiles/config/wezterm";
    recursive = true;
  };

  home.packages = with pkgs; [ wezterm ];
}
