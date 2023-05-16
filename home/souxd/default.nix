{ config, pkgs, ... }:
let
  lvimDesktopItem = pkgs.makeDesktopItem {
    name = "lvim";
    desktopName = "Neovim distro";
    exec = "footclient lvim";
    terminal = true;
  };
in
{
  home.packages = [ lvimDesktopItem ];
  home.sessionVariables = {
    XKB_DEFAULT_OPTIONS = "ctrl:swapcaps";
  };

  imports = [
    ../configuration.nix
    ./shell.nix
    ./programs.nix
    ./services.nix
  ] ++
  (map (p: ../../modules/home-manager + p) [
    /nix-direnv.nix
    /desktop/sway.nix
    /media/mpd.nix
    /office/libreoffice.nix
    /office/zathura.nix
  ]);

  programs.home-manager.enable = true;

  home.sessionPath = [
    "\${HOME}/.npm-global"
  ];

  # sway preferences
  wayland.windowManager.sway = {
    config = {
      input = {
        "1133:49271:Logitech_USB_Optical_Mouse" = {
          accel_profile = "flat";
          pointer_accel = "0.5";
        };
      };
      output."*".bg = "${../../assets/wallpapers/1920x1080-space_tree_frog.png} fill";

      defaultWorkspace = "workspace number 1";

      assigns = { "3" = [{ title = "main — hydrus client 520"; }]; };
      assigns = { "9" = [{ app_id="org.kde.kdeconnect.app"; }]; };
      assigns = { "10" = [{ app_id = "ymuse"; } { app_id = "org.gnome.clocks"; }]; };

      startup = [
        { command = "keepassxc"; }
        { command = "ymuse"; }
        { command = "env QT_QPA_PLATFORM=xcb beebeep"; }
        { command = "env --unset=WAYLAND_DISPLAY --unset=QT_QPA_PLATFORM hydrus-client"; }
        { command = "gnome-clocks"; } # FIXME gapplication-service
        { command = "kdeconnect-app"; }
      ];
    };

    extraConfig = ''
      for_window [app_id="com.github.wwmm.easyeffects"] floating enable
      for_window [title="manage tags — hydrus client*"] floating enable
      for_window [app_id="org.keepassxc.KeePassXC"] move to scratchpad
      for_window [title="^([^\s]+) - BeeBEEP$"] move to scratchpad
    '';
  };
}
