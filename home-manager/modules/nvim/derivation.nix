{ stdenv, pkgs, ... }:
stdenv.mkDerivation {
  name = "nvim-config";

  src = ./astro-v4;

  installPhase = ''
    cp -r . $out
    ${pkgs.neovim}/bin/nvim --headless +q
  '';

  buildInputs = import ./packages.nix { pkgs = pkgs; } ;
}
