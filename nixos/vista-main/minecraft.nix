{ inputs
, pkgs
, ...
}: {
  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;

    servers.frennz = {
      enable = true;
      enableReload = true;

      serverProperties = {
        motd = "NOT sponsored by nezcorp";
        difficulty = 2;
        gamemode = "survival";
      };

      jvmOpts = "-Xms4092M -Xmx4092M";
      package = pkgs.papermcServers.papermc-1_21_4;

      symlinks = {
        "server-icon.png" = ./minecraft_assets/server-icon.png;
      };
    };
  };
}
