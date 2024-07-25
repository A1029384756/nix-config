{ user, pkgs, ... }:
{
  users.users.${user}.home = "/Users/${user}";

  services.nix-daemon.enable = true;
  nix.settings.experimental-features = "nix-command flakes impure-derivations";
  nix.extraOptions = ''
    extra-platforms = x86_64-darwin aarch64-darwin
    trusted-users = root ${user}
  '';

  programs.zsh.enable = true;
  programs.fish.enable = true;
  security.pam.enableSudoTouchIdAuth = true;

  system.defaults = {
    dock.autohide = true;
    NSGlobalDomain = {
      AppleFontSmoothing = 0;
      AppleInterfaceStyle = "Dark";
      NSWindowShouldDragOnGesture = true;
    };
    SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
    ".GlobalPreferences"."com.apple.mouse.scaling" = -1.0;
  };

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };

    brews = [
      "borders"
      "llvm@18"
    ];

    casks = [
      "aerospace"
      "arc"
      "element"
      "font-jetbrains-mono-nerd-font"
      "git-credential-manager"
      "iterm2"
      "keymapp"
      "raycast"
      "spotify"
      "vmware-fusion"
      "zoom"
      "zulu@21"
    ];

    taps = [
      "FelixKratz/formulae"
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
