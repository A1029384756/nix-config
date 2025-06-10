{
  programs.waybar = {
    enable = true;
    style = builtins.readFile (./style.css);
    settings.mainBar = {
      margin = "0px 0px -10px 0px";
      layer = "top";

      modules-left = [
        "custom/wmname"
        "tray"
        "hyprland/workspaces"
      ];
      modules-center = [ "clock" ];
      modules-right = [
        "cpu"
        "temperature"
        "memory"
        "pulseaudio"
        "custom/notification"
      ];

      "hyprland/workspaces" = {
        active-only = "false";
        on-scroll-up = "hyprctl dispatch workspace e+1";
        on-scroll-down = "hyprctl dispatch workspace e-1";
        disable-scroll = "false";
        all-outputs = "true";
        format = "{id}:{windows}";
        window-rewrite-default = "";
        window-rewrite = {
          "class<firefox>" = "󰈹";
          "class<kitty>" = "";
          "title<.*Yazi.*>" = "󰇥";
          "class<discord>" = "";
          "class<obsidian>" = "";
          "class<org.gnome.Calculator>" = "";
          "class<org.telegram.desktop>" = "";
          "class<transmission.gtk>" = "";
          "class<nemo>" = "";
          "class<com.usebottles.bottles>" = "󰡔󱌐";
          "class<localsend_app>" = "󱗿";
        };
        on-click = "activate";
      };

      "tray" = {
        spacing = 8;
      };

      "clock" = {
        tooltip-format = "<tt><small>{calendar}</small></tt>";
        format = "{:%a %b %d %H:%M}";
        calendar = {
          mode = "year";
          mode-mon-col = 3;
          on-scroll = 1;
          format = {
            months = "<span color='#458588'><b>{}</b></span>";
            days = "<span color='#ebdbb2'><b>{}</b></span>";
            weeks = "<span color='#458588'><b>{}</b></span>";
            today = "<span color='#cc241d'><b>{}</b></span>";
          };
        };
      };

      "cpu" = {
        format = " {usage}%";
        tooltip = "false";
      };

      "temperature" = {
        format = "󰔐 {temperatureC}°C";
        critical-threshold = 50;
      };

      "memory" = {
        format = " {}%";
      };

      "pulseaudio" = {
        format = "{icon}{volume}% {format_source}";
        format-bluetooth = "{icon} {volume}%";
        format-bluetooth-muted = "   {volume}%";
        format-source = "";
        format-source-muted = "";
        format-muted = " {volume}% {format_source}";
        format-icons = {
          headphone = " ";
          default = [
            " "
            " "
            " "
          ];
        };
        tooltip-format = "{desc} {volume}%";
        on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
        on-click-right = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        on-click-middle = "pavucontrol";
      };

      "custom/wmname" = {
        format = " ";
        tooltip = "false";
        on-click = "wallpaper";
      };

      "custom/notification" = {
        tooltip = false;
        format = "{icon}";
        format-icons = {
          notification = "<span foreground='red'><sup></sup></span>";
          none = "";
          dnd-notification = "<span foreground='red'><sup></sup></span>";
          dnd-none = "";
          inhibited-notification = "<span foreground='red'><sup></sup></span>";
          inhibited-none = "";
          dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
          dnd-inhibited-none = "";
        };
        return-type = "json";
        exec-if = "which swaync-client";
        exec = "swaync-client -swb";
        on-click = "swaync-client -t -sw";
        on-click-right = "swaync-client -d -sw";
        escape = true;
      };
    };
  };
}
