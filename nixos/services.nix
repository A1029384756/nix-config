{ lib, pkgs, ... }:
{
  services = {
    printing.enable = true;
    xserver = {
      excludePackages = [ pkgs.xterm ];
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    flatpak.enable = true;
    gvfs = {
      enable = true;
      package = lib.mkForce pkgs.gnome3.gvfs;
    };
    samba.enable = true;
    tumbler.enable = true;
    gnome.gnome-keyring.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };

  xdg.portal.enable = true;
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  hardware.bluetooth.enable = true;
}
