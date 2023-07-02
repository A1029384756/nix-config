{ config, pkgs, ... }: {
  nix.settings.substituters = ["https://hyprland.cachix.org"];
  nix.settings.trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];

  programs.hyprland = {
    enable = true; 
    xwayland = {
      enable = true;
      hidpi = false;
    };
    nvidiaPatches = true;
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
  ];
}
