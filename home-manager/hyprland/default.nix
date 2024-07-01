{ pkgs, ... }:
{
  imports = [
    ../walker.nix
    ./rofi
    ./waybar
    ./swaync
    ./hyprlock
  ];

  home.sessionVariables = {
    TERMINAL = "kitty";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };

  home.packages = with pkgs; [ hyprnome ];

  wayland.windowManager.hyprland =
    let
      mod = "ALT";
    in
    {
      enable = true;
      settings = {
        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;
          layout = "dwindle";
        };

        dwindle = {
          pseudotile = "yes";
          preserve_split = "yes";
        };

        decoration = {
          rounding = 10;
          blur = {
            size = 4;
            passes = 2;
          };
        };

        input = {
          accel_profile = "flat";
        };

        misc = {
          vrr = 1;
          disable_splash_rendering = true;
          force_default_wallpaper = 2;
        };

        bezier = [
          "easeOutCirc,0,0.55,0.45,1"
          "easeInOutCubic,0.65,0,0.35,1"
        ];

        animation = [
          "windowsIn,1,2,easeOutCirc,popin 60%"
          "windowsOut,1,2,easeOutCirc,popin 60%"
          "windowsMove,1,3,easeInOutCubic,popin"
          "fadeIn,1,1,easeOutCirc"
          "fadeOut,0,1,easeOutCirc"
          "workspaces,1,2,easeOutCirc,slide"
        ];

        xwayland.force_zero_scaling = true;

        exec-once = [
          "swaync"
          "waybar"
          "blueman-applet"
          "udiskie"
          "nm-applet"
          "wl-paste --watch cliphist store"
        ];

        env = [
          "LIBVA_DRIVER_NAME,nvidia"
          "GBM_BACKEND,nvidia-drm"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
          "XDG_SESSION_TYPE,wayland"
          "WLR_NO_HARDWARE_CURSORS, 1"
          "XDG_CURRENT_DESKTOP, Hyprland"
          "XDG_SESSION_DESKTOP, Hyprland"
        ];

        layerrule = [
          "blur, wofi"
          "blur, rofi"
          "blur, swaync-control-center"
          "blur, swaync-notification-window"
          "ignorezero, swaync-control-center"
          "ignorezero, swaync-notification-window"
          "ignorealpha 0.5, swaync-control-center"
          "ignorealpha 0.5, swaync-notification-window"
        ];

        windowrulev2 = [
          "tile,class:(kitty)"
          "suppressevent maximize, class:.*"
          "float,class:(org.gnome.Calculator),title:(Calculator)"
          "float,class:(pavucontrol)"
          "float,class:(Yad_v13_0)"
          "float,class:(.blueman-manager-wrapped)"
          "float,class:(blueberry.py)"
        ];

        monitor = [
          "DP-1,2560x1440@144,0x650,1"
          "DP-3,2560x1080@60,2560x0,1,transform,3"
          "DP-4,2560x1440@144,0x650,1"
          "DP-6,2560x1080@60,2560x0,1,transform,3"
        ];

        bind = [
          "CTRL,Q,killactive,"
          "CTRL SHIFT, R, exec, pkill waybar && hyprctl dispatch exec waybar"

          ", Print, exec, grimblast copysave area"
          "SHIFT, Print, exec, grimblast copysave screen"

          "${mod}, R, exec, walker"
          "${mod} SHIFT, R, exec, rofi-menu"

          "${mod}, F, exec, firefox"
          "${mod} SHIFT, F, fullscreen"
          "${mod}, T, exec, kitty"
          "${mod}, mouse:272, movewindow"
          "${mod}, V, togglefloating"

          "${mod}, h, movefocus, l"
          "${mod}, j, movefocus, d"
          "${mod}, k, movefocus, u"
          "${mod}, l, movefocus, r"
          "${mod} SHIFT, h, movewindow, l"
          "${mod} SHIFT, j, movewindow, d"
          "${mod} SHIFT, k, movewindow, u"
          "${mod} SHIFT, l, movewindow, r"

          "ALT, Tab, exec, hyprnome --previous"
          "ALT, Return, exec, hyprnome"
          "ALT SHIFT, Tab, exec, hyprnome --previous --move"
          "ALT SHIFT, Return, exec, hyprnome --move"
        ];

        bindm = [
          "${mod},mouse:272,movewindow"
          "${mod} SHIFT,mouse:272,resizewindow"
        ];
      };
    };
}
