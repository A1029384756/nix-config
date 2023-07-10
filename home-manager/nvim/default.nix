{ config, pkgs, ... }: {
  xdg.desktopEntries.nvim = {
    name = "Neovim";
    genericName = "Text Editor";
    icon = ./nvim.svg;
    exec = "wezterm start nvim %f";
    terminal = false;
    type = "Application";
    categories = [ "Utility" "TextEditor" ];
  };

  xdg.configFile.nvim = {
    source = config.lib.file.mkOutOfStoreSymlink ./config;
    recursive = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  home.packages = with pkgs; [
    lua-language-server
  ];
}
