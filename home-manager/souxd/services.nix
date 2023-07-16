{ config, ... }:

{
  services = {
    easyeffects.enable = true;
    syncthing.enable = true;

    gpg-agent = {
      enable = true;
      enableBashIntegration = true;
      pinentryFlavor = "curses";
    };
  };

}
