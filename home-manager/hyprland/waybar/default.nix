{ pkgs, ... }: {
  programs.waybar = {
    enable = true;
  };

  home.packages = with pkgs; [
    cliphist
    hyprpicker
    killall
    pavucontrol
    wl-clipboard
    wofi
  ];

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.gnome.adwaita-icon-theme;
    name = "Adwaita";
    size = 10;
  };

  home.file.".config/waybar" = {
    source = ./config;
    recursive = true;
  };
}
