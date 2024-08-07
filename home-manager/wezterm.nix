{ config, pkgs, ... }:
{
  home.file.".config/wezterm" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/dotfiles/config/wezterm";
    recursive = true;
  };

  home.packages = with pkgs; if config.nixGL.prefix == "" then [
    (config.lib.nixGL.wrap wezterm)
    # [TODO] update with CN when in nixpkgs
    maple-mono-NF
  ] else [ wezterm ];
}
