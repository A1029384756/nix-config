{ lib, pkgs, ... }:
{
  services.printing.enable = true;
  services.xserver = {
    excludePackages = [ pkgs.xterm ];
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.flatpak.enable = true;
  xdg.portal.enable = true;

  services.gvfs = {
    enable = true;
    package = lib.mkForce pkgs.gnome3.gvfs;
  };
  services.samba.enable = true;
  services.tumbler.enable = true;
  services.gnome.gnome-keyring.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  hardware.bluetooth.enable = true;
}
