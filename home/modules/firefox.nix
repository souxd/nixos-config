{ pkgs, specialArgs, ... }:

let
  inherit (specialArgs) ff-addons;
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
    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;
      settings = {
        "app.update.auto" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.aboutConfig.showWarning" = false;
        "extensions.update.enabled" = false;
        "extension.activeThemeID" = "firefox-compact-dark@mozilla.org";
      };
    };
  };
}
