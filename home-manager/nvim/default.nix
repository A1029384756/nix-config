{ config, pkgs, ... }: {
  home.file.".config/nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/dotfiles/config/nvim";
    recursive = true;
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };

  home.packages = with pkgs; [
    cargo
    clang-tools
    gcc
    lua-language-server
    nodePackages.typescript-language-server
    pyright
    rust-analyzer
    tflint
  ];
}
