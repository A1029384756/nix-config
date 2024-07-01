{ config, ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      background = [
        {
          monitor = "";
          path = "${config.home.homeDirectory}/nix-config/assets/bg.png";
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "300, 50";
          outline_thickness = 0;
          inner_color = "rgb(585b70)";
          font_color = "rgb(cdd6f4)";
          fade_on_empty = false;
          placeholder_text = ''Password:'';
          dots_spacing = 0.3;
          dots_center = true;
          position = "0, -440";
        }
      ];

      label = [
        {
          monitor = "";
          text = "$TIME";
          font_size = 50;
          color = "rgb(b4befe)";
          position = "0, 440";
          valign = "center";
          halign = "center";
        }
      ];
    };
  };
}
