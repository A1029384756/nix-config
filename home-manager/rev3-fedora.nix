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
    activation = {
      linkDesktopApplications = {
        after = [ "writeBoundary" "createXdgUserDirectories" ];
        before = [ ];
        data = ''
          rm -rf ${config.xdg.dataHome}/"applications/home-manager"
          mkdir -p ${config.xdg.dataHome}/"applications/home-manager"
          cp -Lr ${config.home.homeDirectory}/.nix-profile/share/applications/* ${config.xdg.dataHome}/"applications/home-manager/"
        '';
      };
    };
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
    maple-mono-NF
  ];

  fonts.fontconfig.enable = true;

  programs = {
    alacritty = {
      enable = true;
      catppuccin.enable = true;
      package = (config.lib.nixGL.wrap pkgs.alacritty);
      settings = {
        font = {
          normal = { family = "Maple Mono NF CN"; style = "regular"; };
        };
      };
    };
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
}
