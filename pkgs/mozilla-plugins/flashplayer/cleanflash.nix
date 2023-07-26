{ stdenv
, lib
, fetchurl
, alsaLib
, atk
, bzip2
, cairo
, curl
, expat
, fontconfig
, freetype
, gdk-pixbuf
, glib
, glibc
, graphite2
, gtk2
, harfbuzz
, libICE
, libSM
, libX11
, libXau
, libXcomposite
, libXcursor
, libXdamage
, libXdmcp
, libXext
, libXfixes
, libXi
, libXinerama
, libXrandr
, libXrender
, libXt
, libXxf86vm
, libdrm
, libffi
, libglvnd
, libpng
, libvdpau
, libxcb
, libxshmfence
, nspr
, nss
, pango
, pcre
, pixman
, zlib
, p7zip
}:

let
  arch =
    if stdenv.hostPlatform.system == "x86_64-linux" then
      "x86_64"
    else if stdenv.hostPlatform.system == "i686-linux"   then
      "i386"
    else throw "Flash Player is not supported on this platform";
  flash_suffix =
    if stdenv.hostPlatform.system == "x86_64-linux" then
      "64"
    else
      "32";
  lib_suffix =
    if stdenv.hostPlatform.system == "x86_64-linux" then
      "64"
    else
      "";
in
stdenv.mkDerivation rec {
  pname = "cleanflash";
  version = "34.0.0.137";

  src = fetchurl {
    url =
      "https://github.com/darktohka/clean-flash-builds/releases/download/v1.7/flash_player_patched_npapi_linux.x86_64.tar.gz";
    sha256 =
      "19gv6azhc2s6aa710r0ffizn5a4wmxypj8za9sbs82ivpz2ypnxx";
  };

  sourceRoot = ".";

  dontStrip = true;
  dontPatchELF = true;

  preferLocalBuild = true;

  installPhase = ''
    mkdir -p $out/lib/mozilla/plugins
    cp -pv libflashplayer.so $out/lib/mozilla/plugins/libflashplayer.so
    chmod +x $out/lib/mozilla/plugins/libflashplayer.so
    patchelf --set-rpath "$rpath" \
      $out/lib/mozilla/plugins/libflashplayer.so
  '';

  passthru = {
    mozillaPlugin = "/lib/mozilla/plugins";
  };

  rpath = lib.makeLibraryPath
    [ stdenv.cc.cc
      alsaLib atk bzip2 cairo curl expat fontconfig freetype gdk-pixbuf glib
      glibc graphite2 gtk2 harfbuzz libICE libSM libX11 libXau libXcomposite
      libXcursor libXdamage libXdmcp libXext libXfixes libXi libXinerama
      libXrandr libXrender libXt libXxf86vm libdrm libffi libglvnd libpng
      libvdpau libxcb libxshmfence nspr nss pango pcre pixman zlib
    ];

  meta = {
    description = "Adobe Flash Player browser plugin";
    homepage = "http://swfchan.com/end/";
    license = lib.licenses.unfree;
    platforms = [ "x86_64-linux" "i686-linux" ];
  };
}
