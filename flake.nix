{
  description = "Hayden's NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    blog.url = "github:A1029384756/blog";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    foundryvtt.url = "github:reckenrode/nix-foundryvtt";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    quadlet-nix.url = "github:SEIAROTg/quadlet-nix";
		headscale.url = "github:juanfont/headscale";
    wedding.url = "git+ssh://git@github.com/A1029384756/hayden_anna_wedding?shallow=1";
    wedding.flake = false;

    catppuccin.url = "github:catppuccin/nix";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{ nixpkgs
    , home-manager
    , agenix
    , darwin
    , disko
    , catppuccin
    , nix-minecraft
    , quadlet-nix
		, headscale
    , ...
    }:
    let
      lib = nixpkgs.lib // home-manager.lib;
      systems = {
        nixos = lib.nixosSystem;
        darwin = darwin.lib.darwinSystem;
      };
      getOSMods =
        os:
        (
          if os == "nixos" then
            [
              catppuccin.nixosModules.catppuccin
              agenix.nixosModules.default
              disko.nixosModules.disko
              quadlet-nix.nixosModules.quadlet
              nix-minecraft.nixosModules.minecraft-servers
							headscale.nixosModules.default
              {
                nixpkgs.overlays = [ nix-minecraft.overlay ];
              }
            ]
          else if os == "darwin" then
            [ ]
          else
            throw "Unsupported OS ${os}"
        );

      nixSystem =
        { device
        , config
        , user
        , os
        ,
        }:
        systems.${os} {
          specialArgs = {
            inherit user device inputs;
          };
          modules = [
            ./${os}/${device}
            home-manager."${os}Modules".home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit user inputs;
                };
                backupFileExtension = "backup";
                users.${user} = {
                  imports = [
                    ./home-manager/${config}
                    catppuccin.homeModules.catppuccin
                  ];
                };
              };
            }
          ] ++ getOSMods os;
        };
    in
    {
      nixosConfigurations = {
        vista = nixSystem {
          device = "vista";
          config = "vista";
          user = "haydengray";
          os = "nixos";
        };
        vista-vps = nixSystem {
          device = "vista-vps";
          config = "vista-vps";
          user = "haydengray";
          os = "nixos";
        };
      };

      darwinConfigurations = {
        nts1414 = nixSystem {
          device = "NTS1414";
          config = "macos";
          user = "hgray";
          os = "darwin";
        };
        minibubbles = nixSystem {
          device = "MINIBUBBLES";
          config = "macos";
          user = "haydengray";
          os = "darwin";
        };
      };
    };
}
