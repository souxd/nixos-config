{config, pkgs, callPackage, ... }:
{
# ...

  services.emacs.package = pkgs.emacsPgtkNativeComp;
  services.emacs.enable = true;

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
      sha256 = "0mf3z217gczpj4yqzcshpyzb54q3gxv3mqaf0na28zmd69r0nmvz";
    }))
  ];

# ...
}
