#!/usr/bin/env bash

function handle_sigint() {
	exit
}

trap handle_sigint SIGINT

for system in "$@" 
do
	echo "------------ DEPLOYING $system -------------"
	nix run .#nixos-rebuild switch -- --target-host $system --sudo --flake .#$system
done
