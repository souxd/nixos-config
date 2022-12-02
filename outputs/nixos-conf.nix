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
      ../system/host/damnix/default.nix
      {
        environment.etc."nix/inputs/nixpkgs".source = inputs.nixpkgs.outPath;
        nix.nixPath = [ "nixpkgs=/etc/nix/inputs/nixpkgs" ];
        nix.registry.nixpkgs.flake = inputs.nixpkgs;
        environment.systemPackages = with pkgs; with inputs.nix-alien.packages.${system}; [
          nix-alien
          nix-index # not necessary, but recommended
          nix-index-update
        ];
      }
    ];
  };
}
