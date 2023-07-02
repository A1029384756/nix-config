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

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  home.packages = with pkgs; [ 
    git-credential-oauth
    jq
    exa
    bat
    rtx
    ripgrep
    starship
  ];

  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "A1029384756";
    userEmail = "hayden.gray104@gmail.com";
    extraConfig = {
      credential = {
        credentialStore = "secretservice";
        helper = "${pkgs.git-credential-oauth}/bin/git-credential-oauth";
      };
    };
  };

  programs.neovim.enable = true;

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
