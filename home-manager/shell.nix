{ config, pkgs, ... }: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      fish_add_path ~/Odin
      fish_add_path ~/ols
    '';
    shellAliases = {
      ls = "eza --icons -F -H --group-directories-first --git -h $argv";
      cat = "bat --theme base16-256";
      vi = "nvim $argv";
      dev = "nix develop --command fish";
      find = "fd $argv";
    };
  };

  programs.starship.enable = true;

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };
}
