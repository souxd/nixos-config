{ config, pkgs, ... }:

let
  # start custom systemd services
  services-start = pkgs.writeShellScriptBin "services-start"
    ''
      systemctl --user stop gammastep
      systemctl --user start gammastep
    '';

  env-nsxiv = pkgs.writeShellScriptBin "env-nsxiv"
    ''
      #!/usr/bin/env sh
      NSXIV_OPTS="-a -q"
      exec ${pkgs.nsxiv}/bin/nsxiv $NSXIV_OPTS "$@"      
    '';
  env-nsxivDesktopItem = pkgs.makeDesktopItem {
    name = "env-nsxiv";
    desktopName = "New suckless image viewer";
    exec = "${env-nsxiv}/bin/env-nsxiv";
  };

  nsxiv-url = pkgs.writeShellScriptBin "nsxiv-url"
    ''
      #!/usr/bin/env sh

      cache_dir="/tmp/nsxiv"

      die() {
        [ -n "$1" ] && printf '%s\n' "$*" >&2;
        exit 1
      }

      cleanup() {
        rm -f -- "$cache_dir"/*
      }

      get_image() (
        cd "$cache_dir" && curl -sSLO "$1"
      )

      ### main ###

      [ -z "$1" ] && die "No arguments given"
      trap cleanup EXIT
      [ -d "$cache_dir" ] || mkdir -p -- "$cache_dir" || die
      while [ -n "$1" ]; do
        case "$1" in
          *://*.*) get_image "$1" ;;
          *) echo "Invalid url: $1" >&2 ;;
        esac
        shift
      done

      [ "$(find "$cache_dir" -type f -print | wc -l)" -ne 0 ] &&
      ${pkgs.nsxiv}/bin/nsxiv -a -p "$cache_dir"
    '';

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
    slurp # region select
    swappy # snapshot editor
    wl-clipboard # wl-copy and wl-paste from stdin/stdout
    cliphist # clipboard manager, supports images
    xclip # for some clipboard usecases in xwayland clients
    pcmanfm # file manager
    gnome.file-roller # archive manager
    feh # faster image viewer
    env-nsxiv env-nsxivDesktopItem nsxiv-url # image viewer (supports gif etc)
  ];

  # tells wob where the sock is
  home.sessionVariables = { WOBSOCK = "\${XDG_RUNTIME_DIR}/wob.sock"; };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "pcmanfm.desktop";
      "image/jpeg" = "feh.desktop";
      "image/gif" = "env-nsxiv.desktop";
      "image/bmp" = "feh.desktop";
      "image/png" = "feh.desktop";
      "image/tiff" = "feh.desktop";
      "image/webp" = "env-nsxiv.desktop";
      "image/avif" = "env-nsxiv.desktop";
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = rec {

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

      startup = [
        { command = "services-start"; }
	      { command = "wl-paste --watch cliphist store"; }
        { command = "${pkgs.autotiling}/bin/autotiling"; always = true; }
        { command = "foot --server"; }
        { command = "rm -f $WOBSOCK && mkfifo $WOBSOCK && tail -f $WOBSOCK | ${pkgs.wob}/bin/wob"; }
      ];

      modifier = "Mod4";
      floating.modifier = "Mod4";
      # Use as default launcher menu
      menu = "${pkgs.dmenu}/bin/dmenu_path | ${pkgs.wmenu}/bin/wmenu -b | xargs swaymsg exec --";
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

	        # clipboard manager
	        "${modifier}+Shift+v" = "cliphist list | ${pkgs.dmenu}/bin/dmenu_run -b | cliphist decode | wl-copy";
	        "${modifier}+Shift+b" = "cliphist list | ${pkgs.dmenu}/bin/dmenu_run -b | cliphist delete";

          # screen lock
          "${modifier}+Shift+s" = "exec ${pkgs.swaylock}/bin/swaylock -c 000000";

          # audio
          "XF86AudioRaiseVolume" = "exec ${soundctl} -ui 2 && ${soundctl} --get-volume > $WOBSOCK";
          "XF86AudioLowerVolume" = "exec ${soundctl} -ud 2 && ${soundctl} --get-volume > $WOBSOCK";
          "XF86AudioMute" = ''exec ${soundctl} --toggle-mute && ( [ "\$(${soundctl} - -get-mute) " = "true" ] && echo 0 > $WOBSOCK ) || ${soundctl} --get-volume > $WOBSOCK'';
          "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";

          # mpd
          "${modifier}+XF86AudioRaiseVolume" = "exec ${mpc} volume +5";
          "${modifier}+XF86AudioLowerVolume" = "exec ${mpc} volume -5";
          "${modifier}+XF86AudioPlay" = "exec ${mpc} toggle";
          "${modifier}+XF86AudioMute" = "exec ${mpc} next";

          # calculator
          "XF86Calculator" = "exec ${pkgs.speedcrunch}/bin/speedcrunch";

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
        "Right" = "resize shrink width 50px";
        "Up" = "resize grow height 50px";
        "Down" = "resize shrink height 50px";
        "Left" = "resize grow width 50px";
        "${right}" = "resize shrink width 50px";
        "${up}" = "resize grow height 50px";
        "${down}" = "resize shrink height 50px";
        "${left}" = "resize grow width 50px";
        "Shift+Right" = "resize shrink width 10px";
        "Shift+Up" = "resize grow height 10px";
        "Shift+Down" = "resize shrink height 10px";
        "Shift+Left" = "resize grow width 10px";
        "Shift+${right}" = "resize shrink width 10px";
        "Shift+${up}" = "resize grow height 10px";
        "Shift+${down}" = "resize shrink height 10px";
        "Shift+${left}" = "resize grow width 10px";

        "Return" = ''
          mode "default" '';
        "Escape" = ''
          mode "default" '';
      };
    };
  };
}
