{ ... }: {
  xdg.configFile.wofi = {
    source = ./conf;
    recursive = true;
    target = "wofi";
  };

  xdg.desktopEntries.shutdown = {
    name = "Power Off";
    icon = ./shutdown.svg;
    exec = "shutdown 0";
    terminal = false;
  };

  xdg.desktopEntries.suspend = {
    name = "Sleep";
    icon = ./suspend.svg;
    exec = "systemctl hibernate";
    terminal = false;
  };

  xdg.desktopEntries.restart = {
    name = "Restart";
    icon = ./reboot.svg;
    exec = "reboot";
    terminal = false;
  };
}
