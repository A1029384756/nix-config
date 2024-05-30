{
  description = "Python 3.11 Devshell and Builds";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        pyEnv = pkgs.python311.withPackages (ps: with ps; [
          python-lsp-server
        ] ++ python-lsp-server.optional-dependencies.all);
      in
      with pkgs;
      {
        devShells = {
          default = mkShell {
            packages = [
              pyEnv
            ];
          };
        };
      }
    );
}
