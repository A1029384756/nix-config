{ pkgs, ... }:
let
	cinny = pkgs.buildNpmPackage {
		pname = "cinny";
		version = "4.8.1";

		src = pkgs.fetchFromGitHub {
			owner = "hazre";
			repo = "cinny";
			rev = "21e596d22710b2be33102e61447b47607e0ed33a";
			hash = "sha256-znLNzxjLrD36I2C5PS80DMhbakuYplOV08eGYLf+cYY=";
		};

		npmDepsHash = "sha256-U7cyF0uDuBpCHoeFrwjG5ITyKvDpnHuYy5oCQ2IfL6A=";

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
