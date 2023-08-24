{ lib, rustPlatform, fetchFromGitHub }:
let
  pname = "linux-discord-rich-presence";
in
rustPlatform.buildRustPackage {

  inherit pname;
  version="0.1";

  src = fetchFromGitHub {
    owner = "trickybestia";
    repo = "linux-discord-rich-presence";
    rev = "967f1a5c02a2c7006af854251f13b7f2de5cea82";
    sha256 = "sha256-pXYJUBsGoxN1x1q/NIn3GAVofUj9Iy/gMv8vxJOHYeE=";
  };
         
  cargoLock = {
    lockFile = ./Cargo.lock;
  };
}