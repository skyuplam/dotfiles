{
  description = "TLam's darwin system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, darwin, nixpkgs, home-manager, neovim-nightly-overlay }:
  let
    nixpkgsConfig = rec {
      config = { allowUnfree = true; };
      overlays = [ neovim-nightly-overlay.overlay ];
    };
  in
  {
    darwinConfigurations."tlammbp" = darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      modules = [
        ./darwin.nix
        home-manager.darwinModules.home-manager
        (
          { lib, pkgs, ... }: {
            nixpkgs = nixpkgsConfig;
            # `home-manager` config
            users.users.terrencelam.home = "/Users/terrencelam";
            home-manager.useGlobalPkgs = true;
            home-manager.users.terrencelam = {
              imports = [ ./home.nix ];
            };
          }
        )
      ];
    };
  };
}

# vim: foldmethod=marker