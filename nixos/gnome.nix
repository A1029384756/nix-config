{ config, pkgs, lib, ... }: {
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    displayManager.gdm.autoSuspend = false;
  };

  environment = {
    gnome.excludePackages = with pkgs.gnome; [ pkgs.gnome-tour ];

    systemPackages = with pkgs; [ gnome.dconf-editor ];
  };

  programs.dconf.profiles = {
    user.databases = [{
      settings = with lib.gvariant; {
        "org/gnome/mutter".experimental-features = [ "variable-refresh-rate" ];
        "org/gnome/mutter".dynamic-workspaces = true;
        "org/gnome/desktop/peripherals/mouse".accel-profile = "flat";
      };
    }];
  };
}
