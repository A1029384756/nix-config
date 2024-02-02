{ config, ... }: {
  xdg.desktopEntries.nvim =
    {
      name = "Neovim";
      genericName = "Text Editor";
      icon = ./nvim.svg;
      exec = "wezterm start nvim %f";
      terminal = false;
      type = "Application";
      categories = [ "Utility" "TextEditor" ];
    };
}
