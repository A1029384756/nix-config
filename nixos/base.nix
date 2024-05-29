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
  ];

  users.users.${user}.home = "/home/${user}";
}
