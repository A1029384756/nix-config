{ pkgs, ... }: {
  xdg.desktopEntries.steam = {
    name = "Steam";
    genericName = "Games";
    icon = ./steam.svg;
    exec = "steam";
    terminal = false;
    type = "Application";
  };

  home.packages = with pkgs; [ heroic prismlauncher protontricks ];
}
