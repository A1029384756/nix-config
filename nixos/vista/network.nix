{ config, pkgs, ... }: {
	age.secrets.caddy.file = ../../secrets/caddy.age;
	services.caddy = {
		enable = true;
		package = pkgs.caddy.withPlugins {
			plugins = [ "github.com/caddy-dns/cloudflare@v0.2.4" ];
			hash = "sha256-5a5cpFl90pEWt0lUC4ZJQ7g+1//ZvsRhee64Dt9vh5o=";
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
