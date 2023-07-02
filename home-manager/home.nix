{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "haydengray";
    homeDirectory = "/home/haydengray";
  };

  home.packages = with pkgs; [ 
    git-credential-manager
    jq
    exa
    bat
    ripgrep
    unzip
  ];

  programs.home-manager.enable = true;
  programs.starship.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  xdg.configFile.nvim = {
    source = ./nvim;
    recursive = true;
    target = "nvim";
  };

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.git = {
    enable = true;
    userName = "A1029384756";
    userEmail = "hayden.gray104@gmail.com";
    extraConfig = {
      credential = {
        credentialStore = "secretservice";
        helper = "${pkgs.git-credential-manager}/bin/git-credential-manager";
      };
    };
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = "set fish_greeting";
    shellAliases = {
      ls = "exa --icons -F -H --group-directories-first --git -h $argv";
      cat = "bat --theme base16-256 $argv";
      vi = "nvim $argv";
    };
  };

  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require 'wezterm'
      local config = {}
      
      if wezterm.config_builder then
        config = wezterm.config_builder()
      end
      
      config.color_scheme = 'Catppuccin Mocha'
      config.window_background_opacity = 0.9
      config.use_fancy_tab_bar = true
      
      return config
    '';
  };

  systemd.user.startServices = "sd-switch";
  home.stateVersion = "23.05";
}
