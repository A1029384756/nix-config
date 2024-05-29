{ inputs, pkgs, ... }: {
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
