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

  virtualisation.quadlet =
    let
      inherit (config.virtualisation.quadlet) volumes;
    in
    {
      containers = {
        comfyui.containerConfig = {
          image = "ghcr.io/a1029384756/comfyui-docker:latest";
          pull = "newer";
          devices = [
            "/dev/dri"
          ];
          publishPorts = [
            "8188:8188"
          ];
          volumes = [
            "${volumes.comfyuiModels.ref}:/app/models"
            "${volumes.comfyuiUser.ref}:/app/user"
            "${volumes.comfyuiCustomNodes.ref}:/app/custom_nodes"
          ];
          environments = {
            LOW_VRAM = "1";
          };
        };
      };
      volumes = {
        comfyuiModels.volumeConfig = {
          type = "bind";
          device = "/mnt/data/comfyui/models";
        };
        comfyuiUser.volumeConfig = {
          type = "bind";
          device = "/mnt/data/comfyui/user";
        };
        comfyuiCustomNodes.volumeConfig = {
          type = "bind";
          device = "/mnt/data/comfyui/custom_nodes";
        };
      };
    };

  networking.firewall.allowedTCPPorts = [ 8188 ];
}
