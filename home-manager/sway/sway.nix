
{ config, pkgs, ... }: {
  xdg.configFile.sway = {
    source = ./conf;
    recursive = true;
    target = "sway";
  };
}
