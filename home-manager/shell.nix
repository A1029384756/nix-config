{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    catppuccin.enable = true;
    interactiveShellInit = ''
      set fish_greeting
      fish_add_path ~/Odin
      fish_add_path ~/ols
    '';
    shellAliases = {
      ls = "eza --icons -F -H --group-directories-first --git -h";
      cat = "bat";
      dev = "nix develop --command fish";
      find = "fd $argv";
    };
  };

  programs.starship = {
    enable = true;
    catppuccin.enable = true;
  };

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.bat = {
    enable = true;
    catppuccin.enable = true;
  };

  programs.awscli.enable = true;

  home.packages = with pkgs; [
    fd
    jq
    eza
    ripgrep
  ];
}
