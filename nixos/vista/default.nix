{ user, pkgs, ... }:
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

	services = {
		fail2ban.enable = true;
		tailscale.enable = true;
	};
}
