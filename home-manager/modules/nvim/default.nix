{ pkgs, config, ... }:
let
  path = "/home/mavia/.nixos/home-manager/modules/nvim/config_";
in
{
  home.file.".config/nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${path}";
  };

  home.packages = import ./packages.nix { pkgs = pkgs; };
}
