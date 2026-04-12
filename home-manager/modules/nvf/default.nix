{ pkgs, ... }:
{
  programs.nvf = {
    enable = true;
    # your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim = {
        viAlias = false;
        vimAlias = true;
        lsp = {
          enable = true;
        };
        options = {
            shiftWidth = 2;
            tabstop = 2;
        };
        theme = {
          enable = true;
          name = "catppuccin";
          style = "macchiato";
        };
        languages = {
          clang.enable = true;
          haskell.enable = true;
        };
        git.enable = true;
        filetree.neo-tree = {
          enable = true;
        };
        tabline.nvimBufferline.enable = true;
        minimap.codewindow.enable = true;
        binds = {
          whichKey.enable = true;
        };
        telescope = {
          enable = true;
          extensions = [
            {
              name = "fzf";
              packages = [pkgs.vimPlugins.telescope-fzf-native-nvim];
              setup = {fzf = {fuzzy = true;};};
            }
          ];
        };
        treesitter = {
          enable = true;
          grammars = with pkgs.vimPlugins.nvim-treesitter.grammarPlugins; [
            c 
            haskell
            bash
            tsx
            markdown
          ];
          textobjects = {
            enable = true;
          };
        };
      };
    };
  };
}
