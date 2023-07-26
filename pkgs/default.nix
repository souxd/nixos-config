final: prev: {
  hydrus = final.qt5.callPackage ./hydrus.nix {};

  sm64ex-coop = final.callPackage ./sm64ex/coop.nix {};

  am2rlauncher = final.callPackage ./am2rlauncher {};

  avisynthplus = final.callPackage ./avisynthplus {};

  avx-palemoon = final.callPackage ./avx-palemoon {};

  avx-palemoon-bin = final.callPackage ./avx-palemoon/bin.nix {};

  beebeep = final.qt5.callPackage ./beebeep {};

  doomseeker-latest = final.qt5.callPackage ./doomseeker-latest {};

  flashplayer = final.callPackage ./mozilla-plugins/flashplayer {};

  cleanflash = final.callPackage ./mozilla-plugins/flashplayer/cleanflash.nix {};

  flashplayer-standalone = final.callPackage ./mozilla-plugins/flashplayer/standalone.nix {};

  flashplayer-standalone-debugger = final.callPackage ./mozilla-plugins/flashplayer/standalone.nix {
    debug = true;
  };

  flatpak-xdg-utils = final.callPackage ./flatpak-xdg-utils {};

  glaxnimate = final.qt5.callPackage ./glaxnimate {};

  poezio = final.callPackage ./poezio {};
  
  ripcord-patched = final.qt5.callPackage ./ripcord-patched {};

  ripcord-audio-hook = final.callPackage ./ripcord-patched/ripcord-audio-hook.nix {};

  ripcord-patcher = final.callPackage ./ripcord-patched/ripcord-patcher.nix {};

  funchook = final.callPackage ./ripcord-patched/funchook.nix {};

  spiralknights = final.callPackage ./spiralknights {};

  zandronum-dev = final.callPackage ./zandronum-dev {};

  zandronum-dev-bin = final.callPackage ./zandronum-dev/bin.nix {};

  zandronum-dev-server = final.callPackage ./zandronum-dev {
    serverOnly = true;
  };
}
