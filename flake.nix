{
  description = "Mia's Dreamhouse";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    mesa.url = "github:nixos/nixpkgs/staging";

    hyprland.url = "github:hyprwm/Hyprland";
    nix-gaming.url = "github:fufexan/nix-gaming";
    rust-overlay.url = "github:oxalica/rust-overlay";
    impermanence.url = "github:nix-community/impermanence";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    aagl = { url = "github:ezKEa/aagl-gtk-on-nix"; inputs.nixpkgs.follows = "nixpkgs"; };
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    hyprland-contrib = { url = "github:hyprwm/contrib"; inputs.nixpkgs.follows = "nixpkgs"; };
    spicetify-nix = { url = "github:the-argus/spicetify-nix"; };
    neovim-flake = { url = "github:notashelf/neovim-flake"; inputs.nixpkgs.follows = "nixpkgs"; };
    firefox-cascade = { url = "github:andreasgrafen/cascade"; flake = false; }; # github:rafaelmardojai/firefox-gnome-theme
  };

  outputs =
    { self, nixpkgs, home-manager, hyprland, nixos-hardware, spicetify-nix, ... } @ inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      pkgsFor = nixpkgs.legacyPackages;

      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
    in
    rec {
      packages = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        import ./pkgs { inherit pkgs; }
      );
      overlays = import ./overlays { inherit inputs; };
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations = {

        dreamhouse = lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./hosts/dreamhouse/system.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs outputs; };
              home-manager.users.ammy = import ./hosts/dreamhouse/user.nix;
            }
          ];
        };

        ken = lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./hosts/ken/system.nix
            nixos-hardware.nixosModules.apple-t2
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs outputs; };
              home-manager.users.ammy = import ./hosts/ken/user.nix;
            }
          ];
        };
      };
    };
}
