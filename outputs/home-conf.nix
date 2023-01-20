{ inputs, system, ... }:

with inputs;

let
  pkgs = nixpkgs.legacyPackages.${system};
  pkg-config = { inherit system; config.allowUnfreePredicate = _: true; };
  stable = import stablepkgs pkg-config;
  nur = import nurpkgs {
    inherit pkgs;
    nurpkgs = pkgs;
  };

  imports = [ ../home/souxd/default.nix nix-doom-emacs.hmModule ];

  mkHome = home-manager.lib.homeManagerConfiguration rec {
    inherit pkgs;
    inherit system;
    stateVersion = "22.05";
    username = "souxd";
    homeDirectory = "/home/souxd";
    configuration = {
      xdg.configFile."nix/inputs/nixpkgs".source = nixpkgs.outPath;
      nix.registry.nixpkgs.flake = nixpkgs;
      nixpkgs.config.allowUnfreePredicate = _: true; # workaround for https://github.com/nix-community/home-manager/issues/2942
      nixpkgs.config.permittedInsecurePackages = [
        "python-2.7.18.6"
      ];
      nixpkgs.overlays = [ nurpkgs.overlay emacs-overlay.overlay ];
    };
    extraSpecialArgs = {
      inherit stable;
      souxd = nur.repos.souxd;
      ff-addons = nur.repos.rycee.firefox-addons;
      gaming = nix-gaming;
    };
    extraModules = [{ inherit imports; }];
  };

in
{
  souxd = mkHome;
}
