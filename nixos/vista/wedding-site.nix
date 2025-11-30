{
  services.caddy.virtualHosts."cstring.dev".extraConfig = ''
    handle /wedding* {
    	reverse_proxy	178.156.145.85:8000
    }
  '';
}
