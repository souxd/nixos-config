{ lib
, fetchgit
, pkg-config
, python3
}:

python3.pkgs.buildPythonApplication rec {
  pname = "poezio";
  version = "0.14";
  format = "setuptools";

  src = fetchgit {
    url = "https://codeberg.org/poezio/poezio.git";
    rev = "v${version}";
    sha256 = "15vlmymqlcf94h1g6dvgzjvj15c47dqsm78qs40wl2dlwspvqkxj";
  };

  nativeBuildInputs = [
    pkg-config
  ];

  propagatedBuildInputs = with python3.pkgs; [
    aiodns
    aiohttp
    cffi
    cryptography
    mpd2
    potr
    pyasn1
    pyasn1-modules
    pycares
    pygments
    pyinotify
    qrcode
    slixmpp
    typing-extensions
  ];

#  nativeCheckInputs = with python3.pkgs; [
#    pytestCheckHook
#  ];

  pythonImportsCheck = [
    "poezio"
  ];

  meta = with lib; {
    description = "Free console XMPP client";
    homepage = "https://poez.io";
    changelog = "https://codeberg.org/poezio/poezio/-/blob/v${version}/CHANGELOG";
    license = licenses.zlib;
    maintainers = with maintainers; [ lsix ];
  };
}
