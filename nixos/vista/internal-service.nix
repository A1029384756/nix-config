{ config, lib, ... }: let
	cfg = config.internal_service;
	inherit (lib)
		mapAttrs'
		mapAttrsToList
		mkOption
		nameValuePair
		types
		;
in {
	options.internal_service = mkOption {
		default = {};
		description = "services only reachable on tailnet";
		type = types.attrsOf ( types.submodule ({ name, ... }: {
			options = {
				host = mkOption { type = types.str; };
				port = mkOption { type = types.port; };
				ip   = mkOption { type = types.str; };
			};
		}));
	};

	config = {
		services.caddy.virtualHosts = mapAttrs' (_: s:
			nameValuePair s.host {
				extraConfig = ''
					bind ${s.ip}
					reverse_proxy localhost:${toString s.port}
				'';
		}) cfg;
		services.headscale.settings.dns.extra_records = mapAttrsToList (_: s: {
			name = s.host;
			type = "A";
			value = s.ip;
		}) cfg;
	};
}
