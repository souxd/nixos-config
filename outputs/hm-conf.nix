{ inputs, system, ... }:

with inputs;

let
  pkgConfig = { inherit system; config.allowUnfreePredicate = _: true; };
  pkgs = nixpkgs.legacyPackages.${system};
  stable = import stablepkgs pkgConfig;
  nur = import nurpkgs {
  inherit pkgs;
  nurpkgs = pkgs ;
  };

  mkHome = home-manager.lib.homeManagerConfiguration rec {
    inherit pkgs;
    modules = [
      hyprland.homeManagerModules.default
      # nix-doom-emacs.hmModule
      ../home-manager/souxd/default.nix
      {
        home = {
          stateVersion = "22.05";
          username = "souxd";
          homeDirectory = "/home/souxd";
        };

        nixpkgs.overlays = [ nurpkgs.overlay emacs-overlay.overlay ];
        nixpkgs.config.allowUnfreePredicate = _: true; # workaround for https://github.com/nix-community/home-manager/issues/2942
        nixpkgs.config.permittedInsecurePackages = [ "python-2.7.18.6" ];
        nix.registry.nixpkgs.flake = nixpkgs;
        xdg.configFile."nix/inputs/nixpkgs".source = nixpkgs.outPath;
      }
    ];
    extraSpecialArgs = {
      inherit inputs;
      inherit stable;
      ff-addons = nur.repos.rycee.firefox-addons;
      souxd = nur.repos.souxd;
    };
  };

in
{
  souxd = mkHome;
}
