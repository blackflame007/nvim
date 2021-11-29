require("nvim.plugins")
require("nvim.telescope")
require'lualine'.setup()
require("nvim.comment")
-- require("nvim.git-worktree")
-- require("nvim.debugger")
require("nvim.lsp")
require('nvim-autopairs').setup{}

P = function(v)
  print(vim.inspect(v))
  return v
end

if pcall(require, 'plenary') then
  RELOAD = require('plenary.reload').reload_module

  R = function(name)
    RELOAD(name)
    return require(name)
  end
end

