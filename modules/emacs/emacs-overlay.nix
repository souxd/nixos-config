{config, pkgs, callPackage, ... }:
{

  services.emacs.package = with pkgs; ((emacsPackagesFor emacsPgtkNativeComp).emacsWithPackages (epkgs: [ epkgs.vterm epkgs.lisp-local ]));
  services.emacs.enable = true;

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
      sha256 = "0pqnnn513jd9ywkxhxwvhrkw4havykn8wk8pwx9xq92iwpjgc0lx";
    }))
  ];

}
