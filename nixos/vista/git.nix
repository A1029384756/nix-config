{ config, lib, ... }:
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

	age.secrets.forgejo-oidc.file = ../../secrets/forgejo-oidc.age;
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
				HTTP_ADDR = "0.0.0.0";
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
}
