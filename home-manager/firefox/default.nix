{ config, pkgs, ... }: {
  home.file.firefox-cascade-theme = {
    target = ".mozilla/firefox/default/chrome/firefox-theme/userChrome.css";
    source = ./conf/userChrome.css;
  };

  programs.firefox = {
    enable = true;
    profiles.default = {
      userChrome = builtins.readFile ./conf/userChrome.css;
      settings = {
        "extensions.pocket.enabled" = false;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "layers.acceleration.force-enabled" = true;
        "gfx.webrender.all" = true;
        "svg.context-properties.content.enabled" = true;
      };
    };
  };
}
