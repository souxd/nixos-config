{ inputs, system, ... }:

let
  nixosSystem = inputs.stablepkgs.lib.nixosSystem;
in
{
  damnix = nixosSystem rec {
    inherit system;
    specialArgs = { inherit inputs; };
    modules = [
      inputs.hyprland.nixosModules.default
      ../hosts/damnix/configuration.nix
      {
        environment.etc."nix/inputs/nixpkgs".source = inputs.nixpkgs.outPath;
        nix.nixPath = [ "nixpkgs=/etc/nix/inputs/nixpkgs" ];
        nix.registry.nixpkgs.flake = inputs.nixpkgs;
      }
    ];
  };
}
