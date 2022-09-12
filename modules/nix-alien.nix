{ pkgs, ... }:

let
  nix-alien-pkgs = import (
    fetchTarball {
      url = "https://github.com/thiagokokada/nix-alien/tarball/master";
      sha256 = "0kp2m1kx9i4ndh5xi37zcacijx3j6zw6jwdqh32l9fmxdafifisj";
  }) { };
in
{

  environment.systemPackages = with nix-alien-pkgs; [
    nix-alien
    nix-index-update
    pkgs.nix-index # not necessary, but recommended
  ];
}
