local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local icons = require "nvim.icons"

local setup = {
  plugins = {
    marks = true,
    registers = true,
    spelling = {
      enabled = true,
      suggestions = 20,
    },
    presets = {
      operators = false,
      motions = false,
      text_objects = false,
      windows = false,
      nav = false,
      z = false,
      g = false,
    },
  },
  win = {
    border = "rounded",
    no_overlap = false,
    padding = { 1, 2 },
    title = false,
    title_pos = "center",
    zindex = 1000,
  },
  show_help = false,
  show_keys = false,
  disable = {
    buftypes = {},
    filetypes = { "TelescopePrompt" },
  },
}

local mappings = {
  {
    "<leader>a",
    "<cmd>Alpha<cr>",
    desc = "Alpha",
    icon = { icon = icons.ui.Dashboard, color = "blue" },
  },
  {
    "<leader>b",
    "<cmd>Telescope buffers<cr>",
    desc = "Buffers",
    icon = { icon = icons.ui.List, color = "blue" },
  },
  {
    "<leader>e",
    "<cmd>NvimTreeToggle<cr>",
    desc = "Explorer",
    icon = { icon = icons.documents.Files, color = "green" },
  },
  {
    "<leader>w",
    "<cmd>w!<CR>",
    desc = "Save",
    icon = { icon = icons.ui.Save, color = "green" },
  },
  {
    "<leader>q",
    "<cmd>q!<CR>",
    desc = "Quit",
    icon = { icon = icons.ui.Close, color = "red" },
  },
  {
    "<leader>c",
    "<cmd>Bdelete!<CR>",
    desc = "Close Buffer",
    icon = { icon = icons.ui.CloseBuffer, color = "red" },
  },
  {
    "<leader>h",
    "<cmd>nohlsearch<CR>",
    desc = "No Highlight",
    hidden = true,
  },
  {
    "<leader>f",
    group = "Find",
    icon = { icon = icons.ui.Search, color = "azure" },
  },
  {
    "<leader>ff",
    "<cmd>Telescope find_files<cr>",
    desc = "Find files",
  },
  {
    "<leader>fg",
    "<cmd>Telescope live_grep<cr>",
    desc = "Find Text",
  },
  {
    "<leader>fp",
    "<cmd>Telescope projects<cr>",
    desc = "Projects",
  },
  {
    "<leader>/",
    "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>",
    desc = "Toggle Comment",
    icon = { icon = icons.ui.Comment, color = "green" },
  },
  {
    mode = { "v" },
    "<leader>/",
    "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
    desc = "Toggle Comment",
    icon = { icon = icons.ui.Comment, color = "green" },
  },

  -- Packer group
  {
    "<leader>p",
    group = "Packer",
    icon = { icon = icons.ui.Package, color = "azure" },
  },
  {
    "<leader>pc",
    "<cmd>PackerCompile<cr>",
    desc = "Compile",
  },
  {
    "<leader>pi",
    "<cmd>PackerInstall<cr>",
    desc = "Install",
  },
  {
    "<leader>ps",
    "<cmd>Lazy sync<cr>",
    desc = "Sync",
  },
  {
    "<leader>pS",
    "<cmd>PackerStatus<cr>",
    desc = "Status",
  },
  {
    "<leader>pu",
    "<cmd>PackerUpdate<cr>",
    desc = "Update",
  },

  -- Git group
  {
    "<leader>g",
    group = "Git",
    icon = { icon = icons.git.Octoface, color = "orange" },
  },
  {
    "<leader>gg",
    "<cmd>lua _LAZYGIT_TOGGLE()<CR>",
    desc = "Lazygit",
    icon = { icon = icons.git.Octoface, color = "orange" },
  },
  {
    "<leader>gj",
    "<cmd>lua require 'gitsigns'.next_hunk()<cr>",
    desc = "Next Hunk",
  },
  {
    "<leader>gk",
    "<cmd>lua require 'gitsigns'.prev_hunk()<cr>",
    desc = "Prev Hunk",
  },

  -- LSP group
  {
    "<leader>l",
    group = "LSP",
    icon = { icon = icons.ui.Gear, color = "blue" },
  },
  {
    "<leader>la",
    "<cmd>lua vim.lsp.buf.code_action()<cr>",
    desc = "Code Action",
  },
  {
    "<leader>ld",
    "<cmd>Telescope diagnostics bufnr=0<cr>",
    desc = "Document Diagnostics",
    icon = { icon = icons.ui.HeartBeat, color = "blue" },
  },
}

which_key.setup(setup)
which_key.add(mappings)
