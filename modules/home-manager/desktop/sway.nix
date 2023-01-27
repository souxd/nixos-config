{ config, pkgs, ... }:

let
  # start custom systemd services
  services-start = pkgs.writeTextFile {
    name = "services-start";
    destination = "/bin/services-start";
    executable = true;
    text = ''
      systemctl --user stop gammastep
      systemctl --user start gammastep
    '';
  };
in
{
  systemd.user.services.gammastep = {
    Unit = {
      Description = "Night time color filter";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.gammastep}/bin/gammastep -m wayland -l 7:-34 -t 6500:3000";
      Restart = "on-failure";
      RestartSec = 5;
    };
  };

  imports = [ ./theme.nix ./foot.nix ./mako.nix ../media/mpv.nix ];

  home.packages = with pkgs; [
    services-start
    wayland
    libsForQt5.qtwayland
    wf-recorder # screenrecorder
    swappy # snapshot editor
    wl-clipboard # wl-copy and wl-paste from stdin/stdout
    pcmanfm # file manager
    gnome.file-roller # archive manager
    imv # image viewer
    oneko # silly cat
  ];

  # tells wob where the sock is
  home.sessionVariables = { WOBSOCK = "\${XDG_RUNTIME_DIR}/wob.sock"; };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "pcmanfm.desktop";
      "image/gif" = "imv.desktop";
      "image/png" = "imv.desktop";
      "image/jpeg" = "imv.desktop";
      "image/webp" = "imv.desktop";
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = rec {

      output."*".bg = "${../../../assets/wallpapers/1920x1080-space_tree_frog.png} fill";

      fonts = {
        names = [ "FiraCode Nerd Font" ];
        size = 11.0;
      };

      colors.focused = rec {
        border = "#83abd4AA";
        indicator = border;
        background = "#DDDDDD";
        childBorder = border;
        text = "#121212";
      };

      #seat = {
      # FIXME makes games that requires mouse almost unplayable
      #"*" = { hide_cursor = "8000"; };
      #};

      defaultWorkspace = "workspace number 1";
      assigns = { "1" = [{ app_id = "firefox-beta"; } { app_id = "qutebrowser"; }]; };
      assigns = { "3" = [{ app_id = "python3"; }]; };
      assigns = { "10" = [{ app_id = "ymuse"; } { app_id = "org.gnome.clocks"; }]; };

      startup = [
        # Launch on start
        { command = "services-start"; }
        { command = "${pkgs.autotiling}/bin/autotiling"; always = true; }
        { command = "foot --server"; }
        { command = "rm -f $WOBSOCK && mkfifo $WOBSOCK && tail -f $WOBSOCK | ${pkgs.wob}/bin/wob"; }
        { command = "keepassxc"; }
        { command = "firefox"; }
        { command = "ymuse"; }
        { command = "env QT_QPA_PLATFORM=xcb beebeep"; }
        { command = "hydrus-client"; }
        { command = "gnome-clocks"; } # FIXME gapplication-service
        #{ command = "kdeconnect-app"; }
      ];

      modifier = "Mod4";
      floating.modifier = "Mod4";
      # Use as default launcher menu
      menu = "${pkgs.tofi}/bin/tofi-drun --font ${pkgs.fira-code}/share/fonts/truetype/FiraCode-VF.tff | xargs swaymsg exec --";
      # Use as default terminal
      terminal = "footclient";
      # navkeys
      left = "h";
      down = "j";
      up = "k";
      right = "l";

      keybindings =
        let
          soundctl = "${pkgs.pamixer}/bin/pamixer";
          mpc = "${pkgs.mpc-cli}/bin/mpc";
          grimshot = "${pkgs.sway-contrib.grimshot}/bin/grimshot";
        in
        {
          # basics
          "${modifier}+Return" = "exec ${terminal}";
          "${modifier}+d" = "exec ${menu}";
          "${modifier}+Shift+e" = "exec emacsclient -c";

          # screen lock
          "${modifier}+Shift+s" = "exec ${pkgs.swaylock}/bin/swaylock -c 000000";

          # audio
          "${modifier}+q" = "exec ${pkgs.pavucontrol}/bin/pavucontrol";
          "XF86AudioRaiseVolume" = "exec ${soundctl} -ui 2 && ${soundctl} --get-volume > $WOBSOCK";
          "XF86AudioLowerVolume" = "exec ${soundctl} -ud 2 && ${soundctl} --get-volume > $WOBSOCK";
          "XF86AudioMute" = ''exec ${soundctl} --toggle-mute && ( [ "\$(${soundctl} - -get-mute) " = "true" ] && echo 0 > $WOBSOCK ) || ${soundctl} --get-volume > $WOBSOCK'';
          "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";

          # mpd
          "${modifier}+XF86AudioRaiseVolume" = "exec ${mpc} volume +5";
          "${modifier}+XF86AudioLowerVolume" = "exec ${mpc} volume -5";
          "${modifier}+XF86AudioPlay" = "exec ${mpc} toggle";
          "${modifier}+XF86AudioMute" = "exec ${mpc} next";

          # screen capture
          "Print" = "exec ${grimshot} copy screen";
          "${modifier}+Print" = "exec ${grimshot} save screen - | swappy -f -";
          "${modifier}+g" = ''exec ${grimshot} save window - | swappy -f -'';

          "${modifier}+Shift+c" = "reload";

          "${modifier}+Shift+q" = "kill";
          "${modifier}+Shift+Escape" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'";

          "${modifier}+f" = "fullscreen";
          "${modifier}+e" = "layout toggle split";
          "${modifier}+s" = "layout stacking";
          "${modifier}+w" = "layout tabbed";

          "${modifier}+Left" = "focus left";
          "${modifier}+Down" = "focus down";
          "${modifier}+Up" = "focus up";
          "${modifier}+Right" = "focus right";
          "${modifier}+${left}" = "focus left";
          "${modifier}+${down}" = "focus down";
          "${modifier}+${up}" = "focus up";
          "${modifier}+${right}" = "focus right";

          "${modifier}+Shift+Left" = "move left";
          "${modifier}+Shift+Down" = "move down";
          "${modifier}+Shift+Up" = "move up";
          "${modifier}+Shift+Right" = "move right";
          "${modifier}+Shift+${left}" = "move left";
          "${modifier}+Shift+${down}" = "move down";
          "${modifier}+Shift+${up}" = "move up";
          "${modifier}+Shift+${right}" = "move right";

          "${modifier}+1" = "workspace number 1";
          "${modifier}+2" = "workspace number 2";
          "${modifier}+3" = "workspace number 3";
          "${modifier}+4" = "workspace number 4";
          "${modifier}+5" = "workspace number 5";
          "${modifier}+6" = "workspace number 6";
          "${modifier}+7" = "workspace number 7";
          "${modifier}+8" = "workspace number 8";
          "${modifier}+9" = "workspace number 9";
          "${modifier}+0" = "workspace number 10";

          "${modifier}+Shift+1" = "move container to workspace number 1";
          "${modifier}+Shift+2" = "move container to workspace number 2";
          "${modifier}+Shift+3" = "move container to workspace number 3";
          "${modifier}+Shift+4" = "move container to workspace number 4";
          "${modifier}+Shift+5" = "move container to workspace number 5";
          "${modifier}+Shift+6" = "move container to workspace number 6";
          "${modifier}+Shift+7" = "move container to workspace number 7";
          "${modifier}+Shift+8" = "move container to workspace number 8";
          "${modifier}+Shift+9" = "move container to workspace number 9";
          "${modifier}+Shift+0" = "move container to workspace number 10";

          "${modifier}+n" = "focus output left";
          "${modifier}+m" = "focus output right";

          "${modifier}+Shift+n" = "move output left";
          "${modifier}+Shift+m" = "move output right";

          "${modifier}+Tab" = "move workspace to output right";
          "${modifier}+Shift+Tab" = "move workspace to output left";

          "${modifier}+t" = "input type:touchpad events disabled";
          "${modifier}+Shift+t" = "input type:touchpad events enabled";

          "${modifier}+Shift+space" = "floating toggle";
          "${modifier}+space" = "focus mode_toggle";

          "${modifier}+a" = "focus parent";
          "${modifier}+c" = "focus child";

          "${modifier}+Shift+minus" = "move scratchpad";
          "${modifier}+minus" = "scratchpad show";

          "${modifier}+r" = '' mode "resize" '';
        };
      modes.resize = {
        "Left" = "resize shrink width 10px";
        "Down" = "resize grow height 10px";
        "Up" = "resize shrink height 10px";
        "Right" = "resize grow width 10px";
        "${left}" = "resize shrink width 10px";
        "${down}" = "resize grow height 10px";
        "${up}" = "resize shrink height 10px";
        "${right}" = "resize grow width 10px";

        "Return" = ''
          mode "default" '';
        "Escape" = ''
          mode "default" '';
      };
    };

    extraConfig = ''
      for_window [app_id="com.github.wwmm.easyeffects"] floating enable
      for_window [app_id="pavucontrol"] floating enable
      for_window [app_id="org.keepassxc.KeePassXC"] move to scratchpad
      for_window [app_id="org.kde.kdeconnect.app"] move to scratchpad
      for_window [title="souxd - BeeBEEP"] move to scratchpad
    '';
  };
}
