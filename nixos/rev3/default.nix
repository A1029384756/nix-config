{ config, pkgs, ... }: {
  imports =
    [ 
    ../base.nix
    ../containers.nix
    ../fonts.nix
    ../host.nix
    ../gnome.nix
    ../nautilus.nix
    ../nvidia.nix
    ../services.nix
    ../vm.nix
    /etc/nixos/hardware-configuration.nix
    ];

  stylix = {
    enable = true;
    image = ../../assets/bg.png;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    fonts = {
      monospace = {
        package = (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; });
        name = "JetBrainsMono Nerd Font";
      };

      sansSerif = {
        package = (pkgs.nerdfonts.override { fonts = [ "Ubuntu" ]; });
        name = "Ubuntu Nerd Font";
      };

      serif = config.stylix.fonts.sansSerif;
      emoji = config.stylix.fonts.sansSerif;
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Original-Classic";
      size = 16;
    };
  };


  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    plymouth.enable = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };
  programs.fish.enable = true;

  system.stateVersion = "23.11";
}
