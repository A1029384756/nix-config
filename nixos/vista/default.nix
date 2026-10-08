{ config, user, pkgs, ... }:
{
	imports = [
		./disk-config.nix
		./jellyfin.nix
		./minecraft.nix
		./network.nix
		./valheim.nix
		./steam.nix
		./blog.nix
		./immich.nix
		./cockpit.nix
		./vaultwarden.nix
		./agenix.nix
		./wedding-site.nix
		./nextcloud.nix
		./auth.nix
		./llm.nix
		./headscale.nix
		./git.nix
		./backups.nix
		./search.nix
		./cinny.nix
		./disk-monitoring.nix
		./solitaire.nix
	];

	nixpkgs = {
		config.allowUnfree = true;
		hostPlatform = "x86_64-linux";
	};

	nix.settings = {
		experimental-features = [
			"nix-command"
			"flakes"
		];
		trusted-users = [ user ];
		substituters = [
			"https://cache.nixos.org"
		];
	};

	services.openssh = {
		enable = true;
		ports = [ 6142 ];
		settings = {
			PasswordAuthentication = false;
			KbdInteractiveAuthentication = false;
			PermitRootLogin = "no";
		};
	};
	users = {
		users = {
			${user} = {
				isNormalUser = true;
				openssh.authorizedKeys.keys = [
					"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC/ZbPqfUBjnhwW859snOnvqmuvaVtfNq5kuSpn/zOmV"
				];
				extraGroups = [ "wheel" "render" "video" ];
				initialHashedPassword = "$y$j9T$2DyEjQxPoIjTkt8zCoWl.0$3mHxH.fqkCgu53xa0vannyu4Cue3Q7xL4CrUhMxREKC"; # Password.123
				shell = pkgs.fish;
			};
			nezzy = {
				isSystemUser = true;
				group = "nezzy";
				openssh.authorizedKeys.keys = [
					"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDGedSf8UOLQCb6sC+JU4Cql/Y9Q/vd7JikDhSK5H+nfTMlzyVx4DIqkV+hW/U1cq5aUsNELlNura/A4htHgr/QWXqdHyIaIP6oEjln5quyb5PXqucTbhtSj+RWNvZAM5MM4F7s095SYMO76V/3tljC8Ti6RJ5QrC+kYFfEA7kT3YCqIl/uYERGnhj0CoPOPHiSSZF1md1CAcSzOlgYssi0LYS3Kg9e8P+ZlogrZoFjPAtfzKAwOkDktZktY/oLPo+GnJZw32/naIUOF3OTQrBZ4JEI+hsTC8NGsBS06i57MvyGaPw4HbVjVIPS5xMYo1jygsZw4SpoUHBK9Ro+F9uheLQkZipLZA7tzoqxxcOM/CdY0uAcqMZVie+hWfT3WF6phpyukHwkWgK8vQD7d9gXiPPATWEaq340Kli7rHP1siktCwstMEqvk+uE/pOF0jeOFz3U96WfLEvGomAGhuLdbPtJeV6urXMTioUhcorz3Bm9QWVQEQF9UdujmnpvAKc= jnezz@Josh_Comp"
					"fedora ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPNn544GyBNjDgfQXxQWbAjQBJcfSphtomnghNwi9iYY"
				];
				shell = pkgs.scponly;
			};
		};
		groups.nezzy = {};
	};

	programs.fish.enable = true;
	system.stateVersion = "25.05";
	hardware.enableRedistributableFirmware = true;
	time.timeZone = "America/New_York";

	networking.hostName = "vista";
	networking.useDHCP = true;

	boot = {
		kernelParams = [ "net.ifnames=0" ];
		loader.grub = {
			device = "nodev";
			efiSupport = true;
			efiInstallAsRemovable = true;
		};
		kernelPackages = pkgs.linuxPackages_latest;
	};

	security.sudo = {
		enable = true;
		wheelNeedsPassword = false;
	};

  age.secrets.tailscale.file = ../../secrets/tailscale.age;
	services = {
		fail2ban.enable = true;
		tailscale = {
			enable = true;
			authKeyFile = config.age.secrets.tailscale.path;
			extraUpFlags = [
				"--login-server=https://headscale.cstring.dev"
			];
		};
	};
}
