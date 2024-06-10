{
  description = "Hayden's NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    catppuccin.url = "github:catppuccin/nix";

    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
    };
    walker.url = "github:abenz1267/walker";
    ags.url = "github:Aylur/ags";
    matugen.url = "github:InioX/matugen?ref=v2.2.0";

    heroic-theme.url = "github:catppuccin/heroic";
    heroic-theme.flake = false;

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, darwin, catppuccin, hyprland, ... }:
    let
      lib = nixpkgs.lib // home-manager.lib;
      systems = { nixos = lib.nixosSystem; darwin = darwin.lib.darwinSystem; };
      getOSMods = os: (
        if os == "nixos" then
          [
            catppuccin.nixosModules.catppuccin
          ]
        else if os == "darwin" then
          []
        else throw "Unsupported OS ${os}"
      );

      nixSystem = { device, config, user, os }:
        systems.${os} {
          specialArgs = { inherit user device inputs; };
          modules = [
	          ./${os}/${device}
	          home-manager."${os}Modules".home-manager {
	            home-manager.useGlobalPkgs = true;
	            home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit user inputs; };
	            home-manager.users.${user} = {
                imports = [
                  ./home-manager/${config}
                  catppuccin.homeManagerModules.catppuccin
                ];
              };
	            home-manager.backupFileExtension = "backup";
	          }
	        ] ++ getOSMods(os);
        };
    in
    {
      templates = import ./templates;

      nixosConfigurations = {
        g14 = nixSystem( { device = "g14"; config = "laptop"; user = "haydengray"; os = "nixos"; } );
        x270 = nixSystem( { device = "x270"; config = "laptop"; user = "haydengray"; os = "nixos"; } );
        rev3 = nixSystem( { device = "rev3"; config = "rev3"; user = "haydengray"; os = "nixos"; } );
      };

      darwinConfigurations = {
        nts1414 = nixSystem( { device = "NTS1414"; config = "macos"; user = "hgray"; os = "darwin"; } );
      };
    };
}
