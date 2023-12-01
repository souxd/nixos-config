final: prev: {
  sm64ex-coop = final.callPackage ./sm64ex/coop.nix {};

  avx-palemoon-bin = final.callPackage ./avx-palemoon {};

  beebeep-bin = final.qt5.callPackage ./beebeep-bin {};

  cleanflash = final.callPackage ./mozilla-plugins/flashplayer/cleanflash.nix {};

  doomseeker = final.qt5.callPackage ./doomseeker {};

  flashplayer = final.callPackage ./mozilla-plugins/flashplayer {};

  flashplayer-standalone = final.callPackage ./mozilla-plugins/flashplayer/standalone.nix {};

  flashplayer-standalone-debugger = final.callPackage ./mozilla-plugins/flashplayer/standalone.nix {
    debug = true;
  };

  ripcord-patched = final.qt5.callPackage ./ripcord-patched {};

  ripcord-audio-hook = final.callPackage ./ripcord-patched/ripcord-audio-hook.nix {};

  ripcord-patcher = final.callPackage ./ripcord-patched/ripcord-patcher.nix {};

  funchook = final.callPackage ./ripcord-patched/funchook.nix {};

  pkg2zip = final.callPackage ./pkg2zip {};

  wmenu = final.callPackage ./wmenu {};

  zandronum-alpha-bin = final.callPackage ./zandronum-alpha-bin {};
}
