all: rebuild

.PHONY: rebuild
rebuild:
	./rebuild.sh

.PHONY: update
update:
	./update.sh

livecd:
	nix-build -A iso_minimal.x86_64-linux -o ./livecd "${HOME}/code/nixpkgs/nixos/release.nix"
