{ config, pkgs, ... }: {
  xdg.configFile.wezterm = {
    source = ./conf;
    recursive = true;
  };

  programs.wezterm = {
    enable = true;
  };
}
