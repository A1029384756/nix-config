{ inputs, config, ... }:
let
  basepath = "/wedding";
in
{
  services.caddy.virtualHosts."cstring.dev".extraConfig = ''
    handle ${basepath}* {
      reverse_proxy 192.168.101.11:8000
    }
  '';

  containers.wedding = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.101.10";
    localAddress = "192.168.101.11";
    bindMounts."/etc/ssh/ssh_host_ed25519_key".isReadOnly = true;

    config = { config, lib, pkgs, ... }: {
      imports = [ inputs.agenix.nixosModules.default ];
      age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      age.secrets.wedding_site.file = ../../secrets/wedding_site.age;

      nixpkgs.config.allowUnfree = true;

      environment = {
        etc."wedding/site".source = inputs.wedding;
      };

      systemd.services.wedding = {
        enable = true;
        environment.BASE_PATH = basepath;
        script = ''
          cp -r /etc/wedding/site/* /root
          cd /root

          ${pkgs.lib.getExe pkgs.deno} task preview
        '';
        serviceConfig.EnvironmentFile = config.age.secrets.wedding_site.path;
        wantedBy = [ "multi-user.target" ];
      };

      services.mongodb = {
        enable = true;
        package = pkgs.mongodb-ce;
      };

      networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 8000 ];
      };

      system.stateVersion = "24.11";
    };
  };
}
