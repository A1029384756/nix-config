{ pkgs, ... }:
let
	cinny = pkgs.buildNpmPackage {
		pname = "cinny";
		version = "4.10.6";

		src = pkgs.fetchFromGitHub {
			owner = "cinnyapp";
			repo = "cinny";
			rev = "7953ec80e50e2272e24d04cec3f643cc3c222771";
			hash = "sha256-gghGHGLuIjxe9Wl/CscsVaNrMijCm7yyi8Vj4FkrSC0=";
		};

		npmDepsHash = "sha256-qyQ0SXkPSUES/tavKzPra0Q+ZnU9qHvkTC1JgAjL0o8=";

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
