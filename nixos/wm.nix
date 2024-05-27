{ inputs, config, pkgs, ... }: {
  programs.hyprland.enable = true;

  programs.light.enable = true;

  fonts.packages = with pkgs; [
   (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
   material-symbols
   open-sans
  ];

  environment.systemPackages = with pkgs; [ 
    cliphist
    dex
    dunst
    grim 
    hyprpaper
    inotify-tools 
    killall
    pamixer
    pavucontrol
    slurp
    socat
    wl-clipboard
    wofi
  ];
}
