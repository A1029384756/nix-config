{ pkgs, ... }: {
  imports = [
    ./ags
    ./walker
  ];

  home.sessionVariables = {
    TERMINAL = "kitty";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
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
    hyprnome
  ];

  home.pointerCursor= {
    gtk.enable = true;
    package = pkgs.gnome.adwaita-icon-theme;
    name = "Adwaita";
    size = 16;
  };

  wayland.windowManager.hyprland = let 
    mod = "SUPER";
    mov = "ALT";
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
        "DP-4,2560x1440@144,0x650,1"
        "DP-6,2560x1080@60,2560x0,1,transform,3"
      ];

      bind = let 
        e = "exec, ags -b hypr";
      in [
        "CTRL,Q,killactive," 
        "CTRL SHIFT, R, ${e} quit; ags -b hypr"

        "${mov}, Print, ${e} -r 'recorder.start()'"
        ", Print, ${e} -r 'recorder.screenshot()'"
        "SHIFT, Print, ${e} -r 'recorder.screenshot(true)'"

        "${mov}, R, exec, walker"

        "${mov} SHIFT, R, exec, hyprctl reload"
        "${mov}, F, exec, firefox"
        "${mov}, T, exec, kitty"
        "${mov}, mouse:272, movewindow"
        "${mov}, V, togglefloating"

        "${mov}, h, movefocus, l"
        "${mov}, j, movefocus, d"
        "${mov}, k, movefocus, u"
        "${mov}, l, movefocus, r"
        "${mov} SHIFT, h, movewindow, l"
        "${mov} SHIFT, j, movewindow, d"
        "${mov} SHIFT, k, movewindow, u"
        "${mov} SHIFT, l, movewindow, r"

        "ALT, Tab, exec, hyprnome --previous"
        "ALT, Return, exec, hyprnome"
        "ALT SHIFT, Tab, exec, hyprnome --previous --move"
        "ALT SHIFT, Return, exec, hyprnome --move"
      ];

      bindm = [
        "${mov},mouse:272,movewindow"
        "${mov} SHIFT,mouse:272,resizewindow"
      ];
    };
  };
}
