-- Suppress any deprecation warnings
vim.g.nonels_suppress_issue58 = true

local none_ls_status_ok, none_ls = pcall(require, "null-ls")
if not none_ls_status_ok then
  return
end

local none_ls_status_ok, none_ls = pcall(require, "none-ls")
if not none_ls_status_ok then
  return
end

-- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = none_ls.builtins.formatting
-- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = none_ls.builtins.diagnostics

-- https://github.com/prettier-solidity/prettier-plugin-solidity
-- npm install --save-dev prettier prettier-plugin-solidity
none_ls.setup {
  debug = true,
  sources = {
    formatting.prettier.with {
      extra_filetypes = { "toml", "solidity" },
      extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
    },
    formatting.black.with { extra_args = { "--fast" } },
    formatting.stylua,
    formatting.shfmt,
    formatting.google_java_format,
    -- Go
    formatting.gofumpt,
    formatting.goimports_reviser,
    -- Use gopls instead of golines
    -- formatting.golines.with({
    --   extra_args = {
    --     "--max-len=180",
    --     "--base-formatter=gofumpt",
    --   },
    -- }),
    -- diagnostics.flake8,
    diagnostics.shellcheck,
    diagnostics.revive
  },
}

local unwrap = {
  method = none_ls.methods.DIAGNOSTICS,
  filetypes = { "rust" },
  generator = {
    fn = function(params)
      local diagnostics = {}
      -- sources have access to a params object
      -- containing info about the current file and editor state
      for i, line in ipairs(params.content) do
        local col, end_col = line:find "unwrap()"
        if col and end_col then
          -- none-ls fills in undefined positions
          -- and converts source diagnostics into the required format
          table.insert(diagnostics, {
            row = i,
            col = col,
            end_col = end_col,
            source = "unwrap",
            message = "hey " .. os.getenv("USER") .. ", don't forget to handle this" ,
            severity = 2,
          })
        end
      end
      return diagnostics
    end,
  },
}

none_ls.register(unwrap)
