{ config, pkgs, ... }: {
  programs.waybar.enable = true;

  xdg.configFile.wofi = {
    source = ./conf;
    recursive = true;
    target = "wofi";
  };
}
