{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    displayManager.gdm.autoSuspend = false;
  };

  environment = {
    gnome.excludePackages =
      (with pkgs; [
        gnome-console
        gnome-photos
        gnome-tour
        gnome-connections
        snapshot
        gedit
      ])
      ++ (with pkgs.gnome; [
        cheese
        gnome-music
        evince
        gnome-characters
        totem
        tali
        iagno
        hitori
        atomix
        yelp
        gnome-contacts
        gnome-initial-setup
        gnome-shell-extensions
        gnome-maps
        gnome-font-viewer
      ]);

    systemPackages = with pkgs; [
      clapper
      gnome.dconf-editor 
    ];
  };

  programs.dconf.profiles = {
    user.databases = [
      {
        settings = {
          "org/gnome/mutter".experimental-features = [ "variable-refresh-rate" ];
          "org/gnome/mutter".dynamic-workspaces = true;
          "org/gnome/desktop/peripherals/mouse".accel-profile = "flat";
        };
      }
    ];
  };
}
