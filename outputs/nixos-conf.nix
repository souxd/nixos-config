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
      inputs.nix-ld.nixosModules.nix-ld
      inputs.sops-nix.nixosModules.sops
      ../system/hosts/damnix/default.nix
    ];
  };
}
