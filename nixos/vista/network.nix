{ config, pkgs, ... }: {
	age.secrets.caddy.file = ../../secrets/caddy.age;
	services.caddy = {
		enable = true;
		package = pkgs.caddy.withPlugins {
			plugins = [ "github.com/caddy-dns/cloudflare@v0.2.4" ];
			hash = "sha256-bzMqxWTqrJ1skZmRTXyEMCKStXpljbqe5r0Ve2cnBfM=";
		};
		environmentFile = config.age.secrets.caddy.path;
	};
	boot.kernel.sysctl = {
		"net.ipv4.ip_nonlocal_bind" = 1;
		"net.ipv6.ip_nonlocal_bind" = 1;
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
