{ pkgs, firefox-cascade }:
{
  programs.browserpass = {
    enable = true;
    browsers = [ "librewolf" ];
  };

  programs.librewolf.enable = true;

  home.file.".librewolf/chrome" = firefox-cascade;

}
