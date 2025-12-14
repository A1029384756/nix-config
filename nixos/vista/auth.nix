{ config, user, ... }:
{
  age.secrets.pocket-id.file = ../../secrets/pocket-id.age;
  services.pocket-id = {
    inherit user;
    enable = true;
    settings = {
      APP_URL = "https://pocketid.cstring.dev";
      TRUST_PROXY = true;
    };
    environmentFile = config.age.secrets.pocket-id.path;
    dataDir = "/mnt/data/pocketid";
  };

  services.caddy.virtualHosts = {
    "pocketid.cstring.dev".extraConfig = ''
      reverse_proxy localhost:1411
    '';
  };
}
