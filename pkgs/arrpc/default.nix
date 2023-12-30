{ lib
, fetchFromGitHub
, buildNpmPackage
, nodejs
, extraFlags ? [ ]
, stdenv
}:
buildNpmPackage {
  pname = "arRPC";
  version = "2.2.1";

  src = fetchFromGitHub {
    owner = "cannibalmaid";
    repo = "arRPC";
    rev = "08e12f77a9a2399eec2a7b45c4312f806b4f513c";
    hash = "sha256-8CoKOlWtoI2cHv2qw2MlAlVJ92czUW2bZDVpY1/Pmb4=";
  };

  dontNpmBuild = true;

  npmDepsHash = "sha256-BqX/+f5CCdaDAfazIPj6AKtecVEG+wnPGpegusExGR0=";

  preInstall = ''
    mkdir -p $out/lib/node_modules/arRPC/
  '';

  postInstall = ''
    cp -rf src/* ext/* $out/lib/node_modules/arRPC/
  '';

  postFixup = ''
    ${nodejs}/bin/node --version
    makeWrapper ${nodejs}/bin/node $out/bin/arRPC \
      --add-flags $out/lib/node_modules/arrpc/src \
      --chdir $out/lib/node_modules/arrpc/src \
      ${lib.concatStringsSep " " (map (flag: "--add-flags ${flag}") extraFlags)}
  '';

  meta = with lib; {
    mainProgram = "arRPC";
    description = "An open implementation of Discord's local RPC servers";
    homepage = "https://github.com/OpenAsar/arRPC";
    changelog = "https://github.com/OpenAsar/arRPC/blob/${version}/changelog.md";
    license = licenses.mit;
    maintainers = with maintainers; [ notashelf ];
  };
}
