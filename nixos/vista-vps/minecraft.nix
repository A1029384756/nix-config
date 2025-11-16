{ pkgs
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
        white-list = true;
      };

      whitelist = {
        Boundingfeather = "50306b88-5a3f-4baa-bf38-ebc76ac0c446";
        Nexington = "03b60a06-c99d-4dd5-9c0d-085eec84e385";
        Thag_Iceman = "e44015ef-b47b-4537-a4ca-b5f8700f953f";
        Lucazoyde = "4512d4a7-d7d3-4e55-834b-41645445228f";
        Zigg13 = "a1ee0013-ec6b-499a-8ca1-b16f0da67009";
        Brennzzz = "5f9bb967-746c-4a56-89d0-431c01936adb";
      };

      jvmOpts = "-Xms4092M -Xmx4092M";
      package = pkgs.papermcServers.papermc-1_21_8;

      symlinks = {
        "server-icon.png" = ./minecraft_assets/server-icon.png;
      };
    };
  };
}
