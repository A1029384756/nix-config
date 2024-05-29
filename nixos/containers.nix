{ user, pkgs, ... }: {
  users.extraGroups.docker.members = [ user ];
  virtualisation.containers.enable = true;
  virtualisation = {
    docker.enable = true;
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
