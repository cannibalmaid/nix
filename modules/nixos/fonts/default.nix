{ pkgs, ... }: {

  fonts.fontDir.enable = true;
  fonts.fontconfig.enable = true;


  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    (nerdfonts.override { fonts = [ "SpaceMono" "CascadiaCode" ]; })

    customfonts
  ];
}
