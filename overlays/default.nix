# This file defines overlays
{ inputs, ... }:
{
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    steam = prev.steam.override ({ extraPkgs ? pkgs': [ ], ... }: {
      extraPkgs = pkgs': (extraPkgs pkgs') ++ (with pkgs'; [
        libgdiplus
      ]);
    });

    cartridges = prev.cartridges.overrideAttrs
      (old: rec {
        version = "2.7.1";
        src = prev.fetchFromGitHub rec {
          hash = "sha256-y3qh2YcyXndRhERdW0ADiGdJo03Y/zNUYa+2bydJL+I=";
        };
      });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
      allowUnfreePredicate = _: true;
      permittedInsecurePackages = [
        "electron-11.5.0"
        "electron-13.6.9"
        "electron-24.8.6"
      ];
    };
  };

  cherry-mesa = final: _prev: {
    cherry-mesa = import inputs.mesa {
      system = final.system;
      config.allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

}
