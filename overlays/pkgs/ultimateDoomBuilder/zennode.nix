{ lib
, stdenv
, fetchurl
, unzip 
}:

stdenv.mkDerivation rec {
  pname = "zennode";
  version = "1.2.1";

  src = fetchurl {
    url = "https://www.mrousseau.org/programs/ZenNode/archives/zennode-${version}.zip";
    hash = "sha256-E3tQ+bxu/GmuvKQjO9OSSp7SEmCFXm437QmEhvkL0hI=";
  };

  nativeBuildInputs = [ unzip ];

  hardeningDisable = [ "format" ];

  buildPhase = ''
  runHook preBuild
  unzip zennode-src.zip
  cd src/ZenNode
  make
  runHook postBuild
  '';

  installPhase = ''
  runHook preInstall
  mkdir -p $out/{share,bin}
  cp {ZenNode,bspdiff,bspinfo,compare} $out/share
  ln -s $out/share/{ZenNode,bspdiff,bspinfo} $out/bin
  ln -s $out/share/compare $out/bin/bspcompare
  runHook postInstall
  '';
}
