{ config, user, pkgs, ... }:
let
	# Set to {id}-{branch}-{password} for betas.
	steam-app = "896660";
in
	{
	imports = [
		./steam.nix
	];

	age.secrets.valheim = {
		owner = user;
		file = ../../secrets/valheim.age;
	};

	systemd.services.valheim = {
		wantedBy = [ "multi-user.target" ];

		# Install the game before launching.
		wants = [ "steam@${steam-app}.service" ];
		after = [ "steam@${steam-app}.service" ];

		serviceConfig = {
			ExecStart = ''
					/var/lib/steam-app-${steam-app}/valheim_server.x86_64 \
					-nographics \
					-batchmode \
					-savedir \
					/mnt/data/valheim/save \
					-name \
					Frennz \
					-port \
					2456 \
					-world \
					World13769 \
					-password \
					$PASSWORD \
					-public \
					0 \
					-modifier \
					raids \
					none \
					-modifier \
					deathpenalty \
					easy \
					-setkey \
					playerevents \
					-setkey \
					dungeonbuild
			'';
			Nice = "-10";
			PrivateTmp = true;
			Restart = "always";
			User = user;
			WorkingDirectory = "~";
			EnvironmentFile = config.age.secrets.valheim.path;
		};
		environment = {
			# linux64 directory is required by Valheim.
			LD_LIBRARY_PATH = "/var/lib/steam-app-${steam-app}/linux64:${pkgs.libz}/lib:${pkgs.glibc}/lib";
			SteamAppId = "892970";
		};
	};

	networking.firewall = {
		allowedUDPPortRanges = [
			{ from = 2456; to = 2458; }
		];
	};
}
