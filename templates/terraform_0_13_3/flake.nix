{
  description = "A flake for Terraform 0.13.3";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };
  outputs =
    { self, nixpkgs }:
    let
      pkgs = import nixpkgs { inherit system; };
      system = "x86_64-linux";
    in
    {
      devShell.${system} = pkgs.mkShell {
        buildInputs = with pkgs; [
          curl
          (pkgs.callPackage ./terraform_0_13_3.nix { })
          tflint
          unzip
        ];
      };
    };
}
