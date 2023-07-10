{ pkgs ? import <nixpkgs> { } }: {
  catppuccin-gtk-mocha = pkgs.callPackage ./catppuccin-gtk.nix { };
}
