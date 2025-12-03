{ config, pkgs, lib, ... }:
let
  nextcloud = "cloud.cstring.dev";
  collabora = "office.cstring.dev";
in
{
  imports = [
    "${fetchGit {
			url = "https://github.com/A1029384756/nixos-nextcloud-caddy";
			rev = "d8ff002a39b038cbd7e11c88a55f75c28883d265";
		}}/nextcloud-extras.nix"
  ];

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
      webserver = "caddy";

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
