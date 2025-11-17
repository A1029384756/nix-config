{ inputs
, user
, ...
}:
let
  host = "photos.cstring.dev";
  mediaLocation = "/mnt/data/immich";
  hardwareAcceleration = "/dev/dri/renderD128";
in
{
  services.caddy.virtualHosts.${host}.extraConfig = ''
    reverse_proxy 192.168.101.15:2283
  '';
  containers.immich = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.101.14";
    localAddress = "192.168.101.15";

    bindMounts.${mediaLocation} = {
      hostPath = mediaLocation;
      isReadOnly = false;
    };
    allowedDevices = [
      {
        modifier = "rwm";
        node = hardwareAcceleration;
      }
    ];

    config = { config, lib, pkgs, ... }: {
      services.immich = {
        enable = true;
        host = "0.0.0.0";
        settings.server.externalDomain = "https://${host}";
        accelerationDevices = [
          hardwareAcceleration
        ];
        inherit mediaLocation;
      };

      networking.firewall.allowedTCPPorts = [ 2283 ];
      system.stateVersion = "25.05";
    };
  };
}
