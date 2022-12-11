{ pkgs, config, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true; # Unsure if this causes input delay on wayland(?)
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

  # GSConnect wont detect other devices if i dont enable these ports
  networking.firewall.allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
  networking.firewall.allowedUDPPortRanges = [{ from = 1714; to = 1764; }];

  environment.systemPackages = with pkgs; [
    gnomeExtensions.gtk-title-bar
    gnomeExtensions.tiling-assistant
    gnomeExtensions.gsconnect
    gnomeExtensions.vitals
  ];
}
