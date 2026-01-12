#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
	echo 'invalid argument count, usage: `./deploy.sh <system>`'
	exit 1
fi
nix run nixpkgs#nixos-rebuild switch -- --target-host $1 --sudo --flake .#$1
