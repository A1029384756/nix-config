{
  description = "C++ Devshell and Builds";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };

        llvm = pkgs.llvmPackages_latest;

        nativeBuildInputs = with pkgs; [
          catch2
          clang-tools
          cmake
          cmake-language-server
          gdb
          gcc
          gnumake
          pkg-config
          #put your env dependencies here
        ];
        buildInputs = with pkgs; [
          #put your runtime and build dependencies here
        ];
        commonArgs = {
          inherit buildInputs nativeBuildInputs;
        };
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
