{
  imports = [ ./wg-conf.nix ];

  users.users.souxd = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" "adbusers" ];
  };
}
