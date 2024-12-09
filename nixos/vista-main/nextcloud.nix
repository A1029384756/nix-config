{ config, pkgs, ... }:
{
  imports = [
    "${fetchTarball {
    url = "https://github.com/onny/nixos-nextcloud-testumgebung/archive/fa6f062830b4bc3cedb9694c1dbf01d5fdf775ac.tar.gz";
    sha256 = "0gzd0276b8da3ykapgqks2zhsqdv4jjvbv97dsxg0hgrhb74z0fs";}}/nextcloud-extras.nix"
  ];

  age.secrets.nextcloud_admin = {
    file = ../../secrets/nextcloud_admin.age;
    owner = "nextcloud";
    group = "nextcloud";
  };

  services.nextcloud = {
    enable = true;
    https = true;
    package = pkgs.nextcloud30;
    hostName = "cloud.cstring.dev";
    config.adminpassFile = config.age.secrets.nextcloud_admin.path;

    extraAppsEnable = true;
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps) news contacts calendar tasks;
    };

    webserver = "caddy";
  };
}
