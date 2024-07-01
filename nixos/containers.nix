{ user, pkgs, ... }:
{
  users.extraGroups.docker.members = [ user ];
  hardware.nvidia-container-toolkit.enable = true;

  virtualisation = {
    containers.enable = true;
    docker = {
      enable = true;
      enableNvidia = true;
    };
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  environment.systemPackages = with pkgs; [
    dive
    podman-tui
    docker-compose
    podman-compose
  ];
}
