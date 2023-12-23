{ pkgs
, inputs
, firefox-cascade
, ...
}: {
  programs.browserpass = {
    enable = true;
    browsers = [ "librewolf" ];
  };

  programs.librewolf = {
    enable = true;
    settings = {
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      "svg.context-properties.content.enabled" = true;
      "gnomeTheme.extensions.tabCenterReborn" = true;
      "gnomeTheme.extensions.tabCenterReborn.alwaysOpen" = true;
    };
  };

  home.file.".librewolf/7ay3tvoc.default/chrome".source = inputs.firefox-cascade;
}
