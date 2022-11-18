{ inputs, system, ... }:

with inputs;

let
  pkg-config = { inherit system; config.allowUnfree = true; };
  pkgs = import nixpkgs { inherit pkg-config; };
  stable = import stablepkgs { inherit pkg-config; };
  trunk = import trunkpkgs { inherit pkg-config; };
  nur = import nurpkgs { inherit pkg-config; };

  homeConfig = home-manager.lib.homeManagerConfiguration;
in
{
  souxd = homeConfig {
    inherit pkgs;
    inherit system;
    stateVersion = "22.05";
    username = "souxd";
    homeDirectory = "/home/souxd";
    configuration = {
      imports = [ ../users/souxd/home.nix nix-doom-emacs.hmModule ];
      xdg.configFile."nix/inputs/nixpkgs".source = nixpkgs.outPath;
      nix.registry.nixpkgs.flake = nixpkgs;
    };
    extraSpecialArgs = { inherit stable; inherit trunk; inherit nur; };
  };
}
