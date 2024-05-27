{ inputs, pkgs, ... }: {
  gtk = {
    enable = true;
    catppuccin = {
      enable = true;
      cursor.enable = true;
      icon.enable = true;
      gnomeShellTheme = true;
    };
  };

  home.packages = with pkgs.gnomeExtensions; [
    alphabetical-app-grid
    appindicator
    blur-my-shell
    forge
    just-perfection
    rounded-window-corners
  ];

  dconf.settings = {
    "org/gnome/shell".enabled-extensions = [
      "user-theme@gnome-shell-extensions.gcampax.github.com"
      "AlphabeticalAppGrid@stuarthayhurst"
      "blur-my-shell@aunetx"
      "appindicatorsupport@rgcjonas.gmail.com"
      "just-perfection-desktop@just-perfection"
      "forge@jmmaranan.com"
      "rounded-window-corners@yilozt"
    ];
  };
}
