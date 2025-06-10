{ pkgs, ... }:
{
  stylix.targets = {
    gtk.enable = true;
    firefox.enable = true;
    vim.enable = false;
    kitty.enable = false;
    waybar.enable = false;
  };

  gtk.iconTheme = {
    name = "Papirus";
    package = pkgs.catppuccin-papirus-folders.override { accent = "mauve"; };
  };
}
