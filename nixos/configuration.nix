# default settings for all my hosts
{ config, ... }:

{
  imports =
    (map (p: ./modules + p) [
      /essentials.nix
      /nix-direnv.nix
      /cachix/cachix.nix
    ]);

  system.stateVersion = "22.05";
}
