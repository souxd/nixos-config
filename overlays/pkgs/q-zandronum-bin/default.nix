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
# , fluidsynth
# , fmodex
, openssl
, gtk2
, game-music-emu
, sndio
, libsndfile
}:

let
  # fmod = fmodex; # fmodex is on nixpkgs now
  #sqlite = callPackage ./sqlite.nix { };
  # clientLibPath = lib.makeLibraryPath [ fluidsynth ];
  #olibjpeg = (libjpeg.override { enableJpeg8 = true; });

in
stdenv.mkDerivation rec {
  pname = "q-zandronum-bin";
  version = "1.4.11";

  src = fetchurl {
    url = "https://github.com/IgeNiaI/Q-Zandronum/releases/download/1.4.11/Q-Zandronum_${version}_Linux_amd64.tar.gz";
    hash = "sha256-dOLxs5QkNxTwDN+Cy+uRSP9YJNcc1SjwlpJi69Fq+SU=";
  };

  # Work around the "unpacker appears to have produced no directories"
  # case that happens when the archive doesn't have a subdirectory.
  setSourceRoot = "sourceRoot=`pwd`";
  
  # I have no idea why would SDL and libjpeg be needed for the server part!
  # But they are.
  # RE: libjpeg idk, but SDL provides many low-level OS abstractions other than just video and audio, timing is probably the notable one
  buildInputs = [ sndio libsndfile openssl bzip2 zlib SDL_compat libjpeg game-music-emu libGL glew  gtk2 ];

  nativeBuildInputs = [ autoPatchelfHook makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/lib/q-zandronum
    cp -r * \
       $out/lib/q-zandronum
    rm -r $out/lib/q-zandronum/{env-vars,Doomseeker,*.debug}
    makeWrapper $out/lib/q-zandronum/q-zandronum-server $out/bin/q-zandronum-server
    makeWrapper $out/lib/q-zandronum/q-zandronum $out/bin/q-zandronum
    wrapProgram $out/bin/q-zandronum-server \
      --set LC_ALL="C"
    wrapProgram $out/bin/q-zandronum \
      --set LC_ALL"C"
  '';

  /*
  postFixup = ''
    patchelf --replace-needed libjpeg.so.8 libjpeg.so \
      --set-rpath $(patchelf --print-rpath $out/lib/q-zandronum/q-zandronum):$out/lib/q-zandronum:${clientLibPath} \
      $out/lib/q-zandronum/{q-zandronum,q-zandronum-server}
  '';

   passthru = {
    inherit fmod sqlite;
  };
  */

  meta = with lib; {
    homepage = "https://qzandronum.com/";
    description = "A fork of Zandronum with quake movement";
    license = licenses.unfreeRedistributable;
    platforms = platforms.linux;
  };
}
