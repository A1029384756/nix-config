{ config, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  xdg.configFile.nvim = {
    source = ./config;
    recursive = true;
    target = "nvim";
  };

  home.packages = with pkgs; [
    nodejs_20
  ];
}
