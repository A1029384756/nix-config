{ inputs, ... }: {
  gtk = {
    enable = true;
    catppuccin = {
      enable = true;
      cursor.enable = true;
      icon.enable = true;
      gnomeShellTheme = true;
    };
  };
}
