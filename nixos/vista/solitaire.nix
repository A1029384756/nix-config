{ inputs, pkgs, ... }: {
  services.caddy.virtualHosts."cstring.dev".extraConfig = ''
		handle_path /solitaire/* {
			root * ${inputs.solitaire.packages.${pkgs.stdenv.hostPlatform.system}.solitaire}
			file_server
		}
  '';
}
