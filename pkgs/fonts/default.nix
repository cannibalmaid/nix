{ lib, stdenvNoCC }:

stdenvNoCC.mkDerivation rec {
  pname = "CustomFonts";
  version = "1.0";

  src = ./otf

  installPhase = ''
    runHook preInstall

    install -m444 -Dt $out/share/fonts/opentype sfDisplay.otf

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/skosch/Crimson";
    description = "A font family inspired by beautiful oldstyle typefaces";
    license = licenses.ofl;
    platforms = platforms.all;
    maintainers = [ maintainers.rycee ];
  };
}
