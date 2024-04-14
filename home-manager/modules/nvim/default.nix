{ pkgs, ... }:
let
 config-derivation = pkgs.callPackage ./derivation.nix { };
in
{
 home.file.".config/nvim".source = config-derivation;

 home.packages = import ./packages.nix { pkgs=pkgs; };
}
