{config, pkgs, callPackage, ... }:
{
# ...

  services.emacs.package = with pkgs; ((emacsPackagesFor emacsPgtkNativeComp).emacsWithPackages (epkgs: [ epkgs.vterm ]));
  services.emacs.enable = true;

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/mjlbach/emacs-overlay/archive/feature/flakes.tar.gz;
      sha256 = "09sisjgraj2646qz7bczndzll2w59cwf0bsx5az677vb71xba3fx";
    }))
  ];

# ...
}
