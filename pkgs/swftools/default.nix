{ lib, stdenv, fetchFromGitHub, perl, freetype, giflib, lame, libjpeg, zlib }:

stdenv.mkDerivation rec {
  pname = "swftools";
  version = "2021-12-16";

  src = fetchFromGitHub {
    owner = "matthiaskramm";
    repo = "swftools";
    rev = "772e55a271f66818b06c6e8c9b839befa51248f4";
    hash = "sha256-fLSs/tqSi1X4r+OIvLWmrZ782p3bXj3Usv2+Y3MSCik=";
  };

  patches = [ ./bitpressure_strategy1.patch ];

  nativeBuildInputs = [ perl ];

  buildInputs = [ freetype giflib lame libjpeg zlib ];

  meta = with lib; {
    description = "Collection of SWF manipulation and creation utilities";
    homepage = "http://www.swftools.org/about.html";
    license = licenses.gpl2Only;
    maintainers = [ maintainers.koral ];
    platforms = lib.platforms.unix;
    knownVulnerabilities = [
      "CVE-2017-8401"
      "CVE-2017-10976"
      "CVE-2017-11096"
      "CVE-2017-11097"
      "CVE-2017-11098"
      "CVE-2017-11099"
      "CVE-2017-11100"
      "CVE-2017-11101"
      "CVE-2017-16711"
      "CVE-2017-16793"
      "CVE-2017-16794"
      "CVE-2017-16796"
      "CVE-2017-16797"
      "CVE-2017-16868"
      "CVE-2017-16890"
    ];
  };
}
