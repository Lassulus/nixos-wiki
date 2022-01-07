#!/usr/bin/env nix-shell
#! nix-shell -i bash -p nixos-generators
nixos-generate -f vm-nogui -c vm.nix --run
