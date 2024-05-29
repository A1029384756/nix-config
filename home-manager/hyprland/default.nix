{ ... }: {
  xdg.configFile.hyprland = {
    source = ./conf;
    recursive = true;
    target = "hypr";
  };
}
