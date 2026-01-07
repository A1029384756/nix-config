{
  services.cockpit = {
    enable = true;
    openFirewall = true;
		allowed-origins = [
			"https://192.168.1.51:9090"
		];
    settings = {
      WebService = {
        AllowUnencrypted = true;
      };
    };
  };
}
