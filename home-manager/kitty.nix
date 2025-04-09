{ ... }:
{
  catppuccin.kitty.enable = true;
  programs.kitty = {
    enable = true;

    font = {
      name = "Maple Mono NF CN";
      size = 11.0;
    };

    settings = {
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      background_opacity = "0.9";
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      hide_window_decorations = "no";
      linux_display_server = "x11";
    };
  };
}
