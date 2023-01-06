{ config, pkgs, ... }:

{
  services.printing.enable = true;
  services.avahi.enable = true;
  # for a WiFi printer
  services.avahi.openFirewall = true;
  # Important to resolve .local domains of printers, otherwise you get an error
  # like  "Impossible to connect to XXX.local: Name or service not known"
  services.avahi.nssmdns = true;

  services.printing.drivers = [ /* EPSON L3159 */ pkgs.epson-escpr ];
}
