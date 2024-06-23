{ ... }: {
  services.swaync = {
    enable = true;
    style = ./style.css;
    settings = {
      positionX =  "right";
      positionY =  "top";
	    cssPriority =  "user";

      control-center-width =  380;
      control-center-height =  860; 
      control-center-margin-top =  2;
      control-center-margin-bottom =  2;
      control-center-margin-right =  1;
      control-center-margin-left =  0;

      notification-window-width =  400;
      notification-icon-size =  48;
      notification-body-image-height =  160;
      notification-body-image-width =  200;

      timeout =  4;
      timeout-low =  2;
      timeout-critical =  6;
      
      fit-to-screen =  false;
      keyboard-shortcuts =  true;
      image-visibility =  "when-available";
      transition-time =  200;
      hide-on-clear =  false;
      hide-on-action =  false;
      script-fail-notify =  true;
      scripts = {
        example-script = {
          exec =  "echo 'Do something...'";
          urgency = "Normal";
        };
      };
      notification-visibility = {
        example-name = {
          state =  "muted";
          urgency =  "Low";
          app-name = "Spotify";
        };
      };
      widgets = [
        "label"
        "buttons-grid"
        "mpris"
        "title"
        "dnd"
        "notifications"
      ];
      widget-config = {
        title = {
          text =  "Notifications";
          clear-all-button = true;
          button-text = " 󰎟 ";
        };
        dnd = {
          text = "Do not disturb";
        };
        label = {
          max-lines =  1;
          text = " ";
        };
        mpris = {
          image-size =  96;
          image-radius = 12;
        };
        volume = {
          label =  "󰕾";
          show-per-app = true;
        };
        buttons-grid = {
          actions = [
            {
              label =  " ";
              command = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
            }
            {
              label =  "";
              command = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
            }
            {
              label =  " ";
              command = "nm-connection-editor";
            }
            {
              label =  "󰂯";
              command = "blueman-manager";
            }
            {
              label =  "";
              command = "hyprctl dispatch exec hyprlock";
            }
          ];
        };
      };
    };
  };
}
