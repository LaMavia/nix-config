local utils = require "astronvim.utils"
local is_available = utils.is_available

return function(maps)
  -- Smart Splits
  if is_available "smart-splits.nvim" then
    maps.n["<C-Left>"] = { function() require("smart-splits").move_cursor_left() end, desc = "move to left split" }
    maps.n["<C-Down>"] = { function() require("smart-splits").move_cursor_down() end, desc = "move to below split" }
    maps.n["<C-Up>"] = { function() require("smart-splits").move_cursor_up() end, desc = "move to above split" }
    maps.n["<C-Right>"] = { function() require("smart-splits").move_cursor_right() end, desc = "move to right split" }
    maps.n["<C-k>"] = { function() require("smart-splits").resize_up() end, desc = "resize split up" }
    maps.n["<C-j>"] = { function() require("smart-splits").resize_down() end, desc = "resize split down" }
    maps.n["<C-h>"] = { function() require("smart-splits").resize_left() end, desc = "resize split left" }
    maps.n["<C-l>"] = { function() require("smart-splits").resize_right() end, desc = "resize split right" }
  else
    maps.n["<C-Left>"] = { "<c-w>h", desc = "move to left split" }
    maps.n["<C-Down>"] = { "<c-w>j", desc = "move to below split" }
    maps.n["<C-Up>"] = { "<c-w>k", desc = "move to above split" }
    maps.n["<C-Right>"] = { "<c-w>l", desc = "move to right split" }
    maps.n["<C-k>"] = { "<cmd>resize -2<cr>", desc = "resize split up" }
    maps.n["<C-j>"] = { "<cmd>resize +2<cr>", desc = "resize split down" }
    maps.n["<C-h>"] = { "<cmd>vertical resize -2<cr>", desc = "resize split left" }
    maps.n["<C-l>"] = { "<cmd>vertical resize +2<cr>", desc = "resize split right" }
  end

  return maps
end

