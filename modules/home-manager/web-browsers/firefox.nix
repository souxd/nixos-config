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

in
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-beta-bin;

    extensions = with ff-addons; [
      multi-account-containers
      tridactyl
      auto-tab-discard
      ublock-origin
      localcdn
      clearurls
      redirector
      i-dont-care-about-cookies
      unpaywall
      violentmonkey
    ];


    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;
      settings = sharedSettings;
      userChrome = disableWebRtcIndicator;
    };
  };
}
