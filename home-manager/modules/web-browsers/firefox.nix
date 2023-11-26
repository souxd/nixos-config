# firefox profiles, targets firefox-beta-bin and uses addons from rycee's NUR
{ config, pkgs, specialArgs, ... }:

let
  inherit (specialArgs) ff-addons;

  # FIXME disable the annoying floating icon with camera and mic when on a call
  disableWebRtcIndicator = ''
    #webrtcIndicator { display: none !important; }
  '';

  sharedSettings = {
    "browser.shell.checkDefaultBrowser" = false;
    "app.normandy.first_run" = false;
    "app.shield.optoutstudies.enabled" = true;
    "browser.aboutConfig.showWarning" = false;

    # disable updates
    "app.update.auto" = false;
    "extensions.update.enabled" = false;

    "extension.activeThemeID" = "firefox-compact-dark@mozilla.org";
  };

  privacySettings = {
    ## https://miloslav.website/blog/2020/10/26/firefox-privacy
    "browser.safebrowsing.allowOverride" = false;
    "browser.safebrowsing.blockedURIs.enabled" = false;
    "browser.safebrowsing.debug" = false;
    "browser.safebrowsing.downloads.enabled" = false;
    "browser.safebrowsing.downloads.remote.block_dangerous" = false;
    "browser.safebrowsing.downloads.remote.block_dangerous_host" = false;
    "browser.safebrowsing.downloads.remote.block_potentially_unwanted" = false;
    "browser.safebrowsing.downloads.remote.block_uncommon" = false;
    "browser.safebrowsing.downloads.remote.enabled" = false;
    "browser.safebrowsing.downloads.remote.timeout_ms" = 15000;
    "browser.safebrowsing.downloads.remote.url" = "https://127.0.0.1";
    "browser.safebrowsing.id" = "null";
    "browser.safebrowsing.malware.enabled" = false;
    "browser.safebrowsing.passwords.enabled" = false;
    "browser.safebrowsing.phishing.enabled" = false;
    "browser.safebrowsing.prefixset_max_array_size" = 524288;
    "browser.safebrowsing.provider.google.advisoryName" = "Google Safe Browsing";
    "browser.safebrowsing.provider.google.advisoryURL" = "https://127.0.0.1";
    "browser.safebrowsing.provider.google.gethashURL" = "https://127.0.0.1";
    "browser.safebrowsing.provider.google.lists" = "";
    "browser.safebrowsing.provider.google.pver" = "2.2";
    "browser.safebrowsing.provider.google.reportMalwareMistakeURL" = "https://127.0.0.1";
    "browser.safebrowsing.provider.google.reportPhishMistakeURL" = "https://127.0.0.1";
    "browser.safebrowsing.provider.google.reportURL" = "https://127.0.0.1";
    "browser.safebrowsing.provider.google.updateURL" = "https://127.0.0.1";
    "browser.safebrowsing.provider.google4.advisoryName" = "Google Safe Browsing";
    "browser.safebrowsing.provider.google4.advisoryURL" = "https://127.0.0.1";
    "browser.safebrowsing.provider.google4.dataSharing.enabled" = false;
    "browser.safebrowsing.provider.google4.dataSharingURL" = "https://127.0.0.1";
    "browser.safebrowsing.provider.google4.gethashURL" = "https://127.0.0.1";
    "browser.safebrowsing.provider.google4.lastupdatetime" = 1603739550029;
    "browser.safebrowsing.provider.google4.lists" = "";
    "browser.safebrowsing.provider.google4.nextupdatetime" = 1603741356029;
    "browser.safebrowsing.provider.google4.pver" = 4;
    "browser.safebrowsing.provider.google4.reportMalwareMistakeURL" = "https://127.0.0.1";
    "browser.safebrowsing.provider.google4.reportPhishMistakeURL" = "https://127.0.0.1";
    "browser.safebrowsing.provider.google4.reportURL" = "https://127.0.0.1";
    "browser.safebrowsing.provider.google4.updateURL" = "https://127.0.0.1";
    "browser.safebrowsing.provider.mozilla.gethashURL" = "https://127.0.0.1";
    "browser.safebrowsing.provider.mozilla.lastupdatetime" = "1603739273301";
    "browser.safebrowsing.provider.mozilla.lists" = "";
    "browser.safebrowsing.provider.mozilla.lists.base" = "moz-std";
    "browser.safebrowsing.provider.mozilla.lists.content" = "moz-full";
    "browser.safebrowsing.provider.mozilla.nextupdatetime" = 1603742873301;
    "browser.safebrowsing.provider.mozilla.pver" = "2.2";
    "browser.safebrowsing.provider.mozilla.updateURL" = "https://127.0.0.1";
    "browser.safebrowsing.reportPhishURL" = "https://127.0.0.1";
    "services.sync.prefs.sync.browser.safebrowsing.downloads.enabled" = false;
    "services.sync.prefs.sync.browser.safebrowsing.downloads.remote. block_potentially_unwanted" = false;
    "services.sync.prefs.sync.browser.safebrowsing.malware.enabled" = false;
    "services.sync.prefs.sync.browser.safebrowsing.phishing.enabled" = false;
    "browser.safebrowsing" = false;

    # Additional
    "privacy.resistFingerprinting" = true;
    "toolkit.telemetry.enabled" = false;
    "datareporting.healthreport.service.enabled" = false;
    "datareporting.healthreport.uploadEnabled" = false;
    "media.eme.enabled" = false;
    "media.gmp-eme-adobe.enabled" = false;
    "browser.pocket.enabled" = false;
    "geo.enabled" = false;
  };

  i2p = {
    "media.peerConnection.ice.proxy_only" = true;
  };


  addons = with ff-addons; [
    multi-account-containers
    tridactyl
    auto-tab-discard
    ublock-origin
    localcdn
    clearurls
    redirector
    unpaywall
    violentmonkey
  ];
in
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-beta-bin;

    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;
      settings = sharedSettings;
      userChrome = disableWebRtcIndicator;
      extensions = addons;
    };

    profiles.itoopeer = {
      id = 1;
      name = "itoopeer";
      isDefault = false;
      settings = sharedSettings // privacySettings // i2p;
      userChrome = disableWebRtcIndicator;
    };
  };
}
