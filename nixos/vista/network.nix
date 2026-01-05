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
      allowedTCPPorts = [ 80 443 ];
      # http3
      allowedUDPPorts = [ 443 ];
    };
  };
}
