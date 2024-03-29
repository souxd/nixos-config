{ stdenv
, lib
, fetchurl
, autoPatchelfHook
, makeWrapper
, callPackage
, soundfont-fluid
, SDL_compat
, libGL
, glew
, bzip2
, zlib
, libjpeg
, fluidsynth
, fmodex
, openssl
, gtk2
, game-music-emu
}:

let
  fmod = fmodex; # fmodex is on nixpkgs now
  sqlite = callPackage ./sqlite.nix { };
  clientLibPath = lib.makeLibraryPath [ fluidsynth ];
  olibjpeg = (libjpeg.override { enableJpeg8 = true; });

in
stdenv.mkDerivation rec {
  pname = "zandronum-alpha-bin";
  version = "3.2-230709-1914";

  src = fetchurl {
    url = "https://zandronum.com/downloads/testing/3.2/ZandroDev3.2-230709-1914linux-x86_64.tar.bz2";
    hash = "sha256-G0FAAZy2ofG7BrmKnYs4uuRgr2hyWt4BUEH928sinxI=";
  };

  # Work around the "unpacker appears to have produced no directories"
  # case that happens when the archive doesn't have a subdirectory.
  setSourceRoot = "sourceRoot=`pwd`";

  # I have no idea why would SDL and libjpeg be needed for the server part!
  # But they are.
  # RE: libjpeg idk, but SDL provides many low-level OS abstractions other than just video and audio, timing is probably the notable one
  buildInputs = [ openssl bzip2 zlib SDL_compat olibjpeg sqlite game-music-emu libGL glew fmod fluidsynth gtk2 ];

  nativeBuildInputs = [ autoPatchelfHook makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/lib/zandronum
    cp * \
       $out/lib/zandronum
    rm $out/lib/zandronum/env-vars
    makeWrapper $out/lib/zandronum/zandronum-server $out/bin/zandronum-alpha-server
    makeWrapper $out/lib/zandronum/zandronum $out/bin/zandronum-alpha
    wrapProgram $out/bin/zandronum-alpha-server \
      --set LC_ALL="C"
    wrapProgram $out/bin/zandronum-alpha \
      --set LC_ALL"C"
  '';

  postFixup = ''
    patchelf --replace-needed libjpeg.so.8 libjpeg.so \
      --set-rpath $(patchelf --print-rpath $out/lib/zandronum/zandronum):$out/lib/zandronum:${clientLibPath} \
      $out/lib/zandronum/{zandronum,zandronum-server}
  '';

  passthru = {
    inherit fmod sqlite;
  };

  meta = with lib; {
    homepage = "https://zandronum.com/";
    description = "Multiplayer oriented port, based off Skulltag, for Doom and Doom II by id Software";
    license = licenses.unfreeRedistributable;
    platforms = platforms.linux;
  };
}
