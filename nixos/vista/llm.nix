{ config, pkgs, ... }: {
  age.secrets.open-webui.file = ../../secrets/open-webui.age;
  services.ollama = {
    enable = true;
    package = pkgs.ollama-vulkan;
  };

  services.open-webui = {
    enable = true;
    environmentFile = config.age.secrets.open-webui.path;
  };

  services.caddy.virtualHosts = {
    "ollama.cstring.dev".extraConfig = ''
      reverse_proxy localhost:8080
    '';
  };
}
