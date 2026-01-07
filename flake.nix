{
  description = "Hayden's NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";

    agenix.url = "github:ryantm/agenix";

    catppuccin.url = "github:catppuccin/nix";

    wedding.url = "github:A1029384756/hayden_anna_wedding";
    wedding.flake = false;
    blog.url = "github:A1029384756/cstring.dev.blog";
    blog.flake = false;

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    walker.url = "github:abenz1267/walker";
    walker.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    nixos-cosmic.inputs.nixpkgs.follows = "nixpkgs";

    foundryvtt.url = "github:reckenrode/nix-foundryvtt";

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";

    nixGL.url = "github:nix-community/nixGL";
    nixGL.inputs.nixpkgs.follows = "nixpkgs";

    heroic-theme.url = "github:catppuccin/heroic";
    heroic-theme.flake = false;

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    quadlet-nix.url = "github:SEIAROTg/quadlet-nix";
		headscale.url = "github:juanfont/headscale";
  };

  outputs =
    inputs@{ nixpkgs
    , home-manager
    , agenix
    , darwin
    , disko
    , catppuccin
    , nixGL
    , nix-minecraft
    , nixos-cosmic
    , stylix
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
              nixos-cosmic.nixosModules.default
              agenix.nixosModules.default
              stylix.nixosModules.stylix
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
      templates = import ./templates;

      nixosConfigurations = {
        g14 = nixSystem {
          device = "g14";
          config = "laptop";
          user = "haydengray";
          os = "nixos";
        };
        x270 = nixSystem {
          device = "x270";
          config = "laptop";
          user = "haydengray";
          os = "nixos";
        };
        rev3 = nixSystem {
          device = "rev3";
          config = "rev3";
          user = "haydengray";
          os = "nixos";
        };
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

      homeConfigurations = {
        fedora = lib.homeManagerConfiguration {
          extraSpecialArgs = { inherit inputs; };
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [ nixGL.overlay ];
          };
          modules = [
            catppuccin.homeModules.catppuccin
            ./home-manager/rev3-fedora.nix
          ];
        };
        fedora-anna = lib.homeManagerConfiguration {
          extraSpecialArgs = { inherit inputs; };
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [ nixGL.overlay ];
          };
          modules = [
            catppuccin.homeModules.catppuccin
            ./home-manager/g14-fedora.nix
          ];
        };
      };
    };
}
