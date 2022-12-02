{ inputs, system, ... }:

let
  nixosSystem = inputs.nixpkgs.lib.nixosSystem;
  pkgs = inputs.nixpkgs.legacyPackages.${system};
in
{
  damnix = nixosSystem rec {
    inherit system;
    specialArgs = { inherit inputs; };
    modules = [
      inputs.sops-nix.nixosModules.sops
      inputs.nix-ld.nixosModules.nix-ld
      ../system/hosts/damnix/default.nix
    ];
  };
}
