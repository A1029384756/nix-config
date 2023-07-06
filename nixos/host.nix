{ config, pkgs, ... }: {
  networking.hostName = "laptop";
  networking.networkmanager.enable = true;
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  users.users.haydengray = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "storage" "networkmanager" ];
    initialPassword = "pw123";
    shell = pkgs.fish;
    packages = with pkgs; [
      btop
      firefox
      gnome.gnome-software
      thunderbird
      xfce.orage
      xfce.parole
      xfce.thunar
      xfce.thunar-archive-plugin
      xfce.thunar-media-tags-plugin
      xfce.thunar-volman
    ];
  };
}
