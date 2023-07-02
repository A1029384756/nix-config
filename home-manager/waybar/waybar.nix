{ config, pkgs, ... }: {
  xdg.configFile.waybar = {
    source = ./conf;
    recursive = true;
    target = "waybar";
  };
}
