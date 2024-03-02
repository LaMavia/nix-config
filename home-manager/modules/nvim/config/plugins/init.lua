return {
  { "EdenEast/nightfox.nvim" },
  { "LhKipp/nvim-nu" },
  { "whonore/Coqtail", lazy=false },
  { "meatballs/notebook.nvim" },
  { 'jose-elias-alvarez/null-ls.nvim' },
  { 'neovim/nvim-lspconfig' },
  { "nvim-lua/plenary.nvim" },
  { "scalameta/nvim-metals", requires = { "nvim-lua/plenary.nvim" }},
  -- { 'dense-analysis/ale' },
  { 'jose-elias-alvarez/null-ls.nvim' },
  { 'MunifTanjim/prettier.nvim' },
  {
    'laytan/tailwind-sorter.nvim',
    dependencies = {'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim'},
    build = 'cd formatter && npm i && npm run build',
    config = true,
  },
  { 'edluffy/hologram.nvim' },
  { 'lervag/vimtex' }
}

