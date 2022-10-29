{ pkgs, config, lib, ... }:
# based on Znewman's nix-doom-emacs config
# https://github.com/znewman01/dotfiles/blob/master/emacs/default.nix
{
  programs.doom-emacs = rec {
    enable = true;
    emacsPackage = pkgs.emacsNativeComp;
    doomPrivateDir = (import ./doom.d) {
      inherit lib;
      inherit (pkgs) stdenv emacs coreutils;
    };
    # Only init/packages so we only rebuild when those change.
    doomPackageDir =
      let
        filteredPath = builtins.path {
          path = doomPrivateDir;
          name = "doom-private-dir-filtered";
          filter = path: type:
            builtins.elem (baseNameOf path) [ "init.el" "packages.el" ];
        };
      in
      pkgs.linkFarm "doom-packages-dir" [
        {
          name = "init.el";
          path = "${filteredPath}/init.el";
        }
        {
          name = "packages.el";
          path = "${filteredPath}/packages.el";
        }
        {
          name = "config.el";
          path = pkgs.emptyFile;
        }
        {
          name = "misc";
          path = pkgs.emptyDirectory;
        }
      ];
  };

  services.emacs = { enable = true; };
  home.packages = with pkgs; [
    python311
    emacs-all-the-icons-fonts
    ispell
    mu
    offlineimap
    gdb
    rnix-lsp
    graphviz
  ];
}
