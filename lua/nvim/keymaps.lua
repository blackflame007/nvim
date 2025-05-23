M = {}
local opts = {noremap = true, silent = true}

local term_opts = {silent = true}
-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
keymap("n", "<C-Space>", "<cmd>WhichKey \\<leader><cr>", opts)
keymap("n", "<C-i>", "<C-i>", opts)

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "p", '"_dP', opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Custom


require('telescope').setup({defaults = {file_sorter = require('telescope.sorters').get_fzy_sorter}})

keymap("n", "<Leader>ps", "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep For > ')})<CR>", opts)
keymap("n", "<Leader>pw", "<cmd>lua require('telescope.builtin').grep_string { search = vim.fn.expand('<cword>') }<CR>", opts)
keymap("n", "<C-p>", "<cmd>lua require('telescope.builtin').git_files()<CR>", opts)

keymap("n", "Q", "<cmd>Bdelete!<CR>", opts)
keymap("n", "<F1>", ":e ~/Notes/<cr>", opts)

keymap("i", "<F2>", '<cmd>lua require("renamer").rename({empty = true})<cr>', {noremap = true, silent = true})
keymap("n", "<F2>", '<cmd>lua require("renamer").rename({empty = true})<cr>', {noremap = true, silent = true})
keymap("n", "<F3>", ":e .<cr>", opts)
keymap("n", "<F4>", "<cmd>Telescope resume<cr>", opts)
keymap("n", "<F5>", "<cmd>Telescope commands<CR>", opts)
keymap("n", "<F6>", "<cmd>TSHighlightCapturesUnderCursor<cr>", opts)
keymap("n", "<F7>", "<cmd>TSPlaygroundToggle<cr>", opts)
keymap("n", "<F11>", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
keymap("n", "<F12>", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "<C-z>", "<cmd>ZenMode<cr>", opts)
keymap("n", "<c-n>", ":e ~/Notes/<cr>", opts)

-- Neorg
keymap("n", ",nn", "<Plug>(neorg.dirman.new-note)", opts)
keymap("n", ",td", "<Plug>(neorg.qol.todo-items.todo.task-done)", opts)

-- Insert mode keymaps
keymap("i", "<C-d>", "<Plug>(neorg.promo.demote)", opts)
keymap("i", "<C-t>", "<Plug>(neorg.promo.promote)", opts)
keymap("i", "<M-CR>", "<Plug>(neorg.itero.next-iteration)", opts)
keymap("i", "<M-d>", "<Plug>(neorg.tempus.insert-date.insert-mode)", opts)

-- Normal mode keymaps
keymap("n", "<,", "<Plug>(neorg.promo.demote)", opts)
keymap("n", "<<", "<Plug>(neorg.promo.demote.nested)", opts)
keymap("n", "<C-Space>", "<Plug>(neorg.qol.todo-items.todo.task-cycle)", opts)
keymap("n", "<CR>", "<Plug>(neorg.esupports.hop.hop-link)", opts)
keymap("n", ",cm", "<Plug>(neorg.looking-glass.magnify-code-block)", opts)
keymap("n", ",id", "<Plug>(neorg.tempus.insert-date)", opts)
keymap("n", ",li", "<Plug>(neorg.pivot.list.invert)", opts)
keymap("n", ",lt", "<Plug>(neorg.pivot.list.toggle)", opts)

-- Task management
keymap("n", ",ta", "<Plug>(neorg.qol.todo-items.todo.task-ambiguous)", opts)
keymap("n", ",tc", "<Plug>(neorg.qol.todo-items.todo.task-cancelled)", opts)
keymap("n", ",th", "<Plug>(neorg.qol.todo-items.todo.task-on-hold)", opts)
keymap("n", ",ti", "<Plug>(neorg.qol.todo-items.todo.task-important)", opts)
keymap("n", ",tp", "<Plug>(neorg.qol.todo-items.todo.task-pending)", opts)
keymap("n", ",tr", "<Plug>(neorg.qol.todo-items.todo.task-recurring)", opts)
keymap("n", ",tu", "<Plug>(neorg.qol.todo-items.todo.task-undone)", opts)

-- Additional navigation
keymap("n", "<M-CR>", "<Plug>(neorg.esupports.hop.hop-link.vsplit)", opts)
keymap("n", ">.", "<Plug>(neorg.promo.promote)", opts)
keymap("n", ">>", "<Plug>(neorg.promo.promote.nested)", opts)

-- -- Visual mode keymaps
-- keymap("v", "<", "<Plug>(neorg.promo.demote.range)", opts)
-- keymap("v", ">", "<Plug>(neorg.promo.promote.range)", opts)

M.show_documentation = function()
    local filetype = vim.bo.filetype
    if vim.tbl_contains({"vim", "help"}, filetype) then
        vim.cmd("h " .. vim.fn.expand "<cword>")
    elseif vim.tbl_contains({"man"}, filetype) then
        vim.cmd("Man " .. vim.fn.expand "<cword>")
    elseif vim.fn.expand "%:t" == "Cargo.toml" then
        require("crates").show_popup()
    else
        vim.lsp.buf.hover()
    end
end

vim.api.nvim_set_keymap("n", "K", ":lua require('nvim.keymaps').show_documentation()<CR>", opts)

-- Inlay hints
keymap("n", "<leader>ih", "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(), { bufnr = 0 })<CR>", opts)

return M
