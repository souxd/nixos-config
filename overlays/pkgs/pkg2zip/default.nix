{ stdenv
, lib
, fetchFromGitHub
, gnumake
}:

stdenv.mkDerivation rec {
  name = "pkg2zip";
  version = "2.3";

  src = fetchFromGitHub {
    owner = "lusid1";
    repo = "${name}";
    rev = "${version}";
    hash = "sha256-sirvaA+1fQIrQC4CMZU30hYDuH8+7YhqQfdWkxhQWEo=";
  };

  nativeBuildInputs = [
    gnumake
  ];

  installPhase = ''
    mkdir -p $out/bin
    mv pkg2zip $out/bin
  '';

  meta = with lib; {
    description = "Decrypts PlayStation Vita pkg file and packages to zip archive";
    homepage = "https://github.com/lusid1/pkg2zip";
    license = licenses.unlicense;
    platforms = platforms.linux;
  };
}
