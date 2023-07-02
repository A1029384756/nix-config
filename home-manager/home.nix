{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./git.nix
    ./shell.nix
    ./wezterm.nix
    ./nvim/nvim.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "haydengray";
    homeDirectory = "/home/haydengray";
  };

  home.packages = with pkgs; [ 
    git-credential-manager
    jq
    exa
    bat
    ripgrep
    unzip
  ];

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";
  home.stateVersion = "23.05";
}
