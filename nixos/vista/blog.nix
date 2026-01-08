{ inputs, pkgs, ... }:
{
  services.caddy.virtualHosts."cstring.dev".extraConfig = ''
		root * ${inputs.blog.packages.${pkgs.system}.blog}
		file_server
  '';
}
