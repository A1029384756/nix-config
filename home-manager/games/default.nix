{ inputs, pkgs, ... }: {
  home.file.".config/heroic-themes" = {
    source = inputs.heroic-theme;
    recursive = true;
  };

  home.packages = with pkgs; [
    gamescope
    heroic
    osu-lazer
    prismlauncher
    protontricks
    runelite
  ];
}
