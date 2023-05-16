{ config, pkgs, inputs, ... }:

{
  nixpkgs = {
    overlays = [
      (self: super: {
        linuxZenWMuQSS = pkgs.linuxPackagesFor (pkgs.linux_latest.override {
          structuredExtraConfig = with lib.kernel; {
            SCHED_MUQSS = yes;
          };
          ignoreConfigErrors = true;
        });
      })
    ];
  };
}
