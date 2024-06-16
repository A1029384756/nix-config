{ pkgs, ... }: {
  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "kitty";
  };

  environment = {
    systemPackages = with pkgs; [ gnome.nautilus gnome.nautilus-python];
    pathsToLink = [
      "/share/nautilus-python/extensions"
    ];
    sessionVariables = {
      NAUTILUS_4_EXTENSION_DIR = "${pkgs.gnome.nautilus-python}/lib/nautilus/extensions-4";
    };
  };
}
