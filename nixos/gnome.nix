{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    displayManager.gdm.autoSuspend = false;
  };

  environment = {
    gnome.excludePackages = [ pkgs.gnome-tour pkgs.gnome.yelp ];

    systemPackages = with pkgs; [ gnome.dconf-editor ];
  };

  programs.dconf.profiles = {
    user.databases = [{
      settings = {
        "org/gnome/mutter".experimental-features = [ "variable-refresh-rate" ];
        "org/gnome/mutter".dynamic-workspaces = true;
        "org/gnome/desktop/peripherals/mouse".accel-profile = "flat";
      };
    }];
  };
}
