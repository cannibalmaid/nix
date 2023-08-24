# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'

{ pkgs ? (import ../nixpkgs.nix) {} }: {
  linux-discord-rich-presence = pkgs.callPackage ./linux-discord-rich-presence {};
  arrpc = pkgs.callPackage ./arrpc {};
  alvr = pkgs.callPackage ./alvr {};
  grapejuice = pkgs.callPackage ./grapejuice {};
}