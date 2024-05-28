{ config, pkgs, ... }: {
  programs.firefox = {
    enable = true;
    profiles.default = {
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
