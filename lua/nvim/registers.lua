-- vim.g.registers_return_symbol = "\n" --'⏎' by default
-- vim.g.registers_tab_symbol = "\t" --'·' by default
-- vim.g.registers_space_symbol = " " --' ' by default
-- vim.g.registers_show = "*+\"" --'*+\"-/_=#%.0123456789abcdefghijklmnopqrstuvwxyz' by default, which registers to show and in what order
local registers = require("registers")
registers.setup({
  hide_only_whitespace = true,
  show_empty = true,
  trim_whitespace = true,
  insert_mode = true,
  visual_mode = true,
  normal_mode = true,

  window = {
    border = "rounded",
    max_width = 100,
    min_height = 3
  }
})
