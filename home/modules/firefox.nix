{ pkgs, specialArgs, ... }:

let
  inherit (specialArgs) ff-addons;
in
{
  programs.firefox = {
    enable = true;
    extensions = with ff-addons; [
      auto-tab-discard
      ublock-origin
      i-dont-care-about-cookies
      unpaywall
      tridactyl
      terms-of-service-didnt-read
      df-youtube
      sponsorblock
      return-youtube-dislikes
      keepassxc-browser
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
