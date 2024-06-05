{ pkgs, ... }: {
  imports = [
    ./waybar
  ];

  home.packages = with pkgs; [ gnome.gnome-control-center ];
  programs.wofi.enable = true;
  programs.rofi.catppuccin.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    catppuccin.enable = true;
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
      };

      input = {
        accel_profile = "flat";
      };

      misc = {
        vrr = 1;
      };

      exec-once = [
        "waybar"
      ];

      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        "XDG_CURRENT_DESKTOP,GNOME"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
      ];

      windowrulev2 = [
        "tile,class:(kitty)"
      ];

      monitor = [
        "DP-1,2560x1440@144,0x0,1"
        "HDMI-A-1,2560x1080,2560x-650,1,transform,3"

        "DP-4,2560x1440@144,0x0,1"
        "HDMI-A-2,2560x1080,2560x-650,1,transform,3"
      ];

      "$mod" = "SUPER";
      bind = [
        "$mod, R, exec, wofi --show drun"

        "$mod, F, exec, firefox"
        "$mod, T, exec, kitty"
        "$mod, mouse:272, movewindow"
        "$mod, V, togglefloating"

        "$mod, h, movefocus, l"
        "$mod, j, movefocus, d"
        "$mod, k, movefocus, u"
        "$mod, l, movefocus, r"
        "$mod SHIFT, h, movewindow, l"
        "$mod SHIFT, j, movewindow, d"
        "$mod SHIFT, k, movewindow, u"
        "$mod SHIFT, l, movewindow, r"
      ] ++ (
        builtins.concatLists (
          builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
                in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          ) 
        10)
      );
    };
  };
}
