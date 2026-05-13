{ config, pkgs, ... }: {
	age.secrets.caddy.file = ../../secrets/caddy.age;
	services.caddy = {
		enable = true;
		package = pkgs.caddy.withPlugins {
			plugins = [ "github.com/caddy-dns/cloudflare@v0.2.4" ];
			hash = "sha256-J0HWjCPoOoARAxDpG2bS9c0x5Wv4Q23qWZbTjd8nW84=";
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
