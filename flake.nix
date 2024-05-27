{
  description = "Hayden's NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    catppuccin.url = "github:catppuccin/nix";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, darwin, catppuccin, ... }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];
      forEachSystem = f: lib.genAttrs systems (sys: f pkgsFor.${sys});
      pkgsFor = nixpkgs.legacyPackages;
    in
    {
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
        rev3 = lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
	          ./nixos/rev3 
	          home-manager.nixosModules.home-manager {
	            home-manager.useGlobalPkgs = true;
	            home-manager.useUserPackages = true;
	            home-manager.users.haydengray = {
                imports = [
                  ./home-manager/rev3
                  catppuccin.homeManagerModules.catppuccin
                ];
              };
	            home-manager.backupFileExtension = "backup";
	          }
	        ];
        };
      };

      darwinConfigurations = {
        macos = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./darwin
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.hgray = import ./home-manager/macos;
            }
          ];
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
