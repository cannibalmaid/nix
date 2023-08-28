{ pkgs, ... }: {

  fonts.fontDir.enable = true;

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    (nerdfonts.override { fonts = [ "SpaceMono" "CascadiaCode" ]; })
  ];

}
