{ lib, stdenvNoCC }:

stdenvNoCC.mkDerivation rec {
  pname = "CustomFonts";
  version = "1.0";

  src = ./otf;

  installPhase = ''
    runHook preInstall

    install -m444 -Dt $out/share/fonts/opentype fa-solid-900.ttf
    install -m444 -Dt $out/share/fonts/opentype fa6-brands.otf

    install -m444 -Dt $out/share/fonts/opentype sfDisplay.otf
    install -m444 -Dt $out/share/fonts/opentype sfText.otf


    runHook postInstall
  '';
}
