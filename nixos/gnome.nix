{ config, pkgs, ... }: {
  services = {
    xserver = {
      enable = true;
      desktopManager.gnome = {
        enable = true;
        extraGSettingsOverridePackages = [pkgs.gnome.mutter];
        extraGSettingsOverrides = ''
          [org.gnome.mutter]
          experimental-features=['variable-refresh-rate', 'scale-monitor-framebuffer']
        '';
      };
      displayManager.gdm.enable = true;
    };
  };
}
