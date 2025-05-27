{ user, pkgs, ... }:
{
  imports = [
    ../modules/window_tiling
  ];
  users.users.${user}.home = "/Users/${user}";
  ids.gids.nixbld = 350;

  nix.settings.experimental-features = "nix-command flakes impure-derivations";
  nix.extraOptions = ''
    extra-platforms = x86_64-darwin aarch64-darwin
    trusted-users = root ${user}
  '';

  programs.zsh.enable = true;
  programs.fish.enable = true;

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
      "llvm@18"
      "sdl2"
    ];

    casks = [
      "bluebubbles"
      "font-jetbrains-mono-nerd-font"
      "git-credential-manager"
      "iterm2"
      "raycast"
      "zen"
    ];

    taps = [
      "FelixKratz/formulae"
      "mrkai77/cask"
      "nikitabobko/tap"
    ];
  };

  environment.systemPackages = with pkgs; [
    git
    go
    rustc
    tenv
    vesktop
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

  system.stateVersion = 4;
}
