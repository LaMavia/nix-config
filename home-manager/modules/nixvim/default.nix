{ pkgs, ... }:
let 
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
    # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
    # ref = "nixos-23.05";
  });
  plugin-config = import ./plugins/default.nix;
in
{
  imports = [
    nixvim.homeManagerModules.nixvim
    # plugin-config
  ];

  home.packages = with pkgs; [
    haskell-language-server
  ];

  programs.nixvim = {
    enable = true;

    globals.mapleader = " ";

    clipboard.register = "unnamedplus";
  
    opts = {
      number = true;         # Show line numbers
      relativenumber = true; # Show relative line numbers
      shiftwidth = 2;        # Tab width should be 2
      expandtab = true;

      termguicolors = true;
    }; 

    colorschemes.one.enable = true;

    plugins = plugin-config; 
    extraPlugins = with pkgs.vimPlugins; [
      nvim-web-devicons
      luasnip
    ];

    keymaps = [
      { key = "<leader>e"; action = "<cmd>NvimTreeToggle<CR>"; }
      { key = "<C-s>"; action = "<cmd>:w<CR>"; }
    ];

    extraConfigLua = builtins.readFile ./extra/cmp.lua;
  };
}
