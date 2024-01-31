{ pkgs, fetchgit, ... }:
let
  config-derivation = pkgs.callPackage ./derivation.nix { };
in
{
  home.file.".config/nvim-maybe".source = config-derivation;
}
