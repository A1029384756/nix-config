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
  services.tumbler.enable = true;
  services.gnome.gnome-keyring.enable = true;

  services.xserver.displayManager.gdm.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}
