{ config, pkgs, lib, ... }:
let
  hostname = "cloud.cstring.dev";
  office = "office.cstring.dev";
in
{
  age.secrets.nextcloud_admin = {
    file = ../../secrets/nextcloud_admin.age;
    owner = "nextcloud";
    group = "nextcloud";
  };

  services = {
    nextcloud = {
      enable = true;
      https = true;
      package = pkgs.nextcloud31;
      configureRedis = true;
      hostName = hostname;

      config.adminpassFile = config.age.secrets.nextcloud_admin.path;
      config.dbtype = "sqlite";

      extraAppsEnable = true;
      extraApps = {
        inherit (config.services.nextcloud.package.packages.apps)
          calendar
          contacts
          onlyoffice
          tasks
          ;
      };
    };

    phpfpm.pools.nextcloud.settings = {
      "listen.owner" = config.services.caddy.user;
      "listen.group" = config.services.caddy.group;
    };

    caddy.virtualHosts."https://${hostname}" = {
      extraConfig = ''
        encode zstd gzip

        root * ${config.services.nginx.virtualHosts.${hostname}.root}

        redir /.well-known/carddav /remote.php/dav 301
        redir /.well-known/caldav /remote.php/dav 301
        redir /.well-known/* /index.php{uri} 301
        redir /remote/* /remote.php{uri} 301

        header {
          Strict-Transport-Security max-age=31536000
          Permissions-Policy interest-cohort=()
          X-Content-Type-Options nosniff
          X-Frame-Options SAMEORIGIN
          Referrer-Policy no-referrer
          X-XSS-Protection "1;mode=block"
          X-Permitted-Cross-Domain-Policies none
          X-Robots-Tag "noindex,nofollow"
          -X-Powered-By
        }

        php_fastcgi unix/${config.services.phpfpm.pools.nextcloud.socket} {
          root ${config.services.nginx.virtualHosts.${hostname}.root}
          env front_controller_active true
          env modHeadersAvailable true
        }

        @forbidden {
          path /build/* /tests/* /config/* /lib/* /3rdparty/* /templates/* /data/*
          path /.* /autotest* /occ* /issue* /indie* /db_* /console*
          not path /.well-known/*
        }
        error @forbidden 404

        @notlegacy {
            path *.php *.php/
            not path /index* /remote* /public* /cron* /core/ajax/update* /status* /ocs/v1* /ocs/v2* /updater* /ocs-provider/* */richdocumentscode/proxy*
        }
        rewrite @notlegacy /index.php{uri}

        @immutable {
          path *.css *.js *.mjs *.svg *.gif *.png *.jpg *.ico *.wasm *.tflite
          query v=*
        }
        header @immutable Cache-Control "max-age=15778463, immutable"

        @static {
          path *.css *.js *.mjs *.svg *.gif *.png *.jpg *.ico *.wasm *.tflite
          not query v=*
        }
        header @static Cache-Control "max-age=15778463"

        @woff2 path *.woff2
        header @woff2 Cache-Control "max-age=604800"

        file_server
      '';
    };

    # disable nginx but allow onlyoffice to start
    nginx.enable = lib.mkForce false;

    caddy.virtualHosts."https://${office}" = {
      extraConfig = ''
        reverse_proxy http://127.0.0.1:21835 {
          header_up X-Forwarded-Proto https
        }
      '';
    };

    onlyoffice = {
      enable = true;
      hostname = "localhost";
      port = 21835;
    };
  };

  users.users.nginx = {
    group = "nginx";
    isSystemUser = true;
  };
  users.groups.nginx = { };
}
