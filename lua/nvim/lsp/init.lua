M = {}
local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then return end

M.server_capabilities = function()
    local active_clients = vim.lsp.get_active_clients()
    local active_client_map = {}

    for index, value in ipairs(active_clients) do active_client_map[value.name] = index end

    vim.ui.select(vim.tbl_keys(active_client_map), {
        prompt = "Select client:",
        format_item = function(item)
            return "capabilites for: " .. item
        end
    }, function(choice)
        -- print(active_client_map[choice])
        print(vim.inspect(vim.lsp.get_active_clients()[active_client_map[choice]].server_capabilities
                              .executeCommandProvider))
        vim.pretty_print(vim.lsp.get_active_clients()[active_client_map[choice]].server_capabilities)
    end)
end

local function make_server_ready()
    lsp_installer.on_server_ready(function(server)
        local opts = config()

        -- (optional) Customize the options passed to the server
        if server.name == "sumneko_lua" then
            opts.settings = {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT',
                        -- Setup your lua path
                        path = runtime_path
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = {'vim'}
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = vim.api.nvim_get_runtime_file("", true)
                    },
                    -- Do not send telemetry data containing a randomized but unique identifier
                    telemetry = {enable = false}
                }
            }
        end

        if server.name == "efm" then
            opts = {
                init_options = {documentFormatting = true},
                filetypes = {"lua"},
                settings = {
                    rootMarkers = {".git/"},
                    languages = {
                        lua = {
                            {
                                formatCommand = "lua-format -i --no-keep-simple-function-one-line --no-break-after-operator --column-limit=110 --break-after-table-lb",
                                formatStdin = true
                            }
                        }
                    }
                }
            }
        end
        server:setup(opts)
    end)
end

local function install_server(server)
    local lsp_installer_servers = require 'nvim-lsp-installer.servers'
    local ok, server_analyzer = lsp_installer_servers.get_server(server)
    if ok then if not server_analyzer:is_installed() then server_analyzer:install(server) end end
end
---------------------------------------------------

---------------------------------------------------
local servers = {
    'bashls', 'dockerls', 'eslint', 'sumneko_lua', 'gopls', 'pyright', 'rust_analyzer', 'terraformls',
    'vimls', 'yamlls', 'ansiblels', 'cssls', 'dotls', 'jsonls', 'hls', 'pylsp', 'cmake', 'graphql', 'tflint',
    'tsserver', 'efm'
}

-- setup the LS
make_server_ready() -- LSP mappings

-- install the LS

for _, server in ipairs(servers) do install_server(server) end

require "nvim.lsp.lsp-signature"
-- require "nvim.lsp.lsp-installer"
require("nvim.lsp.mason")
require("nvim.lsp.handlers").setup()
require "nvim.lsp.null-ls"

local l_status_ok, lsp_lines = pcall(require, "lsp_lines")
if not l_status_ok then return end

lsp_lines.setup()

return M
