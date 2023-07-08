{ config, pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [
    gcc
    git
    gtk-engine-murrine
    p7zip
    sqlite
    unzip
    wget
  ];
}
