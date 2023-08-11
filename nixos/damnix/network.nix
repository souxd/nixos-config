{ config, pkgs, ... }:

{
  ## encrypted dns (dnscrypt) ##
  networking = {
    nameservers = [ "127.0.0.1" "::1" ];
    # If using dhcpcd:
    dhcpcd.extraConfig = "nohook resolv.conf";
    # If using NetworkManager:
    networkmanager.dns = "none";
  };

  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      ipv6_servers = true;
      require_dnssec = true;

      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };

      # You can choose a specific set of servers from https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
      # server_names = [ ... ];
    };
  };

  systemd.services.dnscrypt-proxy2.serviceConfig = {
    StateDirectory = "dnscrypt-proxy";
  };

  ## privoxy
  # services.privoxy.enable = true;
  # services.privoxy.enableTor = true;

  ## tor client ##
  services.tor = {
    # slow  SOCKS port 9050 that creates a new circuit for each destination IP. use for email, git and pretty much any other procol but HTTP(S).
    enable = true;
    # Fast SOCKS port 9063 (for browser use) routed by the privoxy HTTP proxy on port 8118. Route HTTP trafic via Privoxy.
    client.enable = true;
  };

  # restart the Tor daemon every time network reconnect is performaed. This avoids having to wait for Tor network timeouts and reastablishes a new connection faster. Useless without systemd-networkd.
  /*
  services.networkd-dispatcher = {
    enable = true;
    rules."restart-tor" = {
      onState = ["routable" "off"];
      script = ''
        #!${pkgs.runtimeShell}
        if [[ $IFACE == "wlan0" && $AdministrativeState == "configured" ]]; then
          echo "Restarting Tor ..."
          systemctl restart tor
        fi
        exit 0
      '';
    };
  };
  */

  ## ports ##
  # zandronum
  networking.firewall.allowedTCPPortRanges = [{ from = 10666; to = 10670; }];
  networking.firewall.allowedUDPPortRanges = [{ from = 10666; to = 10670; }];
}
