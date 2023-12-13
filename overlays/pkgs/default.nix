final: prev: {
  sm64ex-coop = final.callPackage ./sm64ex/coop.nix {};

  avx-palemoon-bin = final.callPackage ./avx-palemoon-bin {};

  beebeep-bin = final.qt5.callPackage ./beebeep-bin {};

  cleanflash = final.callPackage ./mozilla-plugins/flashplayer/cleanflash.nix {};

  doomseeker = final.qt5.callPackage ./doomseeker {};

  deutex = final.callPackage ./odamex/deutex.nix {};

  flashplayer = final.callPackage ./mozilla-plugins/flashplayer {};

  flashplayer-standalone = final.callPackage ./mozilla-plugins/flashplayer/standalone.nix {};

  flashplayer-standalone-debugger = final.callPackage ./mozilla-plugins/flashplayer/standalone.nix {
    debug = true;
  };

  ripcord-patched = final.qt5.callPackage ./ripcord-patched {};

  ripcord-audio-hook = final.callPackage ./ripcord-patched/ripcord-audio-hook.nix {};

  ripcord-patcher = final.callPackage ./ripcord-patched/ripcord-patcher.nix {};

  funchook = final.callPackage ./ripcord-patched/funchook.nix {};

  odamex = final.callPackage ./odamex {};

  pkg2zip = final.callPackage ./pkg2zip {};

  quake3e = final.callPackage ./quake3e {};

  wmenu = final.callPackage ./wmenu {};

  zandronum-alpha-bin = final.callPackage ./zandronum-alpha-bin {};

  q-zandronum-bin = final.callPackage ./q-zandronum-bin {};
}
