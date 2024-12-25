{ inputs, pkgs, ... }:
{
  services.caddy.virtualHosts."cstring.dev".extraConfig = ''
    reverse_proxy 192.168.101.13:8000
  '';

  containers.blog = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.101.12";
    localAddress = "192.168.101.13";

    config = {
      environment = {
        etc."lume/blog".source = inputs.blog;
      };

      systemd.services.lume = {
        enable = true;
        environment.LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
        script = ''
          cp -r /etc/lume/blog/* /root
          cd /root
          ${pkgs.lib.getExe pkgs.deno} task build
          ${pkgs.lib.getExe pkgs.deno} run -A ./server.ts
        '';
        wantedBy = [ "multi-user.target" ];
      };

      networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 8000 ];
      };

      system.stateVersion = "24.11";
    };
  };
}
