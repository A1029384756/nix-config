{ inputs, pkgs, ... }: {
  services.caddy.virtualHosts."cstring.dev".extraConfig = ''
		root * ${inputs.blog.packages.${pkgs.stdenv.hostPlatform.system}.blog}
		file_server
  '';
}
