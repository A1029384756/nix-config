{
  disko.devices.disk.os = {
    device = "/dev/disk/by-id/nvme-Samsung_SSD_990_EVO_2TB_S7M4NL0Y507519T";
    type = "disk";
    content = {
      type = "gpt";
      partitions = {
        ESP = {
          priority = 1;
          name = "ESP";
          start = "1M";
          end = "512M";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [ "umask=0077" ];
          };
        };
        root = {
          size = "100%";
          content = {
            type = "btrfs";
            extraArgs = [ "-f" ];
            subvolumes = {
              "/@root" = {
                mountOptions = [
                  "defaults"
                  "compress=zstd"
                  "noatime"
                ];
                mountpoint = "/";
              };
              "/@home" = {
                mountOptions = [
                  "defaults"
                  "compress=zstd"
                  "noatime"
                ];
                mountpoint = "/home";
              };
              "/@nix" = {
                mountOptions = [
                  "defaults"
                  "compress=zstd"
                  "noatime"
                ];
                mountpoint = "/nix";
              };
              "/@swap" = {
                mountpoint = "/.swapvol";
                swap = {
                  swapfile.size = "20M";
                };
              };
              "/@snapshots" = { };
            };

            mountpoint = "/partition-root";
          };
        };
      };
    };
  };
}