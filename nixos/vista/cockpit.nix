let
	host = "cockpit.vista.cstring.dev";
	vistaip = "100.64.0.5";
in {
	services = {
		cockpit = {
			enable = true;
			allowed-origins = [
				"https://${host}"
			];
		};
		caddy.virtualHosts.${host}.extraConfig = ''
			bind ${vistaip}
			tls {
				dns cloudflare {env.CF_API_TOKEN}
			}
			reverse_proxy localhost:9090
		'';
		headscale.settings.dns.extra_records = [{
			name = host;
			type = "A";
			value = vistaip;
		}];
	};
}
