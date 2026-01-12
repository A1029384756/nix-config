{
	services = {
		cockpit = {
			enable = true;
			allowed-origins = [
				"https://cockpit.vista.tailnet.cstring.dev"
			];
		};
		caddy.virtualHosts."cockpit.vista.tailnet.cstring.dev".extraConfig = ''
			tls {
				dns cloudflare {env.CF_API_TOKEN}
			}
			reverse_proxy localhost:9090
		'';
		headscale.settings.dns.extra_records = [
			{
				name = "cockpit.vista.tailnet.cstring.dev";
				type = "A";
				value = "100.64.0.5";
			}
		];
	};
}
