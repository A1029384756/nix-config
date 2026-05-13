let 
	port = 7092;
in {
	services = {
		scrutiny = {
			enable = true;
			openFirewall = true;
			collector.schedule = "daily";
			settings.web.listen.port = port;
		};
		caddy.virtualHosts."scrutiny.vista.cstring.dev".extraConfig = ''
			bind 100.64.0.5
			tls {
				dns cloudflare {env.CF_API_TOKEN}
			}
			reverse_proxy localhost:${toString port}
		'';
		headscale.settings.dns.extra_records = [{
			name = "scrutiny.vista.cstring.dev";
			type = "A";
			value = "100.64.0.5";
		}];
	};
}
