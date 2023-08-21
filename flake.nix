{
  description = "Hayden's NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forEachSystem = f: lib.genAttrs systems (sys: f pkgsFor.${sys});
      pkgsFor = nixpkgs.legacyPackages;
    in {
      templates = import ./templates;
      overlays = import ./overlays { inherit inputs; };
      packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });

      nixosConfigurations = {
        g14 = lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./nixos/g14 ];
        };
        x270 = lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./nixos/x270 ];
        };
      };

      homeConfigurations = {
        "haydengray@laptop" = lib.homeManagerConfiguration {
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home-manager/laptop ];
        };
        "haydengray@wsl" = lib.homeManagerConfiguration {
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ 
            inputs.nix-index-database.hmModules.nix-index
            ./home-manager/wsl 
          ];
        };
      };
  };
}
