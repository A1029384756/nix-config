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
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/home-manager/nvim/config";
    recursive = true;
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };

  home.packages = with pkgs; [
    lua-language-server
  ];
}
