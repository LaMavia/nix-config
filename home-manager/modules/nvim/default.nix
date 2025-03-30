{ pkgs, config, ... }:
let 
 path = "/home/mavia/.nixos/home-manager/modules/nvim/config";
in {
 home.file.".config/nvim" = {
  source = builtins.trace "nvim config path: ${path}" (config.lib.file.mkOutOfStoreSymlink "${path}");
 };

 home.packages = import ./packages.nix { pkgs=pkgs; };
}
