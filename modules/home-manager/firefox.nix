{ config, pkgs, specialArgs, ... }:

let
  inherit (specialArgs) ff-addons;

  # disable the annoying floating icon with camera and mic when on a call
  disableWebRtcIndicator = ''
    #webrtcIndicator {
      display: none;
    }
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

in
{
  programs.firefox = {
    enable = true;

    extensions = with ff-addons; [
      tridactyl
      auto-tab-discard
      ublock-origin
      leechblock-ng
      i-dont-care-about-cookies
      unpaywall
      terms-of-service-didnt-read
      sponsorblock
      return-youtube-dislikes
      don-t-fuck-with-paste
      h264ify
    ];

    package = pkgs.firefox-beta-bin;

    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;
      settings = sharedSettings;
      userChrome = disableWebRtcIndicator;
    };
  };
}