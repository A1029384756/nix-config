{ config, inputs, outputs, pkgs, ... }:
{
  imports =
    [ 
    ./hardware-configuration.nix
    ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  config.programs.hyprland = {
    enable = true; 
    xwayland = {
      enable = true;
      hidpi = false;
    };
    nvidiaPatches = true;
  };

  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 8d";

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  nixpkgs.config.allowUnfree = true;

  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "laptop";
  networking.networkmanager.enable = true;

  time.timeZone = "US/Eastern";

  i18n.defaultLocale = "en_US.UTF-8";

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

  sound.enable = true;

  users.users.haydengray = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" ];
    initialPassword = "pw123";
    packages = with pkgs; [
      jq
      exa
      bat
      rtx
      ripgrep
      starship

      discord
      steam

      wofi
      inotify-tools
      pfetch-rs

      grim
      slurp
    ];
  };

  environment.systemPackages = with pkgs; [
    gcc
    glibc
    neovim
    sqlite
    wget
    dunst
    killall
    rustup
    git
  ];

  programs.waybar.enable = true;
  programs.firefox.enable = true;
  programs.fish.enable = true;
  programs.light.enable = true;

  users.defaultUserShell = pkgs.fish;

  system.stateVersion = "23.05";
}
