{ pkgs, ... }: (with pkgs; [
  (neovim.override {
    plugins = with pkgs.vimPlugins; [
      nvim-tree-lua
      nvim-treesitter
      astrocore
      astroui
      astrolsp
    ];
  })
  lazygit
  ripgrep
  bottom
  nixd
  prettierd
  gcc
])
