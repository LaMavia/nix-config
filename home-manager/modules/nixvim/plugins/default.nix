let 
  cmp-config = import ./completion/cmp.nix;
in
{
  lightline.enable = true;
  which-key.enable = true;
  notify.enable = true;
  telescope.extensions.file-browser.enable = true;
  bufferline.enable = true;
  treesitter = {
    enable = true;

  };
  nvim-tree = {
    enable = true;
    disableNetrw = true;
    openOnSetup = true;
    autoClose = true;
    hijackUnnamedBufferWhenOpening = true;
  };

  lsp = {
    enable = true;
    keymaps.lspBuf = {
      "gd" = "definition";
      "gD" = "references";
      "gt" = "type_definition";
      "gi" = "implementation";
      "K" = "hover";
    };
    servers = {
      elixirls.enable = true;
      jsonls.enable = true;
      nixd.enable = true;
      tsserver.enable = true;
      tailwindcss.enable = true;
      prolog-ls.enable = true;
      lua-ls.enable = true;
      hls.enable = true;
    };
  };

  none-ls = {
    enable = true;
    sources.formatting.prettier.disableTsServerFormatter = true;
  };

  cmp-emoji.enable = true;
  cmp-nvim-lsp.enable = true; # lsp
  cmp-buffer.enable = true;
  cmp-path.enable = true; # file system paths
  cmp_luasnip.enable = true; # snippets
  cmp-cmdline.enable = false; # autocomplete for cmdline
  cmp = cmp-config;
}
