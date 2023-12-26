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

  installPhase = ''
    mkdir -p $out/bin
    cp linux-x86_64/* $out/bin
  '';
}
