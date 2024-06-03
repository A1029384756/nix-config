{ user, pkgs, ... }: {
  users.users.${user}.home = "/Users/${user}";

  services.nix-daemon.enable = true;
  nix.settings.experimental-features = "nix-command flakes";
  nix.extraOptions = ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  programs.zsh.enable = true;
  programs.fish.enable = true;

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };

    brews = [
      "autoraise"
    ];

    casks = [
      "aerospace"
      "arc"
      "font-jetbrains-mono-nerd-font"
      "git-credential-manager"
      "iterm2"
      "kitty"
      "zoom"
      "zulu@21"
    ];

    taps = [
      "dimentium/autoraise"
      "homebrew/cask-fonts"
      "mrkai77/cask"
      "nikitabobko/tap"
    ];
  };

  environment.systemPackages = with pkgs; [
    git
    go
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

  system.stateVersion = 4;
}
