{ lib
, stdenv
, fetchFromGitHub
, autoreconfHook
, pkg-config
, libpng
}:

stdenv.mkDerivation rec {
  pname = "deutex";
  version = "v5.2.2";

  src = fetchFromGitHub {
    owner = "Doom-Utils";
    repo = "${pname}";
    rev = "${version}";
    hash = "sha256-e8jgz20FijcGQN3JYXaKzLNFiuYSFGK8ulky2g3RW/4=";
  };

  nativeBuildInputs = [
    pkg-config
    autoreconfHook
  ];

  buildInputs = [
    libpng
  ];


  installPhase = ''
    mkdir -p $out/bin
    cp -r src/deutex $out/bin
  '';

  meta = {
    homepage = "https://github.com/Doom-Utils/deutex/";
    description = "WAD composer for Doom, Heretic, Hexen, and Strife";
    license = lib.licenses.gpl2Only;
    platforms = lib.platforms.unix;
  };
}
