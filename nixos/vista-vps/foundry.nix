{ inputs, ... }:
let
  foundry_instance = { name, version, hostAddress, localAddress }:
    let
      host = "cstring.dev";
    in
    {
      containers.${name} = {
        autoStart = true;
        privateNetwork = true;
        inherit hostAddress;
        inherit localAddress;

        bindMounts.foundrydata = {
          mountPoint = "/var/lib/foundryvtt";
          isReadOnly = false;
          hostPath = "/home/haydengray/${name}";
        };

        config = with inputs; {
          imports = [ foundryvtt.nixosModules.foundryvtt ];
          services.foundryvtt = {
            enable = true;
            hostName = host;
            proxySSL = true;
            proxyPort = 443;
            package = foundryvtt.packages.x86_64-linux.foundryvtt.overrideAttrs {
              __intentionallyOverridingVersion = true;
              inherit version;
            };
          };

          networking.firewall = {
            enable = true;
            allowedTCPPorts = [ 30000 ];
          };

          system.stateVersion = "24.11";
        };
      };

      services.caddy.virtualHosts."${name}.${host}".extraConfig = ''
        reverse_proxy ${localAddress}:30000
      '';
    };
in
{
  imports = [
    (foundry_instance
      {
        name = "theros";
        version = "12.0.0+331";
        hostAddress = "192.168.100.10";
        localAddress = "192.168.100.11";
      })
    (foundry_instance
      {
        name = "ewington";
        version = "13.0.0+351";
        hostAddress = "192.168.100.12";
        localAddress = "192.168.100.13";
      })
    (foundry_instance
      {
        name = "winters";
        version = "13.0.0+348";
        hostAddress = "192.168.100.14";
        localAddress = "192.168.100.15";
      })
  ];
}
