{ inputs, system, ... }:

let
  nixosSystem = inputs.nixpkgs.lib.nixosSystem;
  pkgs = inputs.nixpkgs.legacyPackages.${system};
  pkg-config = { inherit system; config.allowUnfreePredicate = _: true; };
  stable = import inputs.stablepkgs pkg-config;
in
{
  damnix = nixosSystem rec {
    inherit system;
    specialArgs = { inherit inputs; inherit stable; };
    modules = [
      inputs.disko.nixosModules.disko
      # inputs.sops-nix.nixosModules.sops
      ../nixos/damnix/default.nix
    ];
  };
}
