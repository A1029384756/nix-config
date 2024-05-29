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
      nixosModules = { device, config }: [
	        ./nixos/${device}
	        home-manager.nixosModules.home-manager {
	          home-manager.useGlobalPkgs = true;
	          home-manager.useUserPackages = true;
	          home-manager.users.haydengray = {
              imports = [
                ./home-manager/${config}
                catppuccin.homeManagerModules.catppuccin
              ];
            };
	          home-manager.backupFileExtension = "backup";
	        }
	      ];
    in
    {
      templates = import ./templates;
      overlays = import ./overlays { inherit inputs; };
      packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });

      nixosConfigurations = {
        g14 = lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = nixosModules( { device = "g14"; config = "laptop"; } );
        };
        x270 = lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = nixosModules( { device = "x270"; config = "laptop"; } );
        };
        rev3 = lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = nixosModules( { device = "rev3"; config = "rev3"; } );
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

	            home-manager.users.hgray = {
                imports = [
                  ./home-manager/macos
                  catppuccin.homeManagerModules.catppuccin
                ];
              };
	            home-manager.backupFileExtension = "backup";
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
