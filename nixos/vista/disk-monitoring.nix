let 
	port = 7092;
	host = "scrutiny.vista.cstring.dev";
	vistaip = "100.64.0.5";
in {
	services = {
		scrutiny = {
			enable = true;
			openFirewall = true;
			collector.schedule = "daily";
			settings.web.listen.port = port;
		};
		caddy.virtualHosts.${host}.extraConfig = ''
			bind ${vistaip}
			tls {
				dns cloudflare {env.CF_API_TOKEN}
			}
			reverse_proxy localhost:${toString port}
		'';
		headscale.settings.dns.extra_records = [{
			name = host;
			type = "A";
			value = vistaip;
		}];
	};
}
