{config, pkgs, callPackage, ... }:
{

services.emacs.package = with pkgs; ((emacsPackagesFor emacsPgtkNativeComp).emacsWithPackages (epkgs: [ epkgs.vterm ]));

#  services.emacs.package = with pkgs; ((emacsPackagesFor emacsPgtkNativeComp).emacsWithPackages (epkgs: [ epkgs.vterm ]));
  services.emacs.enable = true;

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/mjlbach/emacs-overlay/archive/feature/flakes.tar.gz;
      sha256 = "0is88mgplvd344hv7dh8qpc7ya1qw0ilms0rahgni0a9bkpxp275";
    }))
  ];

}
