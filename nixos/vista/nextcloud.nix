{ config, user, ... }:
let
  nextcloudhost = "cloud.cstring.dev";
  officehost = "office.cstring.dev";
  whiteboardhost = "whiteboard.cstring.dev";
	uid = config.users.users.${user}.uid;
in
{
  age.secrets.nextcloud = {
		owner = user;
		file = ../../secrets/nextcloud_admin.age;
	};
	age.secrets.onlyoffice = {
		owner = user;
		file = ../../secrets/onlyoffice.age;
	};
  virtualisation.quadlet =
    let
      inherit (config.virtualisation.quadlet) pods volumes;
      inherit (config.age) secrets;
    in
    {
			autoUpdate.enable = true;
      autoEscape = true;
      containers = {
				nc.rootlessConfig.uid = uid;
        nc.containerConfig = {
          image = "docker.io/library/nextcloud:35-apache";
					autoUpdate = "registry";
          pod = pods.nextcloud.ref;
          user = "0:0";
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
				nccron.rootlessConfig.uid = uid;
        nccron.containerConfig = {
          image = "docker.io/library/nextcloud:35-apache";
					autoUpdate = "registry";
          pod = pods.nextcloud.ref;
          entrypoint = "/cron.sh";
          user = "0:0";
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
				ncredis.rootlessConfig.uid = uid;
        ncredis.containerConfig = {
          image = "docker.io/library/redis:alpine";
					autoUpdate = "registry";
          pod = pods.nextcloud.ref;
        };
				ncdb.rootlessConfig.uid = uid;
        ncdb.containerConfig = {
          image = "docker.io/library/mariadb:12.1";
					autoUpdate = "registry";
          pod = pods.nextcloud.ref;
					exec = "--innodb-log-file-size=256M";
					user = "33:33";
          volumes = [
            "${volumes.nextcloudDatabase.ref}:/var/lib/mysql"
          ];
          environmentFiles = [
            secrets.nextcloud.path
          ];
        };
				onlyofficedocumentserver.rootlessConfig.uid = uid;
				onlyofficedocumentserver.containerConfig = {
					image = "docker.io/onlyoffice/documentserver:9.3";
					autoUpdate = "registry";
					pod = pods.onlyoffice.ref;
					environmentFiles = [
						secrets.onlyoffice.path
					];
				};
				ncwhiteboard.rootlessConfig.uid = uid;
        ncwhiteboard.containerConfig = {
          image = "ghcr.io/nextcloud/whiteboard:stable";
					autoUpdate = "registry";
          pod = pods.nextcloud.ref;
          environmentFiles = [
            secrets.nextcloud.path
          ];
          healthCmd = ''node -e 'setTimeout(() => require("http").get("http://localhost:3002", res => process.exit(res.statusCode === 200 ? 0 : 1)), 1000)' '';
        };
      };
      pods = {
				nextcloud.rootlessConfig.uid = uid;
        nextcloud.podConfig = {
					userns = "keep-id:uid=33,gid=33";
          publishPorts = [
            # nextcloud
            "9000:80"
            # whiteboard
            "9002:3002"
          ];
        };
				onlyoffice.rootlessConfig.uid = uid;
				onlyoffice.podConfig = {
					publishPorts = [
						"9001:80"
					];
				};
      };
      volumes = {
				nextcloudData.rootlessConfig.uid = uid;
        nextcloudData.volumeConfig = {
          type = "bind";
          device = "/mnt/data/nextcloud/data";
        };
				nextcloudConfig.rootlessConfig.uid = uid;
        nextcloudConfig.volumeConfig = {
          type = "bind";
          device = "/mnt/data/nextcloud/config";
        };
				nextcloudDatabase.rootlessConfig.uid = uid;
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
