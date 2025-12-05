{ config, ... }:
let
  hostname = "cloud.cstring.dev";
in
{
  age.secrets.nextcloud.file = ../../secrets/nextcloud_admin.age;
  virtualisation.quadlet =
    let
      inherit (config.virtualisation.quadlet) networks pods volumes;
    in
    {
      containers = {
        nc.containerConfig = {
          image = "docker.io/library/nextcloud:32-apache";
          pod = pods.nextcloud.ref;
          volumes = [
            "${volumes.nextcloudData.ref}:/var/www/html/data"
            "${volumes.nextcloudConfig.ref}:/var/www/html"
          ];
          environments = {
            NEXTCLOUD_TRUSTED_DOMAINS = "${hostname}";
          };
          environmentFiles = [
            config.age.secrets.nextcloud.path
          ];
        };
        ncredis.containerConfig = {
          image = "docker.io/library/redis:alpine";
          pod = pods.nextcloud.ref;
        };
        ncdb.containerConfig = {
          image = "docker.io/library/mariadb:12.1";
          pod = pods.nextcloud.ref;
          volumes = [
            "${volumes.nextcloudDatabase.ref}:/var/lib/mysql"
          ];
          environmentFiles = [
            config.age.secrets.nextcloud.path
          ];
        };
      };
      pods = {
        nextcloud.podConfig = {
          publishPorts = [
            "9000:80"
          ];
        };
      };
      volumes = {
        nextcloudData.volumeConfig = {
          type = "bind";
          device = "/mnt/data/nextcloud/data";
        };
        nextcloudConfig.volumeConfig = {
          type = "bind";
          device = "/mnt/data/nextcloud/config";
        };
        nextcloudDatabase.volumeConfig = {
          type = "bind";
          device = "/mnt/data/nextcloud/database";
        };
      };
    };

  services.caddy.virtualHosts.${hostname}.extraConfig = ''
    reverse_proxy localhost:9000

    header {
    	Strict-Transport-Security "max-age=15552000; includeSubDomains; preload"
    }
  '';

  networking.firewall.allowedTCPPorts = [ 9000 ];
}
