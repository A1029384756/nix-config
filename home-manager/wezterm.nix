{ config, pkgs, ... }: {
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
      config.warn_about_missing_glyphs = false
      
      return config
    '';
  };
}
