# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'

{ pkgs ? (import ../nixpkgs.nix) { } }: {
  presence = pkgs.callPackage ./presence { };
  arrpc = pkgs.callPackage ./arrpc { };
  xwaylandvideobridge = pkgs.libsForQt5.callPackage ./xwaylandvideobridge { };
  obinskit = pkgs.callPackage ./obinskit { };
  customfonts = pkgs.callPackage ./customfonts { };
}
