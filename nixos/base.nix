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

  environment.sessionVariables.LIBCLANG_PATH = lib.makeLibraryPath [ pkgs.llvmPackages_latest.libclang.lib ];
}
