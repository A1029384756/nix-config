{ config, pkgs, ... }:
{
  stylix = {
    enable = true;
    image = ../assets/bg.png;
    base16Scheme = ../assets/catppuccin-mocha-base16.yaml;

    polarity = "dark";

    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font";
      };

      sansSerif = {
        package = pkgs.nerdfonts.override { fonts = [ "Ubuntu" ]; };
        name = "Ubuntu Nerd Font";
      };

      serif = config.stylix.fonts.sansSerif;
      emoji = config.stylix.fonts.sansSerif;
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Original-Classic";
      size = 16;
    };
  };
}
