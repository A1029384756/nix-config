{ inputs
, pkgs
, ...
}: {
  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;

    # saved in /srv/minecraft/frennz
    servers.frennz = {
      enable = true;
      enableReload = true;

      serverProperties = {
        motd = "NOT sponsored by nezcorp";
        difficulty = 2;
        gamemode = "survival";
        level-name = "ZeroFrennzWorld";
      };

      jvmOpts = "-Xms4092M -Xmx4092M";
      package = pkgs.papermcServers.papermc-1_21_5;

      symlinks = {
        "server-icon.png" = ./minecraft_assets/server-icon.png;
      };
    };
  };
}
