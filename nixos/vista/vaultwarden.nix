{ config, ... }:
let
  hostname = "vaultwarden.cstring.dev";
  port = "40962";
in
{
  age.secrets.vaultwarden.file = ../../secrets/vaultwarden.age;

  services.vaultwarden = {
    enable = true;
    backupDir = "/mnt/data/vaultwarden";
    environmentFile = config.age.secrets.vaultwarden.path;

    config = {
      domain = "https://${hostname}";
      signupsAllowed = false;
      rocketPort = port;
    };
  };

  services.caddy.virtualHosts.${hostname}.extraConfig = ''
    reverse_proxy localhost:${port}
  '';
}

