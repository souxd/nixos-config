{ lib
, stdenv
, fetchFromGitHub
, pkg-config
}:

stdenv.mkDerivation rec {
  pname = "zt-bcc";
  version = "0.9.0";

  src = fetchFromGitHub {
    owner = "zeta-group";
    repo = pname;
    rev = version;
    hash = "sha256-dY4Q9gJ+I7ySEMFllRmJ7G/EzNwQpf7J95lL5mx3zxA=";
  };

  prePatch = ''
    substituteInPlace Makefile \
      --replace -Werror -Wno-error
  '';

  installPhase = ''
    runHook preInstall
    install -D zt-bcc $out/bin/zt-bcc
    runHook postInstall
  '';
}
