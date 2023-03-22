# choose driver, kernel mods, apply patches etc
{ config, ... }:

{
  environment.variables = { MESA_LOADER_DRIVER_OVERRIDE = "crocus"; };

  boot = {
    kernelModules = [ "bfq" "zstd" "z3fold" ];
    kernelPatches = [
      { name = "intel-gfx_memleak_fix"; patch = ./Possible-regression-in-drm-i915-driver-memleak.patch; }
    ];
  };

  systemd.services.bfq = {
    description = "set scheduler to BFQ";
    enable = true;
    wantedBy = [ "basic.target" ];
    path = [ pkgs.bash ];
    serviceConfig = {
      ExecStart = ''${pkgs.bash}/bin/bash -c 
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
      ExecStart = ''${pkgs.bash}/bin/bash -c 
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
