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
      "docker-completion"
      "llvm@18"
    ];

    casks = [
      "arc"
      "font-jetbrains-mono-nerd-font"
      "git-credential-manager"
      "iterm2"
      "kitty"
      "loop"
      "microsoft-edge"
      "warp"
      "zed"
      "zoom"
      "zulu@21"
    ];

    taps = [
      "dimentium/autoraise"
      "homebrew/cask-fonts"
      "mrkai77/cask"
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
