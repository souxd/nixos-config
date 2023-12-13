{ lib
, stdenv
, callPackage
, fetchFromGitHub
, cmake
, pkg-config
, makeWrapper
, SDL2
, SDL2_mixer
, wxGTK32
, zlib
, libpng
, curl
, alsa-lib
}:

let
  deutex = callPackage ./deutex.nix {};
in
stdenv.mkDerivation rec {
  pname = "odamex";
  version = "10.4.0";

  src = fetchFromGitHub {
    owner = "${pname}";
    repo = "${pname}";
    rev = "${version}";
    hash = "sha256-4mXm1D78cKt9S4h937l/nNX+ruMl0Rqoz4uiRdJP3C4=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    cmake
    pkg-config
    makeWrapper
  ];

  buildInputs = [
    SDL2
    SDL2_mixer
    wxGTK32
    deutex
    zlib
    libpng
    curl
    alsa-lib
  ];

  installPhase = ''
    runHook preInstall
  '' + (if stdenv.isDarwin then ''
    mkdir -p $out/{Applications,bin}
    mv odalaunch/odalaunch.app $out/Applications
    makeWrapper $out/{Applications/odalaunch.app/Contents/MacOS,bin}/odalaunch
  '' else ''
    make install
  '') + ''
    runHook postInstall
  '';

  meta = {
    homepage = "http://odamex.net/";
    description = "A client/server port for playing old-school Doom online";
    license = lib.licenses.gpl2Only;
    platforms = lib.platforms.unix;
  };
}
