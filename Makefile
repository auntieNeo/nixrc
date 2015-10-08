livecd:
	nix-build -A iso_minimal.x86_64-linux -o ./livecd "${HOME}/code/nixpkgs/nixos/release.nix"
