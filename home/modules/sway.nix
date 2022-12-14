{ config, lib, pkgs, ... }:

let
  # bash script to let dbus know about important env variables and
  # propagate them to relevent services run at the end of sway config
  # see
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  # note: this is pretty much the same as  /etc/sway/config.d/nixos.conf but also restarts
  # some user services to make sure they have the correct environment variables
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
    '';
  };

  # currently, there is some friction between sway and gtk:
  # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  # the suggested way to set gtk settings is with gsettings
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  # run at the end of sway config
  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text =
      let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsettings-schemas/${schema.name}";
      in
      ''
        export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
        gnome_schema=org.gnome.desktop.interface
        gsettings set $gnome_schema gtk-theme 'Dracula'
      '';
  };

in
{
  imports = [ ./foot.nix ];

  home.packages = with pkgs; [
    dbus-sway-environment
    configure-gtk
    (nerdfonts.override { fonts = [ "FiraCode" ]; }) # term and glyphs
    noto-fonts-cjk-sans # asian characters
    noto-fonts-emoji # google emojis
    wayland
    libsForQt5.qtwayland
    glib # gsettings
    dracula-theme # gtk theme
    # gnome3.adwaita-icon-theme # default gnome cursors
    swayidle
    wf-recorder # screenrecorder
    swappy # snapshot editor
    wl-clipboard # wl-copy and wl-paste from stdin/stdout
    mako # notification daemon
    pcmanfm # file manager
    gnome.file-roller # archive manager
    mpv # video player
    imv # image viewer
    oneko # silly cat
  ];

  # enable custom fonts
  fonts.fontconfig.enable = true;
  # cursor theme
  home.file." .icons/default ".source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ";
  # for wob
  home.sessionVariables = { WOBSOCK = "\${XDG_RUNTIME_DIR}/wob.sock"; };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "pcmanfm.desktop";
      "image/gif" = "imv.desktop";
      "image/png" = "imv.desktop";
      "image/jpeg" = "imv.desktop";
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = rec {

      output."*".bg = "${../../assets/wallpapers/1920x1080-green_frog.jpg} fill";

      fonts = {
        names = [ "FiraCode Nerd Font" ];
        size = 11.0;
      };

      defaultWorkspace = "workspace number 1";
      assigns = { "1: web" = [{ class = "^Firefox$"; }]; };

      startup = [
        # Launch on start
        { command = "dbus-sway-environment"; }
        { command = "configure-gtk"; }
        { command = "${pkgs.autotiling}/bin/autotiling"; always = true; }
        { command = "${pkgs.gammastep}/bin/gammastep -m wayland -l 7:-34 -t 6500:3000"; always = true; }
        { command = "rm -f $WOBSOCK && mkfifo $WOBSOCK && tail -f $WOBSOCK | ${pkgs.wob}/bin/wob"; }
        { command = "foot --server"; always = true; }
        { command = "firefox"; }
      ];

      modifier = "Mod4";
      floating.modifier = "Mod4";
      # Use as default launcher menu
      menu = "${pkgs.wofi}/bin/wofi -I --show drun | xargs swaymsg exec --";
      # Use as default terminal
      terminal = "footclient";
      # navkeys
      left = "h";
      down = "j";
      up = "k";
      right = "l";

      keybindings = {
        "${modifier}+Return" = "exec ${terminal}";
        "${modifier}+d" = "exec ${menu}";

        # audio
        "XF86AudioRaiseVolume" = "exec ${pkgs.pamixer}/bin/pamixer -ui 2 && ${pkgs.pamixer}/bin/pamixer --get-volume > $WOBSOCK";
        "XF86AudioLowerVolume" = "exec ${pkgs.pamixer}/bin/pamixer -ud 2 && ${pkgs.pamixer}/bin/pamixer --get-volume > $WOBSOCK";
        "XF86AudioMute" = ''exec ${pkgs.pamixer}/bin/pamixer --toggle-mute && ( [ "\$(${pkgs.pamixer}/bin/pamixer - -get-mute) " = "true" ] && echo 0 > $WOBSOCK ) || ${pkgs.pamixer}/bin/pamixer --get-volume > $WOBSOCK'';
        "XF86AudioPlay " = "exec ${pkgs.playerctl}/bin/playerctl play-pause";

        # screen capture
        "Print" = "exec ${pkgs.grim}/bin/grim - | wl-copy -t image/png";
        "${modifier}+Print" = "exec ${pkgs.grim}/bin/grim - | swappy -f -";
        "${modifier}+g" = ''exec ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | swappy -f -'';

        "${modifier}+Shift+c" = "reload";

        "${modifier}+Shift+q" = "kill";
        "${modifier}+Shift+e" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'";

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
    '';
  };
}
