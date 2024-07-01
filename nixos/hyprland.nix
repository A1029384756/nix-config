{ inputs, pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  xdg.portal.enable = true;

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    displayManager.gdm.autoSuspend = false;
  };

  environment.systemPackages =
    with pkgs;
    with gnome;
    [
      loupe
      nautilus
      baobab
      gnome-disk-utility
      gnome-text-editor
      gnome-calendar
      gnome-boxes
      gnome-system-monitor
      gnome-weather
      gnome-calculator
      gnome-clocks
      gnome-software
      wl-gammactl
      wl-clipboard
      wayshot
      pavucontrol
      brightnessctl
      swww
      blueman
      udiskie
      networkmanagerapplet
      grimblast
      cliphist
      pulseaudio
      lm_sensors
    ];

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  services = {
    accounts-daemon.enable = true;
    gnome = {
      evolution-data-server.enable = true;
      glib-networking.enable = true;
      gnome-keyring.enable = true;
      gnome-online-accounts.enable = true;
    };
  };

  security.polkit.enable = true;

  system.stateVersion = "23.11";
}
