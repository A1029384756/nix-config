{
  services.cockpit = {
    enable = true;
    openFirewall = true;
		allowed-origins = [
			"https://192.168.1.51:9090"
			"https://cockpit.vista.tailnet.cstring.dev"
		];
    settings = {
      WebService = {
        AllowUnencrypted = true;
      };
    };
  };
	services.caddy.virtualHosts."cockpit.vista.tailnet.cstring.dev".extraConfig = ''
		reverse_proxy localhost:9090
	'';
}
