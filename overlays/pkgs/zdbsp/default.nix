{ lib
, stdenv
, fetchFromGitHub
, cmake
, zlib
}:

stdenv.mkDerivation rec {
  pname = "zdbsp";
  version = "v1.19";

  src = fetchFromGitHub {
    owner = "rheit";
    repo = pname;
    rev = version;
    hash = "sha256-G5ohIn4XAF92G8BbstUEMMZ3SSDNpww9B47ZlRUr/bs=";
  };

    nativeBuildInputs = [ cmake ];

    buildInputs = [ zlib ];

    installPhase = ''
    runHook preinstall
    install -D zdbsp $out/bin/zdbsp
    runHook postInstall
    '';
}
