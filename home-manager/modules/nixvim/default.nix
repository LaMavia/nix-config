{ pkgs, ... }:
let 
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
    # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
    # ref = "nixos-23.05";
  });
in
{
  imports = [
    nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;

    globals.mapleader = ",";

    options = {
      number = true;         # Show line numbers
      relativenumber = true; # Show relative line numbers

      shiftwidth = 2;        # Tab width should be 2

    };

    colorschemes.onedark.enable = true;

    plugins = {
    	lightline.enable = true;
	which-key.enable = true;
	notify.enable = true;
	telescope.extensions.file_browser.enable = true;
	bufferline.enable = true;
    };
  };
}
