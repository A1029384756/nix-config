{ pkgs, ... }: {
  programs.waybar.enable = true;

  home.packages = with pkgs; [
    cliphist
    hyprpicker
    killall
    pavucontrol
    wl-clipboard
    wofi
  ];

  home.file.".config/waybar" = {
    source = ./config;
    recursive = true;
  };
}
