{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs }: {
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
      ];
    };
  };
}