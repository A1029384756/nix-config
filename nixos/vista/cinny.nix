{ pkgs, ... }:
let
	cinny = pkgs.buildNpmPackage {
		pname = "cinny";
		version = "4.8.1";

		src = pkgs.fetchFromGitHub {
			owner = "YoJames2019";
			repo = "cinny";
			rev = "40957632d512e4fa0edc749fca007090d7de205e";
			hash = "sha256-fLbOYScbbPierHpi14MneZSauzQINsPYD7NY4zqo0OM=";
		};

		npmDepsHash = "sha256-DW2Fv1Z/YDOkDqqaXHUY5Ojsn2TzOu+6L/a7fmX/RbI=";

		nodejs = pkgs.nodejs_20;

		nativeBuildInputs = with pkgs; [
			pkg-config
			python3
		];

		buildInputs = with pkgs; [
			cairo
			pango
			libjpeg
			giflib
			librsvg
			pixman
		];

		npmBuildScript = "build";

		installPhase = ''
			runHook preInstall
			mkdir -p $out
			cp -r dist/* $out/
			runHook postInstall
		'';
	};
in
{
	services.caddy.virtualHosts."cinny.cstring.dev".extraConfig = ''
		root * ${cinny}
		file_server
		try_files {path} /index.html
	'';
}
