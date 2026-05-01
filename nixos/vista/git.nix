{ config, lib, pkgs, ... }:
let
	host = "git.cstring.dev";
	stateDir = "/mnt/data/forgejo";
	sshPort = lib.head config.services.openssh.ports;
	httpPort = 3000;
in
{
	services.caddy.virtualHosts.${host}.extraConfig = ''
		reverse_proxy localhost:${toString httpPort}
	'';

	age.secrets.forgejo-mail.file = ../../secrets/forgejo-mail.age;

	services.postgresql = {
		enable = true;
		ensureDatabases = [ "forgejo" ];
		ensureUsers = [{
			name = "forgejo";
			ensureDBOwnership = true;
		}];
	};

	services.postgresqlBackup = {
		enable = true;
		databases = [ "forgejo" ];
		location = "${stateDir}/pgbackup";
	};

	services.forgejo = {
		enable = true;
		stateDir = stateDir;
		lfs.enable = true;
		database = {
			type = "postgres";
			socket = "/run/postgresql";
		};
		secrets.mailer.PASSWD = config.age.secrets.forgejo-mail.path;
		settings = {
			server = {
				DOMAIN = host;
				ROOT_URL = "https://${host}";
				HTTP_PORT = httpPort;
				SSH_PORT = sshPort;
			};
			service = {
				DISABLE_REGISTRATION = true;
				ENABLE_BASIC_AUTHENTICATION = false;
				ENABLE_INTERNAL_SIGNIN = false;
				ENABLE_NOTIFY_MAIL = true;
			};
			oauth2_client = {
				UPDATE_AVATAR = true;
			};
			mailer = {
				ENABLED = true;
				PROTOCOL = "smtp+starttls";
				SMTP_ADDR = "mail.cstring.dev";
				SMTP_PORT = 587;
				USER = "git@cstring.dev";
				FROM = "Forgejo <git@cstring.dev>";
			};
			actions.ENABLED = true;
		};
	};

	age.secrets.forgejo-runner.file = ../../secrets/forgejo-runner-vista.age;
	systemd.services.forgejo-runner = let 
		configFile = (pkgs.formats.yaml { }).generate "config.yaml" {
			runner.capacity = 2;
			container = {
				network = "host";
				enable_ipv6 = true;
			};
		};
	in {
		after = [ "network-online.target" "podman.service" ];
		wants = [ "network-online.target" ];
		wantedBy = [ "multi-user.target" ];
		environment = {
			DOCKER_HOST = "unix:///run/podman/podman.sock";
			HOME = "/var/lib/forgejo-runner/default";
		};
		path = with pkgs; [
			nodejs
			buildah
			fuse-overlayfs
			bash
			coreutils
			curl
			gawk
			gitMinimal
			gnused
			wget
		];
		serviceConfig = {
			DynamicUser = true;
			User = "forgejo-runner";
			StateDirectory = "forgejo-runner";
			WorkingDirectory = "-/var/lib/forgejo-runner/default";
			Restart = "on-failure";
			RestartSec = 2;
			LoadCredential = [ "token:${config.age.secrets.forgejo-runner.path}" ];
			ExecStart = ''
				${lib.getExe pkgs.forgejo-runner} daemon \
				--url https://${host} \
				--uuid c6dac328-1a46-4500-9198-cb899ac58328 \
				--token-url file://%d/token \
				--label node-lts:docker://node:lts \
				--config ${configFile}
			'';
			SupplementaryGroups = [ "podman" ];
		};
	};
}
