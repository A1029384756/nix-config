{ user, pkgs, ... }: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
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
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "storage" "networkmanager" "libvirtd" ];
    initialPassword = "pw123";
    shell = pkgs.fish;
    packages = with pkgs; [
      btop
      clapper
      thunderbird
    ];
  };

  nixpkgs.config.allowUnfree = true;

  hardware.steam-hardware.enable = true;
  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;

  programs.steam.enable = true;
}
