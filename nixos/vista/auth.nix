{ config, ... }:
{
  age.secrets.authentik.file = ../../secrets/authentik.age;
  virtualisation.quadlet =
    let
      inherit (config.virtualisation.quadlet) pods volumes;
      inherit (config.age) secrets;
    in
    {
      containers = {
        authentikServer.containerConfig = {
          image = "ghcr.io/goauthentik/server:2025.10.2";
          pod = pods.authentik.ref;
          exec = "server";
          environmentFiles = [
            secrets.authentik.path
          ];
          volumes = [
            "${volumes.authentikMedia.ref}:/media"
            "${volumes.authentikTemplates.ref}:/templates"
          ];
        };
        authentikDB.containerConfig = {
          image = "docker.io/library/postgres:16-alpine";
          pod = pods.authentik.ref;
          environmentFiles = [
            secrets.authentik.path
          ];
          volumes = [
            "${volumes.authentikDatabase.ref}:/var/lib/postgresql/data"
          ];
        };
        authentikWorker.containerConfig = {
          image = "ghcr.io/goauthentik/server:2025.10.2";
          pod = pods.authentik.ref;
          exec = "worker";
          environmentFiles = [
            secrets.authentik.path
          ];
          volumes = [
            "${volumes.authentikMedia.ref}:/media"
            "${volumes.authentikTemplates.ref}:/templates"
          ];
        };
        # this depends on values from the main authentik
        # server after the LDAP provider has been created
        authentikLDAP.containerConfig = {
          image = "ghcr.io/goauthentik/ldap:2025.10.2";
          pod = pods.authentik.ref;
          environmentFiles = [
            secrets.authentik.path
          ];
          volumes = [
            "${volumes.authentikMedia.ref}:/media"
            "${volumes.authentikTemplates.ref}:/templates"
          ];
        };
      };
      pods = {
        authentik.podConfig = {
          publishPorts = [
            # server http
            "7000:9000"
            # ldaps
            "636:6636"
          ];
        };
      };
      volumes = {
        authentikMedia.volumeConfig = {
          type = "bind";
          device = "/mnt/data/authentik/media";
        };
        authentikTemplates.volumeConfig = {
          type = "bind";
          device = "/mnt/data/authentik/templates";
        };
        authentikDatabase.volumeConfig = {
          type = "bind";
          device = "/mnt/data/authentik/database";
        };
      };
    };

  services.caddy.virtualHosts = {
    "auth.cstring.dev".extraConfig = ''
      reverse_proxy localhost:7000
    '';
  };
}
