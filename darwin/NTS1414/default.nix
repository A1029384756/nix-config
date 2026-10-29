{ user, pkgs, ... }:
{
  imports = [
    ../modules/window_tiling
  ];
  ids.gids.nixbld = 350;
  users.users.${user}.home = "/Users/${user}";

  determinateNix.customSettings = {
    extra-experimental-features = [ "impure-derivations" ];
    extra-platforms = [ "x86_64-darwin" "aarch64-darwin" ];
    trusted-users = [ "root" user ];
  };

  programs.zsh.enable = true;
  programs.fish.enable = true;

  system = {
    primaryUser = user;
    defaults = {
      dock.autohide = true;
      NSGlobalDomain = {
        AppleFontSmoothing = 0;
        AppleInterfaceStyle = "Dark";
        NSWindowShouldDragOnGesture = true;
        ApplePressAndHoldEnabled = false;
      };
      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
      CustomSystemPreferences.NSGlobalDomain."com.apple.mouse.linear" = true;
    };
  };

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
			extraFlags = [ "--force-cleanup" ];
    };

    brews = [
			"awscurl"
      "llvm@22"
      "maven"
      "opencode"
    ];

    casks = [
			"cursor-cli"
      "ghostty"
      "iterm2"
      "zen"
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
    uv
    cmake
    tree-sitter
  ];

	security.pki.certificateFiles = [ ./cato-root-ca.pem ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

  system.stateVersion = 4;
}
