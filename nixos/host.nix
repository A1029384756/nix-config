{ config, pkgs, ... }: {
  networking.hostName = "laptop";
  networking.networkmanager.enable = true;
  time.timeZone = "US/Eastern";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.haydengray = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" ];
    initialPassword = "pw123";
    shell = pkgs.fish;
    packages = with pkgs; [
      btop
    ];
  };
}
