# based on Znewman's nix-doom-emacs config
# https://github.com/znewman01/dotfiles/blob/master/emacs/default.nix
{ pkgs, config, lib, ... }:
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
          name = "config.org";
          path = pkgs.emptyFile;
        }
        {
          name = "default.nix";
          path = pkgs.emptyFile;
        }
        {
          name = "env-vars";
          path = pkgs.emptyFile;
        }
        {
          name = "misc";
          path = pkgs.emptyDirectory;
        }
      ];
  };

  services.emacs = { enable = true; };
  home.packages = with pkgs;
    # Emacs fonts, email and graph
    [
      emacs-all-the-icons-fonts
      mu
      offlineimap
      graphviz
    ] ++
    # Grammar
    [
      languagetool
    ] ++
    # Nix
    [
      nixfmt
      rnix-lsp
    ] ++
    # Shell scripting
    [
      shfmt
      shellcheck
      nodePackages.bash-language-server
      bashdb
    ] ++
    # C/C++
    [
      gcc
      clang-tools
      glslang
      gnumake
      cmake
      gdb
    ] ++
    # Python
    [
      python311
      black
    ];
}
