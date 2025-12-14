{ config, pkgs, lib, ... }:
{
  options = {
    isWork = lib.mkOption {
      type = with lib.types;
        uniq bool;
      description = ''
        whether the applied nix profile is for work
      '';
      default = false;
    };
  };

  config = {
    programs.git = {
      enable = true;
      settings = {
				user = { 
					name = if config.isWork then "Hayden Gray" else "A1029384756";
					email = if config.isWork then "hgray@northwindstech.com" else "hayden.gray104@gmail.com";
				};
        credential = {
          credentialStore = if pkgs.stdenv.isDarwin then "keychain" else "secretservice";
          helper = "${pkgs.git-credential-manager}/bin/git-credential-manager";
        };
      };
    };

    home.packages = with pkgs; [
      gh
      git-credential-manager
    ];
  };
}
