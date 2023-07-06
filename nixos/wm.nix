{ config, pkgs, ... }: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    nvidiaPatches = true;
  };

  programs.light.enable = true;

  fonts.fonts = with pkgs; [
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
    slurp
    socat
    wl-clipboard
    wofi
  ];
}
