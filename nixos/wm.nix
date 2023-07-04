{ config, pkgs, ... }: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    nvidiaPatches = true;
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraOptions = [ "--unsupported-gpu" ];
  };

  programs.waybar.enable = true;
  programs.light.enable = true;

  fonts.fonts = with pkgs; [
   (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  environment.systemPackages = with pkgs; [ 
    inotify-tools 
    grim 
    slurp
    pamixer
    dunst
    wofi
    killall
    dex
    cliphist
  ];
}
