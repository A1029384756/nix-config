{ config, pkgs, ... }: {
  services.printing.enable = true;
  services.xserver = {
    excludePackages = [ pkgs.xterm ];
    enable = true;
    layout = "us";
    xkbVariant = "";
  };

  services.flatpak.enable = true;

  services.gvfs.enable = true;
  services.gnome.evolution-data-server.enable = true;
  services.accounts-daemon.enable = true;
  services.gnome.gnome-online-accounts.enable = true;
  services.gnome.gnome-keyring.enable = true;
  programs.dconf.enable = true;

  services.xserver.displayManager.gdm.enable = true;

  services.supergfxd.enable = true;
  systemd.services.supergfxd.path = [ pkgs.pciutils ];
  services.asusd = {
    enable = true;
    enableUserService = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}
