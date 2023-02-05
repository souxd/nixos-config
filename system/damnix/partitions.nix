# use in the next partitioning
{ config, ... }:

{
  disko.devices = {
    disk.sda = {
      device = "/dev/sda";
      type = "disk";
      content = {
        type = "table";
        format = "gpt";
        partitions = [
          {
            type = "partition";
            name = "boot";
            start = "1MiB";
            end = "400MiB";
            part-type = "primary";
            flags = [ "bios_grub" ];
            bootable = true;
            content = {
              type = "filesystem";
              format = "ext2";
              mountpoint = "/boot";
            };
          }
          {
            type = "partition";
            name = "nixos";
            start = "400MiB";
            end = "100%";
            part-type = "primary";
            bootable = true;
            content = {
              type = "btrfs";
              extraArgs = "-f"; # Override existing partition
              subvolumes = {
                # Subvolume name is different from mountpoint
                "/root" = {
                  mountpoint = "/";
                };
                # Mountpoints inferred from subvolume name
                "/home" = {
                  mountOptions = [ "compress=zstd" ];
                };
                "/nix" = {
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "/swap" = {
                  mountOptions = [ "noatime" ];
                };
              };
            };
          }
        ];
      };
    };
  };
}
