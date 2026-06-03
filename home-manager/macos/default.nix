{ pkgs, ... }:
{
	imports = [
		../shell.nix
		../nvim.nix
		../kitty.nix
		../wezterm.nix
		../git.nix
	];

	config = {
		isWork = true;
		fonts.fontconfig.enable = true;
		home.stateVersion = "26.05";
		programs.home-manager.enable = true;
		programs.man = {
			package = pkgs.man;
			enable = true;
			generateCaches = true;
		};
	};
}
