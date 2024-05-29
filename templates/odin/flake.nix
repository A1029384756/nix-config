{
  description = "Odin Devshell";

  inputs = {
    nixpkgs.url      = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url  = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        nativeBuildInputs = with pkgs; [ 
          SDL2
          #put your env dependencies here
        ];
        buildInputs = with pkgs; [
          odin
          ols
          #put your runtime and build dependencies here
        ];
      in
      with pkgs;
      {
        devShells.default = mkShell {
          packages = nativeBuildInputs ++ buildInputs;
          LD_LIBRARY_PATH = "${lib.makeLibraryPath buildInputs}";
        };
      }
    );
}
