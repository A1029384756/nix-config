{ user, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gcc
    git
    glibc
    gtk-engine-murrine
    p7zip
    sqlite
    unzip
    wget
    wl-clipboard
  ];
  
  boot.loader.systemd-boot.configurationLimit = 10;
  users.users.${user}.home = "/home/${user}";
}
