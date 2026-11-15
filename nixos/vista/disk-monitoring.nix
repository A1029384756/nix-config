{ config, ... }:
let
	port = 7092;
in {
	services.scrutiny = {
		enable = true;
		openFirewall = true;
		collector.schedule = "daily";
		settings.web.listen.port = port;
	};

	internal_service.scrutiny = {
		host = "scrutiny.vista.cstring.dev";
		port = port;
		ip = config.vista.tailnetIp;
	};
}
