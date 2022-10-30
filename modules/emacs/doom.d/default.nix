# https://github.com/nix-community/nix-doom-emacs/issues/60#issuecomment-1083630633
{ version ? "dev", lib, stdenv, emacs, coreutils }:

stdenv.mkDerivation {
  pname = "emacs-config";
  inherit version;
  src = builtins.filterSource
    (path: type: type != "regular" || baseNameOf path != ".nix")
    ./.;
  src = ./.;

  buildInputs = [ emacs coreutils ];
  buildPhase = ''
    cp -r $src/* .
    # Tangle org files
    emacs --batch -Q \
      -l org \
      config.org \
      -f org-babel-tangle
  '';

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out
    cp -r -t $out *
    rm *.org env-vars
    chmod 755 *
  '';
}
