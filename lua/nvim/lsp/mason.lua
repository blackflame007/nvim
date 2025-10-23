local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
  return
end

local servers = {
  "cssls",
  "cssmodules_ls",
  "html",
  "jdtls",
  "jsonls",
  "solc",
  "lua_ls",
  "tflint",
  "terraformls",
  "ts_ls",
  "pyright",
  "yamlls",
  "bashls",
  "gopls",
  "clangd",
  "rust_analyzer",
  "taplo",
  "zk@v0.10.1",
  "lemminx"
}

local settings = {
  ui = {
    border = "rounded",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

mason.setup(settings)
mason_lspconfig.setup {
  ensure_installed = servers,
  automatic_installation = true,
}

-- Setup base configuration for all LSP servers
-- Using vim.lsp.config API (Neovim 0.11+) instead of deprecated lspconfig
local base_config = {
  on_attach = require("nvim.lsp.handlers").on_attach,
  capabilities = require("nvim.lsp.handlers").capabilities,
}

for _, server in pairs(servers) do
  local opts = vim.deepcopy(base_config)
  
  server = vim.split(server, "@")[1]

  if server == "jsonls" then
    local jsonls_opts = require "nvim.lsp.settings.jsonls"
    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
  end

  if server == "yamlls" then
    local yamlls_opts = require "nvim.lsp.settings.yamlls"
    opts = vim.tbl_deep_extend("force", yamlls_opts, opts)
  end

  if server == "lua_ls" then
    local l_status_ok, lua_dev = pcall(require, "lua-dev")
    if l_status_ok then
      local luadev = lua_dev.setup {
        lspconfig = {
          on_attach = opts.on_attach,
          capabilities = opts.capabilities,
        },
      }
      opts = vim.tbl_deep_extend("force", opts, luadev)
    end
    vim.lsp.config[server] = opts
    goto continue
  end

  if server == "tsserver" or server == "ts_ls" then
    local tsserver_opts = require "nvim.lsp.settings.tsserver"
    opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
  end

  if server == "gopls" then
    local gopls_opts = require "nvim.lsp.settings.gopls"
    opts = vim.tbl_deep_extend("force", gopls_opts, opts)
  end

  if server == "pyright" then
    local pyright_opts = require "nvim.lsp.settings.pyright"
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

  if server == "solc" then
    local solc_opts = require "nvim.lsp.settings.solc"
    opts = vim.tbl_deep_extend("force", solc_opts, opts)
  end

  if server == "emmet_ls" then
    local emmet_ls_opts = require "nvim.lsp.settings.emmet_ls"
    opts = vim.tbl_deep_extend("force", emmet_ls_opts, opts)
  end

  if server == "zk" then
    local zk_opts = require "nvim.lsp.settings.zk"
    opts = vim.tbl_deep_extend("force", zk_opts, opts)
  end

  if server == "jdtls" then
    goto continue
  end

  if server == "rust_analyzer" then
    -- rust_analyzer is configured via rustaceanvim plugin
    -- which handles setup automatically
    goto continue
  end

  -- Use new vim.lsp.config API (Neovim 0.11+)
  vim.lsp.config[server] = opts
  ::continue::
end

-- TODO: add something to installer later
-- require("lspconfig").motoko.setup {}