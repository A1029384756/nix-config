{ config, pkgs, ... }: 
let
  themePath = "${pkgs.catppuccin-gtk-mocha}/share/themes/Catppuccin-Mocha-Standard-Mauve-dark";
in {
  gtk = {
    enable = true;
    font = {
      name = "Ubuntu";
      package = pkgs.ubuntu_font_family;
      size = 11;
    };
    cursorTheme = {
      name = "Catppuccin-Mocha-Dark-Cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
      size = 8;
    };
    theme = {
      name = "Catppuccin-Mocha-Standard-Mauve-dark";
      package = pkgs.catppuccin-gtk-mocha;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  xdg.configFile."gtk-4.0/gtk.css".text = (builtins.readFile "${themePath}/gtk-4.0/gtk-dark.css");
}
