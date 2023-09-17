{ lib
, fetchFromGitHub
, buildNpmPackage
, nodejs
, extraFlags ? [ ]
, stdenv
}:
buildNpmPackage {
  pname = "arRPC";
  version = "3.1.0";

  src = fetchFromGitHub {
    owner = "cannibalmaid";
    repo = "arRPC";
    rev = "5c6d45d056bee55bb07927c70a81c9ba958601de";
    hash = "sha256-gnHSje6YUUrw75XKkVx4T0Rc1ynnx4nUbcjvxBP3qFE=";
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
