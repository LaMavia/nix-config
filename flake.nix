{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager }: {
    # replace 'joes-desktop' with your hostname here.
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ 
        ./hardware-configuration.nix 
        ./configuration.nix 
        ./configuration/systemd.nix 
        ./configuration/packages.nix 
        ./configuration/programs.nix 
        ./configuration/services.nix 
        ./configuration/hardware.nix
        ./configuration/virtualisation/docker.nix
        ./configuration/virtualisation/wayland.nix
        home-manager.nixosModules.home-manager
          {
            # home-manager.backupFileExtension = "backup";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.mavia = import ./home-manager/home.nix;
          }
      ];
    };
  };
}
