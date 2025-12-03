{ config, pkgs, lib, ... }:
let
  nextcloud = "cloud.cstring.dev";
  collabora = "office.cstring.dev";
in
{
  age.secrets.nextcloud_admin = {
    file = ../../secrets/nextcloud_admin.age;
    owner = "nextcloud";
    group = "nextcloud";
  };
  age.secrets.nextcloud_whiteboard.file = ../../secrets/nextcloud_whiteboard.age;

  services = {
    nextcloud = {
      enable = true;
      https = true;
      package = pkgs.nextcloud31;
      hostName = nextcloud;

      config.adminpassFile = config.age.secrets.nextcloud_admin.path;
      config.dbtype = "sqlite";

      extraApps = {
        inherit (config.services.nextcloud.package.packages.apps)
          calendar
          contacts
          richdocuments
          tasks
          whiteboard
          ;
      };
    };

    nextcloud-whiteboard-server = {
      enable = true;
      settings.NEXTCLOUD_URL = "http://localhost";
      secrets = [ config.age.secrets.nextcloud_whiteboard.path ];
    };

    phpfpm.pools.nextcloud.settings = {
      "listen.owner" = config.services.caddy.user;
      "listen.group" = config.services.caddy.group;
    };

    caddy.virtualHosts."https://${nextcloud}" = {
      extraConfig = ''
        encode zstd gzip

        root * ${config.services.nginx.virtualHosts.${nextcloud}.root}

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
          root ${config.services.nginx.virtualHosts.${nextcloud}.root}
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

    caddy.virtualHosts."https://${collabora}" = {
      extraConfig = ''
        encode zstd gzip
        reverse_proxy http://[::1]:12841
      '';
    };

    collabora-online = {
      enable = true;
      port = 12841;
      settings = {
        ssl = {
          enable = false;
          termination = true;
        };

        net = {
          listen = "loopback";
          post_allow.host = [ "::1" ];
        };

        storage.wopi = {
          "@allow" = true;
          host = [ "nextcloud.example.com" ];
        };

        server_name = collabora;
      };
    };

    nginx.enable = lib.mkForce false;
  };

  systemd.services.nextcloud-config-collabora =
    let
      inherit (config.services.nextcloud) occ;
      wopi_url = "http://[::1]:${toString config.services.collabora-online.port}";
      public_wopi_url = collabora;
      wopi_allowlist = lib.concatStringsSep "," [
        "127.0.0.1"
        "::1"
      ];
    in
    {
      wantedBy = [ "multi-user.target" ];
      after = [ "nextcloud-setup.service" "coolwsd.service" ];
      requires = [ "coolwsd.service" ];

      script = ''
        ${occ}/bin/nextcloud-occ config:app:set richdocuments wopi_url --value ${lib.escapeShellArg wopi_url}
        ${occ}/bin/nextcloud-occ config:app:set richdocuments public_wopi_url --value ${lib.escapeShellArg public_wopi_url}
        ${occ}/bin/nextcloud-occ config:app:set richdocuments wopi_allowlist --value ${lib.escapeShellArg wopi_allowlist}
        ${occ}/bin/nextcloud-occ richdocuments:setup
      '';
      serviceConfig = {
        Type = "oneshot";
      };
    };

  networking.hosts = {
    "127.0.0.1" = [ nextcloud collabora ];
    "::1" = [ nextcloud collabora ];
  };

  users.users.nginx = {
    group = "nginx";
    isSystemUser = true;
  };
  users.groups.nginx = { };
}
