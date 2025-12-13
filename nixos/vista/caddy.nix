{
  services.caddy.enable = true;
  networking = {
    nat = {
      enable = true;
      internalInterfaces = [ "ve-+" ];
      externalInterface = "eth0";
    };

    firewall = {
      enable = true;
      allowedTCPPorts = [ 80 443 636 ];
      allowedUDPPortRanges = [
        # valheim
        { from = 2456; to = 2458; }
      ];
      # http3
      allowedUDPPorts = [ 443 ];
    };
  };
}
