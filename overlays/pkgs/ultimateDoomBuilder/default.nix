{ stdenv
, lib
, callPackage
, fetchFromGitHub
, makeWrapper
, msbuild
, mono
, libGL
, libpng
, libX11
, gtk2-x11
}:

let
  # TODO: package acs and bcs libs
  # zonebuilder and BCS compiler
  zdbsp = callPackage ./zdbsp.nix {};
  zt-bcc = callPackage ./zt-bcc.nix {};
in
stdenv.mkDerivation rec {
  pname = "UltimateDoomBuilder";
  version = "2023-12-15T23";

  src = fetchFromGitHub {
    owner = "jewalky";
    repo = pname;
    rev = "39be7a722c7beca1a2bb8f52222a14db43f6cf97";
    hash = "sha256-o1YVPQiIAyItCOqHo3LXxrsH37L0mDxOkpD48tLc+BM=";
  };


  # https://github.com/jewalky/UltimateDoomBuilder/issues/846
  patches = [ ./fix_folderdialog_crash.patch ];

  nativeBuildInputs = [ msbuild makeWrapper ];

  buildInputs = [
    libGL
    libpng
    libX11
    gtk2-x11
  ];
  
  buildPhase = ''
    runHook preBuild

    # Won't compile without windows codepage identifier for UTF-8

    msbuild /nologo /verbosity:minimal -p:Configuration=Release /p:codepage=65001 ./BuilderMono.sln
    cp builder.sh Build/builder
    chmod +x Build/builder
    g++ -std=c++14 -O2 --shared -g3 -o Build/libBuilderNative.so -fPIC -I Source/Native Source/Native/*.cpp Source/Native/OpenGL/*.cpp Source/Native/OpenGL/gl_load/*.c -lX11 -ldl
    runHook postBuild
  '';

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/opt

    cp -r Build $out/opt/UltimateDoomBuilder

    substituteInPlace $out/opt/UltimateDoomBuilder/builder --replace mono ${mono}/bin/mono
    substituteInPlace $out/opt/UltimateDoomBuilder/builder --replace Builder.exe $out/opt/UltimateDoomBuilder/Builder.exe
    substituteInPlace $out/opt/UltimateDoomBuilder/Compilers/Nodebuilders/zdbsp.cfg --replace zdbsp.exe ${zdbsp}/bin/zdbsp
    substituteInPlace $out/opt/UltimateDoomBuilder/Compilers/BCC/bcc.cfg --replace bcc.exe ${zt-bcc}/bin/zt-bcc

    wrapProgram $out/opt/UltimateDoomBuilder/builder \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [ gtk2-x11 libGL libpng libX11 ]}"

    ln -s $out/opt/UltimateDoomBuilder/builder $out/bin/builder
  '';
}
