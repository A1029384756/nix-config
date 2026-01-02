let
  btrfsOpts = [
    "compress=zstd"
    "noatime"
    "space_cache=v2"
  ];
in
{
  fileSystems = {
		"/mnt/data" = {
			device = "/dev/sda";
    	fsType = "btrfs";
    	options = btrfsOpts;
		};
		"/mnt/vault" = {
			device = "/dev/sdc";
    	fsType = "btrfs";
    	options = btrfsOpts;
		};
	};

  # this only runs at installation
  disko.devices.disk.os = {
    device = "/dev/disk/by-id/nvme-Samsung_SSD_990_EVO_2TB_S7M4NL0Y507519T";
    type = "disk";
    content = {
      type = "gpt";
      partitions = {
        ESP = {
          label = "boot";
          name = "ESP";
          size = "512M";
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
              "@root" = {
                mountOptions = btrfsOpts;
                mountpoint = "/";
              };
              "@home" = {
                mountOptions = btrfsOpts;
                mountpoint = "/home";
              };
              "@nix" = {
                mountOptions = btrfsOpts;
                mountpoint = "/nix";
              };
              "@swap" = {
                mountpoint = "/.swapvol";
                swap.swapfile.size = "32G";
              };
            };
          };
        };
      };
    };
  };
}
