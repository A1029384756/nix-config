{ config, ... }: {
	age.secrets.headscale = {
		owner = config.services.headscale.user;
		file = ../../secrets/headscale.age;
	};
	services = {
		headscale = {
			enable = true;
			port = 8296;
			settings = {
				server_url = "https://headscale.cstring.dev";
				dns = { 
					base_domain = "tailnet.cstring.dev"; 
					nameservers.global = [ "1.1.1.1" "8.8.8.8" ];
					extra_records = [
						{
							name = "cockpit.vista.tailnet.cstring.dev";
							type = "A";
							value = "100.64.0.5";
						}
					];
				};
				oidc = {
					issuer = "https://pocketid.cstring.dev";
					client_id = "42a4d1a7-83f1-4c25-8a37-617642c52da5";
					client_secret_path = config.age.secrets.headscale.path;
					pkce.enabled = true;
				};
			};
		};
		caddy.virtualHosts."headscale.cstring.dev".extraConfig = ''
			reverse_proxy localhost:8296
		'';
	};
}
