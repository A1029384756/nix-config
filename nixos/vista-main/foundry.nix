{ inputs, pkgs, ... }: {
  containers.theros = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.100.10";
    localAddress = "192.168.100.11";

    bindMounts.foundrydata = {
      mountPoint = "/var/lib/foundryvtt";
      isReadOnly = false;
      hostPath = "/home/haydengray/theros";
    };

    config = with inputs; {
      imports = [ foundryvtt.nixosModules.foundryvtt ];
      services.foundryvtt = {
        enable = true;
        hostName = "cstring.dev";
        proxySSL = true;
        proxyPort = 443;
        package = foundryvtt.packages.x86_64-linux.foundryvtt.overrideAttrs {
          version = "12.0.0+331";
        };
      };

      networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 30000 ];
      };
    };
  };

  containers.ewington = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.100.12";
    localAddress = "192.168.100.13";

    bindMounts.foundrydata = {
      mountPoint = "/var/lib/foundryvtt";
      isReadOnly = false;
      hostPath = "/home/haydengray/ewington";
    };

    config = with inputs; {
      imports = [ foundryvtt.nixosModules.foundryvtt ];
      services.foundryvtt = {
        enable = true;
        hostName = "cstring.dev";
        proxySSL = true;
        proxyPort = 443;
        package = foundryvtt.packages.x86_64-linux.foundryvtt.overrideAttrs {
          version = "12.0.0+331";
        };
      };

      networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 30000 ];
      };
    };
  };

  services.caddy = {
    enable = true;
    virtualHosts."theros.cstring.dev".extraConfig = ''
      reverse_proxy 192.168.100.11:30000
    '';
    virtualHosts."ewington.cstring.dev".extraConfig = ''
      reverse_proxy 192.168.100.13:30000
    '';
  };

  networking.nat = {
    enable = true;
    internalInterfaces = [ "ve-+" ];
    externalInterface = "eth0";
  };
}
