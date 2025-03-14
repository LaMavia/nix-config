{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
    };
    nvf.url = "github:notashelf/nvf";
  };
  outputs = { self, nixpkgs, home-manager, niri, nvf, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
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
        home-manager.nixosModules.home-manager
        niri.nixosModules.niri
          {
            nixpkgs.overlays = [
              niri.overlays.niri
            ];
            # home-manager.backupFileExtension = "backup";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.mavia = import ./home-manager/home.nix;
          }
      ];
    };

 homeConfigurations.mavia = home-manager.lib.homeManagerConfiguration {
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    modules = [
      ./home-manager/home.nix
      nvf.homeManagerModules.default
    ];
  };
  };
}
