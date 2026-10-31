{ inputs, user, pkgs, ... }:
{
  imports = [
		inputs.agenix.darwinModules.default
    ../modules/window_tiling
		./forgejo.nix
  ];
	age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  users.users.${user} = {
		home = "/Users/${user}";
		uid = 501;
	};
  ids.gids.nixbld = 350;

  determinateNix.customSettings = {
    extra-experimental-features = [ "impure-derivations" ];
    extra-platforms = [ "x86_64-darwin" "aarch64-darwin" ];
    trusted-users = [ "root" user ];
  };

  programs.zsh.enable = true;
  programs.fish.enable = true;

  networking.hostName = "minibubbles";
  system = {
    primaryUser = user;
    defaults = {
      dock.autohide = true;
      NSGlobalDomain = {
        AppleFontSmoothing = 0;
        AppleInterfaceStyle = "Dark";
        NSWindowShouldDragOnGesture = true;
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
    };

    brews = [
      "llvm@18"
      "sdl2"
    ];

    casks = [
      "bluebubbles"
      "font-jetbrains-mono-nerd-font"
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
		cmake
		tree-sitter
		tailscale
		forgejo-runner
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

  system.stateVersion = 4;
}
