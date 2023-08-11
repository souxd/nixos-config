{ config, pkgs, lib, ... }:

{
  imports = [ ./mods.nix ];

  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  # try the new i915 changes before using the patch again
  # boot.kernelPatches = [  ];
}
