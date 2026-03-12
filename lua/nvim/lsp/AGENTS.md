# LSP SUBSYSTEM

## OVERVIEW

LSP initialization chain: signature → mason → handlers → none-ls → lsp_lines. Entry: `lsp/init.lua`.

## STRUCTURE

```
lsp/
├── init.lua             # Orchestrator — requires all below in order + server_capabilities() utility
├── mason.lua            # Mason setup + lspconfig for 20 servers
├── handlers.lua         # Diagnostics config, on_attach keymaps, capabilities, format-on-save
├── lsp-signature.lua    # Signature help floating window
├── none-ls.lua          # Formatters (prettier, black, stylua, gofumpt) + linters (shellcheck, revive)
└── settings/            # Per-server overrides (return table consumed by mason.lua)
    ├── sumneko_lua.lua  # Lua LS — workspace library, diagnostics globals
    ├── rust.lua         # rust-analyzer — clippy, inlay hints, cargo features
    ├── gopls.lua        # gopls — analyses, codelenses
    ├── pyright.lua      # Pyright — type checking mode
    ├── tsserver.lua     # ts_ls — preferences, inlay hints
    ├── jsonls.lua       # JSON — schemastore integration
    ├── yamlls.lua       # YAML — schemastore, kubernetes
    ├── emmet_ls.lua     # Emmet — filetypes
    ├── solc.lua         # Solidity compiler
    ├── solang.lua       # Solidity language server
    └── zk.lua           # Zk note-taking
```

## WHERE TO LOOK

| Task | File | Notes |
|------|------|-------|
| Add new language server | `mason.lua` | Add to `servers` table, optionally create `settings/{name}.lua` |
| Change diagnostics display | `handlers.lua` | `M.setup()` configures signs, virtual text, float |
| Add LSP keymaps | `handlers.lua` | `lsp_keymaps()` in `M.on_attach` |
| Add formatter/linter | `none-ls.lua` | Use `null_ls.builtins.formatting.*` or `diagnostics.*` |
| Change server settings | `settings/{server}.lua` | Return table — merged by mason.lua via `pcall(require, "nvim.lsp.settings." .. server)` |
| Toggle format-on-save | `handlers.lua` | `M.on_attach` has `BufWritePre` autocmd |

## CONVENTIONS

### Server Settings Pattern
```lua
-- settings/{server}.lua
return {
  settings = {
    Lua = {        -- namespace matches LSP server expectation
      diagnostics = { globals = { "vim" } },
    },
  },
}
```
Mason.lua merges this via: `local opts = { on_attach = ..., capabilities = ... }` then `opts = vim.tbl_deep_extend("force", server_opts, opts)`.

### on_attach Keymaps
All LSP keymaps live in `handlers.lua → lsp_keymaps(bufnr)`. Uses `vim.api.nvim_buf_set_keymap`. Do NOT scatter LSP keymaps elsewhere.

### Capabilities
Built from `cmp_nvim_lsp.default_capabilities()` — ensures completion sources work.

## ANTI-PATTERNS

- **DO NOT** add servers outside `mason.lua` `servers` table — breaks the setup loop
- **DO NOT** add keymaps in individual `settings/*.lua` files — all LSP keymaps go in `handlers.lua`
- `init.lua` exposes global `M` (missing `local`) — known issue, don't rely on it as global

## NOTES

- Rust uses `rustacean.lua` (separate from mason) — does NOT go through mason.lua's setup loop
- Go uses `go.nvim` (separate from mason) — has its own LSP integration
- none-ls includes a custom `unwrap()` diagnostic for Rust files
- `lsp_lines` (virtual line diagnostics) is pcall-guarded at bottom of init.lua
