{ user, pkgs, ... }:
{
  ids.gids.nixbld = 350;
  users.users.${user}.home = "/Users/${user}";

  nix.settings.experimental-features = "nix-command flakes impure-derivations";
  nix.extraOptions = ''
    extra-platforms = x86_64-darwin aarch64-darwin
    trusted-users = root ${user}
  '';

  services.aerospace = {
    enable = true;
    settings = {
      gaps = {
        inner.horizontal = 8;
        inner.vertical = 8;
        outer.left = 8;
        outer.bottom = 8;
        outer.top = 8;
        outer.right = 8;
      };

      mode.main.binding = {
        alt-slash = "layout tiles horizontal vertical";
        alt-comma = "layout accordion horizontal vertical";

        alt-h = "focus --boundaries all-monitors-outer-frame left";
        alt-j = "focus --boundaries all-monitors-outer-frame down";
        alt-k = "focus --boundaries all-monitors-outer-frame up";
        alt-l = "focus --boundaries all-monitors-outer-frame right";

        alt-shift-h = "move left";
        alt-shift-j = "move down";
        alt-shift-k = "move up";
        alt-shift-l = "move right";

        alt-shift-minus = "resize smart -50";
        alt-shift-equal = "resize smart +50";

        alt-tab = "workspace prev";
        alt-shift-tab = "move-node-to-workspace prev";
        alt-enter = "workspace next";
        alt-shift-enter = "move-node-to-workspace next";
        alt-shift-semicolon = "mode service";
      } // builtins.listToAttrs (
        builtins.concatLists (builtins.genList
          (i:
            let ws = toString i;
            in
            [
              { name = "alt-${ws}"; value = "workspace ${ws}"; }
              { name = "alt-shift-${ws}"; value = "move-node-to-workspace ${ws}"; }
            ]) 9));

      mode.service.binding = {
        esc = [ "reload-config" "mode main" ];
        r = [ "flatten-workspace-tree" "mode main" ];
        f = [ "layout floating tiling" "mode main" ];
        backspace = [ "close-all-windows-but-current" "mode main" ];
        alt-shift-h = [ "join-with left" "mode main" ];
        alt-shift-j = [ "join-with down" "mode main" ];
        alt-shift-k = [ "join-with up" "mode main" ];
        alt-shift-l = [ "join-with right" "mode main" ];
      };

      on-window-detected = [
        {
          check-further-callbacks = true;
          "if" = {
            app-id = "com.catonetworks.mac.CatoClient";
            app-name-regex-substring = "CatoClient";
          };
          run = [
            "layout tiling"
          ];
        }
      ];
    };
  };

  services.jankyborders = {
    enable = true;
    active_color = "0xffb4befe";
    inactive_color = "#ff585b70";
    width = 3.0;
  };

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
      "maven"
      "sdl2"
    ];

    casks = [
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
