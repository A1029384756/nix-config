{ config, lib, pkgs, ... }:
let
	stateDir = "/var/lib/forgejo-runner";

	configTemplate = (pkgs.formats.yaml { }).generate "config.yaml" {
		server.connections.forgejo = {
			url = "https://git.cstring.dev/";
			uuid = "34dc6722-e7d8-4d47-b870-65e0c688b53a";
			token = "@TOKEN@";
		};
		runner = {
			capacity = 4;
			labels = [ "macos:host" ];
		};
	};
in {
	age.secrets.forgejo-runner = {
		file = ../../secrets/forgejo-runner-minibubbles.age;
		owner = "forgejo-runner";
		group = "forgejo-runner";
		mode = "0400";
	};

	users.knownUsers = [ "forgejo-runner" ];
	users.knownGroups = [ "forgejo-runner" ];
	users.groups.forgejo-runner.gid = 535;
	users.users.forgejo-runner = {
		uid = 535;
		gid = 535;
		home = stateDir;
		createHome = true;
		shell = "/bin/bash";
		isHidden = true;
	};

	launchd.daemons.forgejo-runner = {
		path = [
			"/nix/var/nix/profiles/default"
		] ++ (with pkgs; [
				nodejs bash coreutils curl gawk gitMinimal gnused wget 
			]);
		environment.HOME = stateDir;
		script = ''
			umask 077
			sed "s|@TOKEN@|$(cat ${config.age.secrets.forgejo-runner.path})|" \
			${configTemplate} > ${stateDir}/config.yaml
			exec ${lib.getExe pkgs.forgejo-runner} daemon --config ${stateDir}/config.yaml
		'';
		serviceConfig = {
			UserName = "forgejo-runner";
			GroupName = "forgejo-runner";
			WorkingDirectory = stateDir;
			RunAtLoad = true;
			KeepAlive.SuccessfulExit = false;
			ThrottleInterval = 2;
			StandardOutPath = "/var/lib/forgejo-runner/runner.log";
			StandardErrorPath = "/var/lib/forgejo-runner/runner.log";
		};
	};
}
