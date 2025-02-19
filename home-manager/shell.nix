{ pkgs, ... }:
{
  catppuccin.fish.enable = true;
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      fish_add_path ~/Odin
      fish_add_path ~/ols

      function dev 
        nix develop $argv --command fish
      end

      function man
        # based on this group of settings and explanation for them:
        # http://boredzo.org/blog/archives/2016-08-15/colorized-man-pages-understood-and-customized
        # converted to Fish shell syntax thanks to this page:
        # http://askubuntu.com/questions/522599/how-to-get-color-man-pages-under-fish-shell/650192
      
        # start of bold:
        set -x LESS_TERMCAP_md (set_color --bold blue)
        # end of all formatting:
        set -x LESS_TERMCAP_me (set_color normal)
      
        # start of standout (inverted colors):
        #set -x LESS_TERMCAP_so (set_color --reverse)
        # end of standout (inverted colors):
        #set -x LESS_TERMCAP_se (set_color normal)
        # (no change – I like the default)
      
        # start of underline:
        #set -x LESS_TERMCAP_us (set_color --underline)
        # end of underline:
        #set -x LESS_TERMCAP_ue (set_color normal)
        # (no change – I like the default)
        command man $argv
      end
    '';
    shellAliases = {
      cat = "bat";
      ls = "eza --icons -F -H --group-directories-first --git -h";
      vi = "nvim";
      vim = "nvim";
    };
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };
    fzf = {
      enable = true;
      enableFishIntegration = true;
    };
    starship.enable = true;
    bat.enable = true;
    awscli.enable = true;
  };

  home.packages = with pkgs; [
    fd
    jq
    eza
    ripgrep
  ];
}
