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
    CustomSystemPreferences.NSGlobalDomain."com.apple.mouse.linear" = true;
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
      "maven"
      "sdl2"
    ];

    casks = [
      "aerospace"
      "arc"
      "element"
      "font-jetbrains-mono-nerd-font"
      "ghostty"
      "git-credential-manager"
      "iterm2"
      "keymapp"
      "raycast"
      "spotify"
      "vmware-fusion"
      "zen-browser"
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
    rustc
    tenv
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

  system.stateVersion = 4;
}
