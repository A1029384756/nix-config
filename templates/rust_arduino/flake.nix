{
  description = "Rust Devshell and Builds";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
  };

  outputs =
    { nixpkgs
    , rust-overlay
    , flake-utils
    , ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs { inherit system overlays; };
        toolchain = pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;
        nativeBuildInputs = with pkgs; [
          pkg-config
          rust-analyzer-unwrapped
          toolchain
          #put your env dependencies here
        ];
        buildInputs = with pkgs; [
          gcc
          pkgsCross.avr.buildPackages.gcc
          avrdude
          ravedude
          #put your runtime and build dependencies here
        ];
        commonArgs = {
          inherit buildInputs nativeBuildInputs;
        };
      in
      with pkgs;
      {
        devShells.default = mkShell {
          inputsFrom = [ commonArgs ];
          LD_LIBRARY_PATH = "${lib.makeLibraryPath buildInputs}";
        };
      }
    );
}
