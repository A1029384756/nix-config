{ pkgs, utils, ... }:
let
  # Set to {id}-{branch}-{password} for betas.
  steam-app = "896660";
in
{
  imports = [
    ./steam.nix
  ];

  users.users.valheim = {
    isSystemUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC/ZbPqfUBjnhwW859snOnvqmuvaVtfNq5kuSpn/zOmV haydengray@fedora"
    ];
    # Valheim puts save data in the home directory.
    home = "/var/lib/valheim";
    createHome = true;
    homeMode = "755";
    group = "valheim";
  };

  users.groups.valheim = { };

  systemd.services.valheim = {
    wantedBy = [ "multi-user.target" ];

    # Install the game before launching.
    wants = [ "steam@${steam-app}.service" ];
    after = [ "steam@${steam-app}.service" ];

    serviceConfig = {
      ExecStart = utils.escapeSystemdExecArgs [
        "/var/lib/steam-app-${steam-app}/valheim_server.x86_64"
        "-nographics"
        "-batchmode"
        # "-crossplay"
        "-savedir"
        "/var/lib/valheim/save"
        "-name"
        "Frennz"
        "-port"
        "2456"
        "-world"
        "World13769"
        "-password"
        "frennz"
        "-public"
        "0"
      ];
      Nice = "-5";
      PrivateTmp = true;
      Restart = "always";
      User = "valheim";
      WorkingDirectory = "~";
    };
    environment = {
      # linux64 directory is required by Valheim.
      LD_LIBRARY_PATH = "/var/lib/steam-app-${steam-app}/linux64:${pkgs.libz}/lib:${pkgs.glibc}/lib";
      SteamAppId = "892970";
    };
  };
}
