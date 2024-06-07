{ pkgs, ... }: {
  imports = [
    ./ags
    ./walker
    ./waybar
  ];

  home.sessionVariables = {
    TERMINAL = "kitty";
  };

  xdg.desktopEntries."org.gnome.Settings" = {
    name = "Gnome Settings";
    comment = "Gnome Control Center";
    icon = "org.gnome.Settings";
    exec = "env XDG_CURRENT_DESKTOP=gnome ${pkgs.gnome.gnome-control-center}/bin/gnome-control-center";
    categories = ["X-Preferences"];
    terminal = false;
  };

  home.packages = with pkgs; [
    gnome.gnome-control-center
  ];

  home.pointerCursor= {
    gtk.enable = true;
    package = pkgs.gnome.adwaita-icon-theme;
    name = "Adwaita";
    size = 16;
  };

  wayland.windowManager.hyprland = let 
    mod = "SUPER";
  in {
    enable = true;
    catppuccin.enable = true;
    settings = {
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.inactive_border" = "$surface2";
        "col.active_border" = "$lavender";
        layout = "dwindle";
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      decoration = {
        rounding = 10;
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
        "ags -b hypr"
      ];

      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      ];

      windowrulev2 = [
        "tile,class:(kitty)"
      ];

      monitor = [
        "DP-1,2560x1440@144,0x650,1"
        "DP-3,2560x1080@60,2560x0,1,transform,3"
      ];

      bind = let 
        e = "exec, ags -b hypr";
      in [
        "CTRL,Q,killactive," 
        "CTRL SHIFT, R, ${e} quit; ags -b hypr"

        "${mod}, Print, ${e} -r 'recorder.start()'"
        ", Print, ${e} -r 'recorder.screenshot()'"
        "SHIFT, Print, ${e} -r 'recorder.screenshot(true)'"

        "${mod}, R, exec, walker"

        "${mod} SHIFT, R, exec, hyprctl reload"
        "${mod}, F, exec, firefox"
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
      ] ++ (
        builtins.concatLists (
          builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
                in
                builtins.toString (x + 1 - (c * 10));
            in [
              "${mod}, ${ws}, workspace, ${toString (x + 1)}"
              "${mod} SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          ) 
        10)
      );

      bindm = [
        "${mod},mouse:272,movewindow"
        "${mod} SHIFT,mouse:272,resizewindow"
      ];
    };
  };
}
