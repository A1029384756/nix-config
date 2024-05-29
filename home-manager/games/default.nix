{ inputs, pkgs, ... }: {
  xdg.desktopEntries.steam = {
    name = "Steam";
    genericName = "Games";
    icon = ./steam.svg;
    exec = "steam";
    terminal = false;
    type = "Application";
  };

  home.file.".config/heroic-themes" = {
    source = inputs.heroic-theme;
    recursive = true;
  };

  home.packages = with pkgs; [
    heroic
    prismlauncher
    protontricks
  ];
}
