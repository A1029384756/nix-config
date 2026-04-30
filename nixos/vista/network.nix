{ config, pkgs, ... }: {
	age.secrets.caddy.file = ../../secrets/caddy.age;
	services.caddy = {
		enable = true;
		package = pkgs.caddy.withPlugins {
			plugins = [ "github.com/caddy-dns/cloudflare@v0.2.2" ];
			hash = "sha256-7DGnojZvcQBZ6LEjT0e5O9gZgsvEeHlQP9aKaJIs/Zg=";
		};
		environmentFile = config.age.secrets.caddy.path;
	};
	networking = {
		nat = {
			enable = true;
			internalInterfaces = [ "ve-+" ];
			externalInterface = "eth0";
		};

		firewall = {
			enable = true;
			allowedTCPPorts = [ 80 443 ];
			# http3
			allowedUDPPorts = [ 443 ];
		};
	};
}
