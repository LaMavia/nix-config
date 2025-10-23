{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "path:./home-manager/modules/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
    };
    # Neve.url = "github:redyf/Neve";
  };
  outputs = { self, nixpkgs, home-manager, niri, ... } @ inputs: {
    overlays.additions = final: prev: {
      nixvim = inputs.nixvim.packages.${prev.system}.default;
    };
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
      };
      modules = [
        ./hardware-configuration.nix
        ./configuration.nix
        ./hardware-override.nix
        ./configuration/systemd.nix
        ./configuration/packages.nix
        ./configuration/programs.nix
        ./configuration/services.nix
        ./configuration/hardware.nix
        ./configuration/virtualisation/docker.nix
        ./configuration/virtualisation/wayland.nix
        niri.nixosModules.niri
        home-manager.nixosModules.home-manager
        {
          nixpkgs.overlays = [
            niri.overlays.niri
          ];
          # home-manager.backupFileExtension = "backup";
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.mavia = import ./home-manager/home.nix;
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];
    };
  };
}
