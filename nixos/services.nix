{ config, pkgs, ... }: {
  services.printing.enable = true;
  services.xserver.enable = true;
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

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
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
