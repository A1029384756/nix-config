let
	host = "cockpit.vista.cstring.dev";
in {
	services = {
		cockpit = {
			enable = true;
			allowed-origins = [
				"https://${host}"
			];
		};
		caddy.virtualHosts.${host}.extraConfig = ''
			bind 100.64.0.5
			tls {
				dns cloudflare {env.CF_API_TOKEN}
			}
			reverse_proxy localhost:9090
		'';
		headscale.settings.dns.extra_records = [{
			name = host;
			type = "A";
			value = "100.64.0.5";
		}];
	};
}
