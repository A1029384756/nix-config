{ pkgs, ... }:
let
	cinny = pkgs.buildNpmPackage {
		pname = "cinny";
		version = "4.10.5";

		src = pkgs.fetchFromGitHub {
			owner = "cinnyapp";
			repo = "cinny";
			rev = "c1b1bdeb8cbd4c687d0a95a0ef5802ab290828d4";
			hash = "sha256-lfT7/41qqQL5lm7rvrmIp3OkvH3coMkXPFuoscAAJ0I=";
		};

		npmDepsHash = "sha256-5k7PLPfzT7i34JvzHC6f65T8RBVAlCWXK6Dp01pq514=";

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
