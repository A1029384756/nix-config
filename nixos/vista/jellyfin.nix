{ user, pkgs, lib, config, ... }:
let
  jellyfinDir = "/mnt/data/jellyfin";
  jellyfin-ffmpeg-overlay = (final: prev: {
    jellyfin-ffmpeg = prev.jellyfin-ffmpeg.override {
      ffmpeg_7-full = prev.ffmpeg_7-full.override {
        withMfx = false;
        withVpl = true;
        withUnfree = true;
      };
    };
  });
in
{
  nixpkgs.overlays = [ jellyfin-ffmpeg-overlay ];
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };
  hardware = {
    enableAllFirmware = true;
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-compute-runtime
        vpl-gpu-rt
      ];
    };
  };
  services.jellyfin = {
    inherit user;
    enable = true;
    openFirewall = true;
    logDir = "${jellyfinDir}/log";
    dataDir = "${jellyfinDir}/data";
    cacheDir = "${jellyfinDir}/cache";
  };
  services.caddy.virtualHosts."jellyfin.cstring.dev".extraConfig = ''
    reverse_proxy localhost:8096
  '';
}
