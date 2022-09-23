{config, pkgs, callPackage, ... }:
{

  services.emacs.package = with pkgs; ((emacsPackagesFor emacsPgtkNativeComp).emacsWithPackages (epkgs: [ epkgs.evil epkgs.vterm epkgs.lisp-local ]));
  services.emacs.enable = true;

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
      sha256 = "1994k879wa21kmkxidmckjl7hd7xaicm30c9f81y4fvrhw5632vb";
    }))
  ];

}
