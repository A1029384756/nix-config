{ lib, ... }: {
	options.vista.tailnetIp = lib.mkOption {
		type = lib.types.str;
		description = "host tailnet ipv4 address";
	};
}
