# my gnome settings, further customization
# should be made using home-manager
{ pkgs, config, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true; # this causes input delay on wayland(?)
    desktopManager.gnome = {
      enable = true;
    };
  };

  services = {
    udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
    gnome = {
      tracker.enable = true;
      tracker-miners.enable = true;
    };
  };

  # must-have extensions
  environment.systemPackages = with pkgs.gnomeExtensions; [
    tiling-assistant
    gsconnect
    vitals
  ];

  # GSConnect wont detect other devices if i dont enable these ports
  networking.firewall.allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
  networking.firewall.allowedUDPPortRanges = [{ from = 1714; to = 1764; }];
}
