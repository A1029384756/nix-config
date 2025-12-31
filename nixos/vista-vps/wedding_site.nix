{ inputs, ... }:
let
  basepath = "/wedding";
  containerPort = 8000;
in
{
  networking.firewall.allowedTCPPorts = [ containerPort ];
  containers.wedding = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.101.10";
    localAddress = "192.168.101.11";
    forwardPorts = [
      {
        containerPort = containerPort;
        hostPort = containerPort;
      }
    ];
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
        allowedTCPPorts = [ containerPort ];
      };

      system.stateVersion = "24.11";
    };
  };
}
