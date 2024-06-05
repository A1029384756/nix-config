{ pkgs, ... }: {
  programs.waybar.enable = true;

  home.packages = with pkgs; [
    killall
    wl-clipboard
    wofi

    # todo: add color picker
    hyprpicker
  ];

  home.file.".config/waybar" = {
    source = ./config;
    recursive = true;
  };
}
