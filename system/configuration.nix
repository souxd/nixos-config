{ config, ... }:

{
  imports =
    (map (p: ../modules/system + p) [
      /essentials.nix
      /nix-direnv.nix
      /cachix/cachix.nix
      /locale.nix
    ]);

  system.stateVersion = "22.05";
}
