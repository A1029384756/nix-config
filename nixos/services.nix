{ config, pkgs, ... }: {
  services.printing.enable = true;
  services.supergfxd.enable = true;
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  systemd.services.supergfxd.path = [ pkgs.pciutils ];
  services.asusd = {
    enable = true;
    enableUserService = true;
  };
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  services.gnome.gnome-keyring.enable = true;
  sound.enable = true;
}
