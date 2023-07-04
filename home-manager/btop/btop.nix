{ config, pkgs, ... }: {
  xdg.configFile.btop = {
    source = ./conf;
    recursive = true;
    target = "btop";
  };
}
