{ config, pkgs, ... }: {
  home.packages = with pkgs; [ armcord discord vesktop ];
}
