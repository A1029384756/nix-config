{ config, ... }:
let
  nextcloudhost = "cloud.cstring.dev";
  officehost = "office.cstring.dev";
  whiteboardhost = "whiteboard.cstring.dev";
in
{
  age.secrets.nextcloud.file = ../../secrets/nextcloud_admin.age;
  virtualisation.quadlet =
    let
      inherit (config.virtualisation.quadlet) pods volumes;
      inherit (config.age) secrets;
    in
    {
      autoEscape = true;
      containers = {
        nc.containerConfig = {
          image = "docker.io/library/nextcloud:32-apache";
          pod = pods.nextcloud.ref;
          volumes = [
            "${volumes.nextcloudData.ref}:/var/www/html/data"
            "${volumes.nextcloudConfig.ref}:/var/www/html"
          ];
          environments = {
            NEXTCLOUD_TRUSTED_DOMAINS = "${nextcloudhost}";
          };
          environmentFiles = [
            secrets.nextcloud.path
          ];
        };
        nccron.containerConfig = {
          image = "docker.io/library/nextcloud:32-apache";
          pod = pods.nextcloud.ref;
          entrypoint = "/cron.sh";
          volumes = [
            "${volumes.nextcloudData.ref}:/var/www/html/data"
            "${volumes.nextcloudConfig.ref}:/var/www/html"
          ];
          environments = {
            NEXTCLOUD_TRUSTED_DOMAINS = "${nextcloudhost}";
          };
          environmentFiles = [
            secrets.nextcloud.path
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
            secrets.nextcloud.path
          ];
        };
        ncoffice.containerConfig = {
          image = "docker.io/collabora/code:25.04.7.3.1";
          pod = pods.nextcloud.ref;
          addCapabilities = [
            "MKNOD"
          ];
          environments = {
            DONT_GEN_SSL_CERT = "true";
            extra_params = "--o:ssl.enable=false --o:ssl.termination=true";
          };
        };
        ncwhiteboard.containerConfig = {
          image = "ghcr.io/nextcloud/whiteboard:stable";
          pod = pods.nextcloud.ref;
          environmentFiles = [
            secrets.nextcloud.path
          ];
          healthCmd = ''node -e 'setTimeout(() => require("http").get("http://localhost:3002", res => process.exit(res.statusCode === 200 ? 0 : 1)), 1000)' '';
        };
      };
      pods = {
        nextcloud.podConfig = {
          publishPorts = [
            # nextcloud
            "9000:80"
            # office
            "9001:9980"
            # whiteboard
            "9002:3002"
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

  services.caddy.virtualHosts = {
    ${nextcloudhost}.extraConfig = ''
      reverse_proxy localhost:9000

      header {
      	Strict-Transport-Security "max-age=15552000; includeSubDomains; preload"
      }
    '';
    ${officehost}.extraConfig = ''
      reverse_proxy localhost:9001
    '';
    ${whiteboardhost}.extraConfig = ''
      reverse_proxy localhost:9002
    '';
  };
}
