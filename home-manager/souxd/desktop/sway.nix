{ config, pkgs, ... }:

{
  home.sessionVariables = { WLR_DRM_NO_ATOMIC = "1"; };

  imports = (map (p: ../../modules + p) [
    /desktop/sway.nix
  ]) /* ++ [
    ./waybar.nix
  ] */;

  # sway preferences
  wayland.windowManager.sway = {
    config = {
      input = {
        "1133:49271:Logitech_USB_Optical_Mouse" = {
          accel_profile = "flat";
          pointer_accel = "0.5";
        };
        "1118:1861:Microsoft_Microsoft___2.4GHz_Transceiver_v8.0" = {
          repeat_delay = "250";
          xkb_numlock = "enabled";
        };
      };
      output = {
        "*" = {
	  subpixel = "rgb";
          bg = "${../../../assets/wallpapers/1920x1080-space_tree_frog.png} fill";
        };
      };

      defaultWorkspace = "workspace number 1";

      assigns = { "3" = [{ title = "main — hydrus client 530"; }]; };
      assigns = { "9" = [{ app_id="org.kde.kdeconnect.app"; }]; };
      assigns = { "10" = [{ app_id = "ymuse"; } { app_id = "org.gnome.clocks"; }]; };

      startup = [
        { command = "waybar"; }
        { command = "keepassxc"; }
        { command = "ymuse"; }
        { command = "env QT_QPA_PLATFORM=xcb beebeep"; }
        { command = "env --unset=WAYLAND_DISPLAY --unset=QT_QPA_PLATFORM hydrus-client"; }
        { command = "gnome-clocks"; } # FIXME gapplication-service
        { command = "kdeconnect-app"; }
      ];

      keybindings = let
      modifier = "Mod4"; 
      mpc = "${pkgs.mpc-cli}/bin/mpc";
      in {
          # emacs shortcut
        "${modifier}+Ctrl+e" = "exec emacsclient -c";

          # mpd
          "${modifier}+XF86AudioRaiseVolume" = "exec ${mpc} volume +5";
          "${modifier}+XF86AudioLowerVolume" = "exec ${mpc} volume -5";
          "${modifier}+XF86AudioPlay" = "exec ${mpc} toggle";
          "${modifier}+XF86AudioMute" = "exec ${mpc} repeat";
          "${modifier}+Prior" = "exec ${mpc} prev";
          "${modifier}+Next" = "exec ${mpc} next";
      };
    };

    extraConfig = ''
      for_window [app_id="com.github.wwmm.easyeffects"] floating enable
      for_window [title="manage tags — hydrus client*"] floating enable
      for_window [title="^([^\s]+) - BeeBEEP$"] move to scratchpad
      # for_window [app_id="org.keepassxc.KeePassXC"] move to scratchpad
    '';
  };
}
