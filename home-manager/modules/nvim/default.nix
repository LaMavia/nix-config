{ pkgs, fetchgit, ... }:
let
  config-derivation = pkgs.callPackage ./derivation.nix { };
in
{
  home.file.".config/nvim".source = config-derivation;

  home.packages = with pkgs; [
    neovim
    lazygit
    ripgrep
    bottom
  ];
}
