{ config, pkgs, lib, ... }:
let
  isWork = config.isWork;
in
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
      userName = if isWork then "hgray" else "A1029384756";
      userEmail = if isWork then "hgray@northwindstech.com" else "hayden.gray104@gmail.com";
      extraConfig = {
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
