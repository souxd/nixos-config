{ pkgs, ... }:

let
  nix-alien-pkgs = import (
    fetchTarball "https://github.com/thiagokokada/nix-alien/tarball/master"
  ) { };
in
{
  # Optional, but this is needed for `nix-alien-ld` command
  # See https://github.com/Mic92/nix-ld#installation for how to setup `nix-ld`
  # channel
  imports = [
    <nix-ld/modules/nix-ld.nix>
  ];

  environment.systemPackages = with nix-alien-pkgs; [
    nix-alien
    nix-index-update
    pkgs.nix-index # not necessary, but recommended
  ];
}

