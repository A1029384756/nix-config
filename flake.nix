{
  description = "Hayden's NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    nur.url = "github:nix-community/NUR";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  {
    overlays = import ./overlays { inherit inputs; };
    nixosModules = import ./modules/nixos;

    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs ; };
        modules = [
          inputs.hyprland.nixosModules.default
            ./nixos/configuration.nix
        ];
      };
    };

    homeConfigurations = {
      "haydengray@laptop" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          inputs.nur.nixosModules.nur
          inputs.hyprland.homeManagerModules.default
          {wayland.windowManager.hyprland.enable = true;}
            ./home-manager/home.nix
        ];
      };
    };
  };
}
