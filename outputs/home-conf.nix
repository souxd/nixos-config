{ inputs, system, ... }:

with inputs;

let
  pkgs = nixpkgs.legacyPackages.${system};
  pkg-config = { inherit system; config.allowUnfreePredicate = _: true; };
  stable = import stablepkgs pkg-config;
  trunk = import trunkpkgs pkg-config;
  nur = import nurpkgs pkg-config;

  imports = [ ../users/souxd/home.nix nix-doom-emacs.hmModule ];

  mkHome = home-manager.lib.homeManagerConfiguration rec {
    inherit pkgs;
    inherit system;
    stateVersion = "22.05";
    username = "souxd";
    homeDirectory = "/home/souxd";
    configuration = {
      xdg.configFile."nix/inputs/nixpkgs".source = nixpkgs.outPath;
      nix.registry.nixpkgs.flake = nixpkgs;
    };
    extraSpecialArgs = { inherit stable; inherit trunk; inherit nur; };
    extraModules = [{ inherit imports; }];
  };
in
{
  souxd = mkHome;
}
