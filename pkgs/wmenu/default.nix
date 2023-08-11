{ lib
, stdenv
, fetchFromSourcehut
, pkg-config
, meson
, ninja
, cairo
, pango
, wayland
, wayland-protocols
, libxkbcommon
, scdoc
}:

stdenv.mkDerivation rec {
  pname = "wmenu";
  version = "git-2b9e08fb";

  strictDeps = true;

  src = fetchFromSourcehut {
    owner = "~adnano";
    repo = "wmenu";
    rev = "2b9e08fba1adfe36e89a4f6113112e8feed54d4f";
    hash = "sha256-Kntyqm2IFUdKDJUXzjttzqJEnKfiRe3sgGpuQi3kaJw=";
  };

  nativeBuildInputs = [ pkg-config meson ninja ];
  buildInputs = [ cairo pango wayland libxkbcommon wayland-protocols scdoc ];

  hardeningDisable = [ "all" ];

  meta = with lib; {
    description = "An efficient dynamic menu for Sway and wlroots based Wayland compositors";
    homepage = "https://git.sr.ht/~adnano/wmenu";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = with maintainers; [ eken ];
  };
}
