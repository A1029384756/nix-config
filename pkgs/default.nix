{ pkgs ? import <nixpkgs> { } }: {
  catppuccin-gtk-mocha = pkgs.callPackage ./gtk.nix { };
}
