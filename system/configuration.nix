{ config, ... }:

{
  imports =
    [
      ./modules/essentials.nix
      ./modules/nix-direnv.nix
      ./modules/cachix/cachix.nix
      ./modules/locale.nix
    ];

  system.stateVersion = "22.05";
}
