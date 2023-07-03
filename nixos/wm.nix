{ config, pkgs, ... }: {
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  programs.hyprland.nvidiaPatches = true;
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
  ];

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraOptions = [ "--unsupported-gpu" ];
  };
}
