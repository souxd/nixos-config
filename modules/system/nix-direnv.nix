# using HM, these options are here for
# protecting nix-shell from garbage collection
{ config, ... }:

{
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';
}
