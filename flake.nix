{
  description = "ziggooner";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, ... }: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (final: prev: {
            zig = final.callPackage ./pkgs/zig {};
          })
        ];
      };
    in {
      nixosConfigurations."nix" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/desktop.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ziggoon = import ./home/home.nix;
            home-manager.backupFileExtension = "backup";
          }
        ];
        specialArgs = { inherit pkgs; };
      };
    };
}
