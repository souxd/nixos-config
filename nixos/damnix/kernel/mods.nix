# choose driver, kernel mods, apply patches etc
{ lib, config, pkgs, inputs, ... }:

{
  boot = {
    kernelModules = [ "bfq" "zstd" "z3fold" "tcp_bbr" ];
    /*
    kernelPatches = [
      { name = "build_too_high_ram_usage"; patch = null; extraConfig = ''DEBUG_INFO_BTF n''; }
      { name = "intel-gfx_memleak_fix"; patch = ./Possible-regression-in-drm-i915-driver-memleak.patch; }
    ];
    */
    kernel.sysctl = {
      "net.core.default_qdisc" = "fq";
      "net.ipv4.tcp_congestion_control" = "bbr";
      # "vm.swappiness" = 40;
    };
    kernelParams = [
      "mitigations=off"
      "intel_iommu=off"
    ];
  };

  systemd.services.sysrq = {
    description = "enable magic sysrq";
    enable = true;
    wantedBy = [ "basic.target" ];
    path = [ pkgs.bash ];
    serviceConfig = {
      ExecStart = ''${pkgs.bash}/bin/bash -c \
        'cd /proc/sys/kernel && \
        echo 64 > sysrq'
      '';
      Type = "simple";
    };
  };

  systemd.services.bfq = {
    description = "set scheduler to BFQ";
    enable = true;
    wantedBy = [ "basic.target" ];
    path = [ pkgs.bash ];
    serviceConfig = {
      ExecStart = ''${pkgs.bash}/bin/bash -c \
        'cd /sys/block/sda/queue && \
        echo bfq > scheduler'
      '';
      Type = "simple";
    };
  };

  systemd.services.zswap = {
    description = "Enable ZSwap, set to ZSTD and Z3FOLD";
    enable = true;
    wantedBy = [ "basic.target" ];
    path = [ pkgs.bash ];
    serviceConfig = {
      ExecStart = ''${pkgs.bash}/bin/bash -c \
        'cd /sys/module/zswap/parameters && \
        echo 1 > enabled && \
        echo 20 > max_pool_percent && \
        echo zstd > compressor && \
        echo z3fold > zpool'
      '';
      Type = "simple";
    };
  };
}
