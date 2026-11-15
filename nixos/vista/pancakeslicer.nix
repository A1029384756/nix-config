{ config, ... }:
let
	host = "slicer.cstring.dev";
	vistaip = "100.64.0.5";
in {
	virtualisation.quadlet = let
		inherit (config.virtualisation.quadlet) pods volumes;
	in {
		containers = {
			pancakeslicer.containerConfig = {
				image = "ghcr.io/zimengxiong/pancakeslicer";
				autoUpdate = "registry";
				volumes = [
					"${volumes.pancakeslicerData.ref}:/data"
				];
				environments = {
					ORCA_WEB_MAX_JOBS = "2";
					ORCA_WEB_PRINTER_NETWORK = "lan";
					PANCAKE_STAGE_CACHE_MAX_MB = "1024";
				};
				publishPorts = [ "6868:6868" ];
			};
		};
		volumes = {
			pancakeslicerData.volumeConfig = {
				type = "bind";
				device = "/mnt/data/pancakeslicer";
			};
		};
	};

	services.caddy.virtualHosts.${host}.extraConfig = ''
			bind ${vistaip}
			reverse_proxy localhost:6868
	'';
	services.headscale.settings.dns.extra_records = [{
		name = host;
		type = "A";
		value = vistaip;
	}];
}
