{
  imports = [ ./wg-conf.nix ];
  security.pam.services.souxd.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;

  users.users.souxd = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" "docker" "adbusers" "video" "audio" "wireshark" "transmission" "input" ];
  };
}
