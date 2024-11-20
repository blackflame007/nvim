local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

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
  },
  {
    "<leader>b",
    "<cmd>Telescope buffers<cr>",
    desc = "Buffers",
    icon = { icon = "󰓩 ", color = "blue" },
  },
  {
    "<leader>e",
    "<cmd>NvimTreeToggle<cr>",
    desc = "Explorer",
    icon = { icon = " ", color = "green" },
  },
  {
    "<leader>w",
    "<cmd>w!<CR>",
    desc = "Save",
    icon = { icon = "󰆓 ", color = "green" },
  },
  {
    "<leader>q",
    "<cmd>q!<CR>",
    desc = "Quit",
    icon = { icon = " ", color = "red" },
  },
  {
    "<leader>c",
    "<cmd>Bdelete!<CR>",
    desc = "Close Buffer",
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
    icon = { icon = " ", color = "purple" },
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

  -- Packer group
  {
    "<leader>p",
    group = "Packer",
    icon = { icon = " ", color = "azure" },
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
    "<cmd>PackerSync<cr>",
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
    icon = { icon = " ", color = "orange" },
  },
  {
    "<leader>gg",
    "<cmd>lua _LAZYGIT_TOGGLE()<CR>",
    desc = "Lazygit",
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
  -- ... rest of git mappings ...

  -- LSP group
  {
    "<leader>l",
    group = "LSP",
    icon = { icon = " ", color = "blue" },
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
  },
  -- ... rest of LSP mappings ...
}

which_key.setup(setup)
which_key.add(mappings)
