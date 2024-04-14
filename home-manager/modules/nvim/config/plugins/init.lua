return {
  { "EdenEast/nightfox.nvim" },
  { "LhKipp/nvim-nu" },
  { "whonore/Coqtail", lazy=false },
  { "meatballs/notebook.nvim" },
  { 'jose-elias-alvarez/null-ls.nvim' },
  { 'neovim/nvim-lspconfig' },
  { "nvim-lua/plenary.nvim" },
  { "scalameta/nvim-metals", requires = { "nvim-lua/plenary.nvim" }},
  { 'jose-elias-alvarez/null-ls.nvim' },
  {
    'laytan/tailwind-sorter.nvim',
    dependencies = {'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim'},
    build = 'cd formatter && npm i && npm run build',
    config = true,
  },
  { 'edluffy/hologram.nvim' },
  { 'lervag/vimtex' },
  { 'MunifTanjim/prettier.nvim' },
  {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local elixir = require("elixir")
      local elixirls = require("elixir.elixirls")

      elixir.setup {
        nextls = {enable = true},
        credo = {},
        elixirls = {
          enable = true,
          settings = elixirls.settings {
            dialyzerEnabled = false,
            enableTestLenses = false,
          },
          on_attach = function(client, bufnr)
            vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
          end,
        }
      }
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  }
}

