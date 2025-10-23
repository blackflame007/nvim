-- Rustaceanvim configuration (modern replacement for rust-tools)
-- This plugin automatically sets up rust-analyzer

vim.g.rustaceanvim = {
  -- LSP configuration
  server = {
    on_attach = require("nvim.lsp.handlers").on_attach,
    capabilities = require("nvim.lsp.handlers").capabilities,
    default_settings = {
      ['rust-analyzer'] = {
        lens = {
          enable = true,
        },
        checkOnSave = {
          command = "clippy",
        },
        inlayHints = {
          bindingModeHints = {
            enable = true,
          },
          chainingHints = {
            enable = true,
          },
          closingBraceHints = {
            enable = true,
            minLines = 25,
          },
          closureReturnTypeHints = {
            enable = "never",
          },
          lifetimeElisionHints = {
            enable = "never",
            useParameterNames = false,
          },
          maxLength = 25,
          parameterHints = {
            enable = true,
          },
          reborrowHints = {
            enable = "never",
          },
          renderColons = true,
          typeHints = {
            enable = true,
            hideClosureInitialization = false,
            hideNamedConstructor = false,
          },
        },
      },
    },
  },
  -- Tools configuration
  tools = {
    hover_actions = {
      auto_focus = false,
      border = "rounded",
    },
    -- Codelens refresh
    on_initialized = function()
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
        pattern = { "*.rs" },
        callback = function()
          vim.lsp.codelens.refresh()
        end,
      })
    end,
  },
}

