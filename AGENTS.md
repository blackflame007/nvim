# PROJECT KNOWLEDGE BASE

**Generated:** 2026-03-12 (post-cleanup)
**Commit:** 79dfb5d
**Branch:** master

## OVERVIEW

Lua-based Neovim config (~7.3k LOC) using lazy.nvim. 62 modules loaded sequentially from `init.lua`. Part of a dotfiles repo at `~/.dotfiles/nvim/.config/nvim`.

## STRUCTURE

```
.
├── init.lua                 # Entry point — sequential require of all 67 modules
├── lua/
│   ├── nvim/                # ALL config modules live here
│   │   ├── lazy.lua         # Plugin manager bootstrap + 100+ plugin specs
│   │   ├── options.lua      # vim.opt settings
│   │   ├── keymaps.lua      # Global keymaps (vim.api.nvim_set_keymap)
│   │   ├── whichkey.lua     # Leader keymaps (which-key structured format)
│   │   ├── autocommands.lua # Autocmds (vim.api.nvim_create_autocmd)
│   │   ├── functions.lua    # Custom utilities (toggle_option, smart_quit, etc.)
│   │   ├── icons.lua        # Centralized icon definitions
│   │   ├── lsp/             # LSP subsystem (see lua/nvim/lsp/AGENTS.md)
│   │   └── bfs/             # Custom buffer filesystem module (4 files)
│   └── split.lua            # String:split monkey-patch utility
├── after/
│   ├── file.lua             # Post-plugin: ToggleTerm command wrapper
│   └── syntax/markdown.vim  # Custom markdown syntax (YAML/TOML frontmatter, math)
├── .stylua.toml             # Formatter config
├── .luarc.json              # Lua LS config
└── lazy-lock.json           # Plugin version lock
```

## WHERE TO LOOK

| Task | Location | Notes |
|------|----------|-------|
| Add a new plugin | `lua/nvim/lazy.lua` + new `lua/nvim/{plugin}.lua` | Spec in lazy.lua, config in own file |
| Add keymaps | `lua/nvim/keymaps.lua` OR `lua/nvim/whichkey.lua` | Basic → keymaps.lua, leader-based → whichkey.lua |
| Change editor options | `lua/nvim/options.lua` | Uses `vim.opt[k] = v` loop pattern |
| Add autocommands | `lua/nvim/autocommands.lua` | Use `vim.api.nvim_create_autocmd` with augroup |
| Configure LSP server | `lua/nvim/lsp/settings/{server}.lua` | See `lsp/AGENTS.md` |
| Add LSP server | `lua/nvim/lsp/mason.lua` | Add to `servers` table |
| Change colorscheme | `lua/nvim/colorscheme.lua` | Currently tokyonight-night, transparent bg |
| Add utility function | `lua/nvim/functions.lua` | `M.func_name = function() ... end` pattern |
| Modify completion | `lua/nvim/cmp.lua` | Sources priority: copilot > lsp > luasnip > buffer |
| Add formatters/linters | `lua/nvim/lsp/none-ls.lua` | Uses none-ls (null-ls fork) |
| Debug configuration | `lua/nvim/dap.lua` | DAP with dap-ui and virtual text |
| Toggleterm terminals | `lua/nvim/toggleterm.lua` | lazygit, node, ncdu, htop, python |

## CONVENTIONS

### Module Pattern (MANDATORY for every file)
```lua
local status_ok, module = pcall(require, "plugin-name")
if not status_ok then
  return
end
```
Used 178 times across 66 files. Every plugin require MUST use pcall.

### Module Export Pattern
```lua
local M = {}
M.func_name = function() ... end
return M
```

### Keymap Dual System
- **`keymaps.lua`**: `vim.api.nvim_set_keymap` with `{noremap = true, silent = true}`
- **`whichkey.lua`**: `which_key.add(mappings)` with structured table `{ "<leader>x", "<cmd>...<cr>", desc = "...", icon = {...} }`
- LSP keymaps: in `lsp/handlers.lua` on_attach

### Autocommand Pattern
```lua
vim.api.nvim_create_augroup("GroupName", { clear = true })
vim.api.nvim_create_autocmd({ "Event" }, {
  group = "GroupName",
  pattern = { "*.ext" },
  callback = function() ... end,
})
```

### Option Setting
- `vim.opt[k] = v` — primary (loop in options.lua)
- `vim.g.x = y` — global variables only
- `vim.cmd "..."` — escape hatch for vimscript-only features

### Formatting
- **StyLua**: 120 col, 2-space indent, Unix line endings, double quotes preferred, no call parentheses
- Run: `stylua .` from project root

## ANTI-PATTERNS (THIS PROJECT)

- **DO NOT** use `require` without `pcall` wrapper — config must be resilient to missing plugins
- **DO NOT** add keymaps outside `keymaps.lua`, `whichkey.lua`, or plugin-specific on_attach — scattered keymaps are untraceable
- **DO NOT** use `vim.cmd "autocmd ..."` — use `vim.api.nvim_create_autocmd` (line 97 in autocommands.lua is a known violation)
- **KNOWN BUG**: `vim.cmd "set formatoptions-=cro"` in options.lua doesn't work (autocmds reset it)

## LOAD ORDER

```
init.lua loads in this exact sequence:
1. hot-reload    (dev utility)
2. options       (editor settings)
3. lazy          (plugin manager bootstrap + specs)
4. autocommands  (event handlers)
5. keymaps       (global keybindings)
6. colorscheme   (theme)
7-62. plugins    (each with own pcall-guarded setup)
```

Changing order can break dependencies. `cmp` must load before `lsp`. `lazy` must load before everything that uses plugins.

## COMMANDS

```bash
# Format Lua files
stylua .

# Check health
nvim +checkhealth

# Sync plugins
nvim +"Lazy sync"

# Update plugins
nvim +"Lazy update"
```

## NOTES

- Config is part of dotfiles — symlinked from `~/.dotfiles/nvim/.config/nvim`
- Neovim >= 0.11.1 required
- `icons.lua` is the single source for all UI icons — import from there, don't hardcode
- `bfs/` is a custom hand-written module (buffer filesystem), not a plugin
- `split.lua` monkey-patches `string:split` — available globally after first require
- Language-specific: Rust (rustacean + crates), Go (go.nvim), Solidity (solc/solang LSP)
