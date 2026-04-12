{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nixvim = {
    #   url = "github:nix-community/nixvim";
    #   # inputs.nixpkgs.follows = "nixpkgs";
    # };
    # niri = {
    #  url = "github:sodiboo/niri-flake";
    # inputs.nixpkgs.follows = "nixpkgs";
    # };
    # nix4nvchad = {
    #   url = "github:nix-community/nix4nvchad";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # nixvim-config = {
    #   url = "github:nicolas-goudry/nixvim-config";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # noctalia = {
    #   url = "github:noctalia-dev/noctalia-shell";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # Neve.url = "github:redyf/Neve";
    # nvf = {
    #   url = "github:NotAShelf/nvf";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };
  outputs = { self, nixpkgs, home-manager, ... } @ inputs: {
    # overlays.additions = final: _prev: {
    #   nixvim = inputs.nixvim-config.packages.${_prev.system}.default;
    # };

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
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
        # ./home-manager/modules/noctalia.nix
        # inputs.niri.nixosModules.niri
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            extraSpecialArgs = {
              inherit system inputs; # <- this will make inputs available anywhere in the HM configuration
            };
            # sharedModules = [ inputs.nvf.homeManagerModules.default ];
            # useGlobalPkgs = true;
            # useUserPackages = true;
            users.mavia = import ./home-manager/home.nix;
          };

          home-manager.backupFileExtension = "backup";
        }
      ];
    };
  };
}
