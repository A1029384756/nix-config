{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "A1029384756";
    userEmail = "hayden.gray104@gmail.com";
    extraConfig = {
      credential = {
        credentialStore = "secretservice";
        helper = "${pkgs.git-credential-manager}/bin/git-credential-manager";
      };
    };
  };

  home.packages = with pkgs; [
    gh
    git-credential-manager
  ];
}
