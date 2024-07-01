{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    btop
    gcc
    git
    glibc
    p7zip
    sqlite
    unzip
    wget
    wl-clipboard
  ];
}
