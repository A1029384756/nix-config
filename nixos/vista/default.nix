{ user, pkgs, ... }:
{
  imports = [
    ./disko-config.nix
    ./jellyfin.nix
    ./minecraft.nix
    ./caddy.nix
    ./valheim.nix
    ./steam.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [ user ];
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  services.openssh.enable = true;
  users.users.${user} = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC/ZbPqfUBjnhwW859snOnvqmuvaVtfNq5kuSpn/zOmV haydengray@fedora"
    ];
    extraGroups = [ "wheel" "render" "video" ];
    initialHashedPassword = "$y$j9T$2DyEjQxPoIjTkt8zCoWl.0$3mHxH.fqkCgu53xa0vannyu4Cue3Q7xL4CrUhMxREKC"; # Password.123
    shell = pkgs.fish;
  };
  programs.fish.enable = true;

  system.stateVersion = "25.05";
  nixpkgs.hostPlatform = "x86_64-linux";
  hardware.enableRedistributableFirmware = true;
  time.timeZone = "UTC";

  networking.hostName = "vista";
  networking.useDHCP = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "net.ifnames=0" ];
  boot.loader.grub = {
    device = "nodev";
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };
}
