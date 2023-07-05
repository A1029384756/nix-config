{ config, pkgs, ... }: {
  xdg.configFile.dunst = {
    source = ./conf;
    recursive = true;
    target = "dunst";
  };
}
