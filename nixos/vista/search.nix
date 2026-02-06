{ config, ... }:
{
	age.secrets.searxng.file = ../../secrets/searxng.age;
	services.searx = {
		enable = true;
		redisCreateLocally = true;
		settings = {
			general = {
				debug = false;
			};
			server = {
				bind_address = "::1";
				port = 10000;
			};
		};
		environmentFile = config.age.secrets.searxng.path;
	};

	services.caddy.virtualHosts."search.cstring.dev".extraConfig = ''
		reverse_proxy localhost:10000
	'';
}
