{ pkgs, config, ... }:

{
  services.xserver = {
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true; # this causes input delay on wayland(?)
  };

  services = {
    udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
    gnome = {
      core-developer-tools.enable = true;
      tracker.enable = true;
      tracker-miners.enable = true;
    };
  };

  # gsconnect wont detect other devices if i dont enable these ports
  networking.firewall.allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
  networking.firewall.allowedUDPPortRanges = [{ from = 1714; to = 1764; }];

  environment.systemPackages = with pkgs; [
    gnomeExtensions.gtk-title-bar
    gnomeExtensions.tiling-assistant
    gnomeExtensions.gsconnect
    gnomeExtensions.vitals
  ];

}
