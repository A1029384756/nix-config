{ config, pkgs, ... }: {
  home.file.".config/yabai" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/dotfiles/config/yabai";
    recursive = true;
  };

  home.file.".config/skhd" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/dotfiles/config/skhd";
    recursive = true;
  };
}
