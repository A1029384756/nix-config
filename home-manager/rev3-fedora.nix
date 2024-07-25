{ config, pkgs, ... }:
{
  imports = [
    ./git.nix
    ./wezterm.nix
    ./nvim.nix
  ];
  nixGL.prefix = "${pkgs.nixgl.auto.nixGLDefault}/bin/nixGL";

  home = {
    username = "haydengray";
    homeDirectory = "/home/haydengray";
    stateVersion = "24.05";
  };

  home.packages = with pkgs; [
    lua-language-server
    nil
    rustc
    rustup
    fd
    jq
    eza
    ripgrep
    nixgl.auto.nixGLDefault
  ];

  fonts.fontconfig.enable = true;

  programs = {
    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };
    fzf = {
      enable = true;
      enableFishIntegration = true;
    };
    starship.enable = true;
    bat.enable = true;
    awscli.enable = true;
    home-manager.enable = true;
  };

  home.file.".config/fish" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/dotfiles/config/fish";
    recursive = true;
  };
}
