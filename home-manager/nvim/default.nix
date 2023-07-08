{ config, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  xdg.configFile.nvim = {
    source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/Customization/nix-config/home-manager/nvim/config";
    recursive = true;
  };

  home.packages = with pkgs; [
    clang
    clang-tools
    lua-language-server
    nodePackages_latest.pyright
    nodejs_20
    python312
  ];
}
