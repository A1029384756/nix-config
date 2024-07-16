{
  description = "Hayden's NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    catppuccin.url = "github:catppuccin/nix";

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
  };

  outputs =
    inputs@{ nixpkgs
    , home-manager
    , darwin
    , catppuccin
    , hyprland
    , nixGL
    , nixos-cosmic
    , stylix
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
              stylix.nixosModules.stylix
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
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit user inputs;
              };
              home-manager.backupFileExtension = "backup";
              home-manager.users.${user} = {
                imports = [
                  # [TODO] remove when https://github.com/nix-community/home-manager/pull/5355 is merged
                  (builtins.fetchurl {
                    url = "https://raw.githubusercontent.com/Smona/home-manager/nixgl-compat/modules/misc/nixgl.nix";
                    sha256 = "sha256:0g5yk54766vrmxz26l3j9qnkjifjis3z2izgpsfnczhw243dmxz9";
                  })

                  ./home-manager/${config}
                  catppuccin.homeManagerModules.catppuccin
                ];
              };
            }
          ] ++ getOSMods (os);
        };
    in
    {
      templates = import ./templates;

      nixosConfigurations = {
        g14 = nixSystem ({
          device = "g14";
          config = "laptop";
          user = "haydengray";
          os = "nixos";
        });
        x270 = nixSystem ({
          device = "x270";
          config = "laptop";
          user = "haydengray";
          os = "nixos";
        });
        rev3 = nixSystem ({
          device = "rev3";
          config = "rev3";
          user = "haydengray";
          os = "nixos";
        });
      };

      darwinConfigurations = {
        nts1414 = nixSystem ({
          device = "NTS1414";
          config = "macos";
          user = "hgray";
          os = "darwin";
        });
      };

      homeConfigurations = {
        fedora = lib.homeManagerConfiguration {
          extraSpecialArgs = { inherit inputs; };
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [ nixGL.overlay ];
          };
          modules = [
            catppuccin.homeManagerModules.catppuccin
            ./home-manager/rev3-fedora.nix

            # [TODO] remove when https://github.com/nix-community/home-manager/pull/5355 is merged
            (builtins.fetchurl {
              url = "https://raw.githubusercontent.com/Smona/home-manager/nixgl-compat/modules/misc/nixgl.nix";
              sha256 = "sha256:0g5yk54766vrmxz26l3j9qnkjifjis3z2izgpsfnczhw243dmxz9";
            })
          ];
        };
      };
    };
}
