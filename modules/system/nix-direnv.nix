{ config, ... }:

{
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';
}
