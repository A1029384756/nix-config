{
  services = {
    aerospace = {
      enable = true;
      settings = {
        gaps = {
          inner = {
            horizontal = 8;
            vertical = 8;
          };
          outer = {
            left = 8;
            bottom = 8;
            top = 8;
            right = 8;
          };
        };

        mode.main.binding = {
          alt-slash = "layout tiles horizontal vertical";
          alt-comma = "layout accordion horizontal vertical";

          alt-h = "focus --boundaries all-monitors-outer-frame left";
          alt-j = "focus --boundaries all-monitors-outer-frame down";
          alt-k = "focus --boundaries all-monitors-outer-frame up";
          alt-l = "focus --boundaries all-monitors-outer-frame right";

          alt-shift-h = "move left";
          alt-shift-j = "move down";
          alt-shift-k = "move up";
          alt-shift-l = "move right";

          alt-shift-minus = "resize smart -50";
          alt-shift-equal = "resize smart +50";

          alt-tab = "workspace prev";
          alt-shift-tab = "move-node-to-workspace prev";
          alt-enter = "workspace next";
          alt-shift-enter = "move-node-to-workspace next";
          alt-shift-semicolon = "mode service";
        } // builtins.listToAttrs (
          builtins.concatLists (builtins.genList
            (i:
              let ws = toString i;
              in
              [
                { name = "alt-${ws}"; value = "workspace ${ws}"; }
                { name = "alt-shift-${ws}"; value = "move-node-to-workspace ${ws}"; }
              ]) 9));

        mode.service.binding = {
          esc = [ "reload-config" "mode main" ];
          r = [ "flatten-workspace-tree" "mode main" ];
          f = [ "layout floating tiling" "mode main" ];
          backspace = [ "close-all-windows-but-current" "mode main" ];
          alt-shift-h = [ "join-with left" "mode main" ];
          alt-shift-j = [ "join-with down" "mode main" ];
          alt-shift-k = [ "join-with up" "mode main" ];
          alt-shift-l = [ "join-with right" "mode main" ];
        };

        on-window-detected = [
          {
            check-further-callbacks = true;
            "if" = {
              app-id = "com.catonetworks.mac.CatoClient";
              app-name-regex-substring = "CatoClient";
            };
            run = [
              "layout tiling"
            ];
          }
        ];
      };
    };

    jankyborders = {
      enable = true;
      active_color = "0xffb4befe";
      inactive_color = "#ff585b70";
      width = 3.0;
    };
  };
}
