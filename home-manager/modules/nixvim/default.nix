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

  programs.nixvim = {
    enable = true;

    globals.mapleader = " ";

    clipboard.register = "unnamedplus";
  
    opts = {
      expandtab = true;
      shiftwidth = 2;
      smartindent = true;
      tabstop = 2;
      completeopt = "menu,noinsert,preview";
      hidden = true;
      ignorecase = true;
      joinspaces = false;
      scrolloff = 4;
      shiftround = true;
      sidescrolloff = 8;
      smartcase = true;
      splitright = true;
      termguicolors = true;
      wildmode = "list:longest";
      list = true;
      number = true;
      relativenumber = true;
      wrap = false;
      undofile = true;
      clipboard = "unnamedplus";
      cursorcolumn = true;
      spell = true;
    }; 

    colorschemes.one.enable = true;

    plugins = plugin-config; 
    extraPlugins = with pkgs.vimPlugins; [
      nvim-web-devicons
      luasnip
    ];

    keymaps =
      [
        {
          key = "//";
          action = ":noh<CR>";
        }
        {
          key = "<C-h>";
          action = "<cmd>lua require('luasnip').jump(1)<CR>";
        }
        {
          key = "<leader>ff";
          action = "<cmd>lua require('telescope.builtin').find_files()<CR>";
        }
        {
          key = "<leader>fw";
          action = "<cmd>lua require('telescope.builtin').live_grep()<CR>";
        }
        {
          key = "<leader>gg";
          action = ":Neogit<CR>";
        }
        {
          key = "<leader>af";
          action = "<cmd> lua vim.lsp.buf.format()<CR>";
        }
        {
          key = "<leader>ac";
          action = ":Neogen<CR>";
        }
        {
          key = "<leader>m";
          action = ":MaximizerToggle<CR>";
        }
        {
          key = "<leader>t";
          action = ":CHADopen<CR>";
        }
        {
          key = "<leader>l";
          action = "<cmd> lua require('lsp_lines').toggle()<CR>";
        }
        {
          key = "<leader>gd";
          action = "<cmd> lua vim.lsp.buf.definition() <CR>";
        }
        {
          key = "<leader>lR";
          action = "<cmd>Lspsaga finder<CR>";
        }
        {
          key = "<leader>lr";
          action = "<cmd>Lspsaga rename<CR>";
        }
        {
          key = "<leader>la";
          action = "<cmd>Lspsaga code_action<CR>";
        }
      ];

    extraConfigLua = builtins.readFile ./extra/cmp.lua;
  };
}
