-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup({
  spec = {
    -- Plugin Manager
    "folke/lazy.nvim",

    -- Lua Development
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
    "christianchiarulli/lua-dev.nvim",

    -- LSP
    "neovim/nvim-lspconfig",
    "williamboman/nvim-lsp-installer",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "jose-elias-alvarez/null-ls.nvim",
    "ray-x/lsp_signature.nvim",
    "SmiteshP/nvim-navic",
    "simrat39/symbols-outline.nvim",
    "b0o/SchemaStore.nvim",
    { "github/copilot.vim", lazy = false },
    {
      "RRethy/vim-illuminate",
      event = { "BufReadPost", "BufNewFile" },
      config = function()
        require("illuminate").configure({
          providers = {
            "lsp",
            "treesitter",
            "regex",
          },
          delay = 120,
          filetypes_denylist = {
            "dirvish",
            "fugitive",
            "alpha",
            "NvimTree",
            "packer",
            "neogitstatus",
            "Trouble",
            "lir",
            "Outline",
            "spectre_panel",
            "toggleterm",
            "DressingSelect",
            "TelescopePrompt",
          },
          filetypes_allowlist = {},
          modes_denylist = {},
          modes_allowlist = {},
          providers_regex_syntax_denylist = {},
          providers_regex_syntax_allowlist = {},
          under_cursor = true,
        })
      end,
    },
    "j-hui/fidget.nvim",
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    {
      "ray-x/go.nvim",
      dependencies = { -- optional packages
        "ray-x/guihua.lua",
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
      },
      config = function()
        require("go").setup()
      end,
      event = { "CmdlineEnter" },
      ft = { "go", 'gomod' },
      build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    },
    -- Debugging
    {
      "mfussenegger/nvim-dap",
      dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "blackflame007/DAPInstall.nvim",
      },
    },

    -- Completion
    {
      "christianchiarulli/nvim-cmp",
      dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "rcarriga/cmp-dap",
        "hrsh7th/cmp-emoji",
        "hrsh7th/cmp-nvim-lua",
        "zbirenbaum/copilot-cmp",
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
      },
      event = { "InsertEnter", "CmdlineEnter" },
      config = true,
    },

    -- Continue converting the rest of your plugins...
    -- I'll show a few more examples of different plugin formats:

    -- Markdown with build command
    -- {
    --   "iamcco/markdown-preview.nvim",
    --   build = "cd app && npm install",
    --   ft = "markdown",
    -- },

    -- Plugin with dependencies
    {
      "abecodes/tabout.nvim",
      dependencies = { "nvim-treesitter" },
    },

    -- Plugin with build command
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },

    -- Plugin with run command converted to build
    {
      "ray-x/guihua.lua",
      build = "cd lua/fzy && make",
    },

    -- Plugin with requires converted to dependencies
    {
      "nvim-tree/nvim-tree.lua",
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
    },

    -- Add these essential plugins
    {
      "nvim-telescope/telescope.nvim",
      branch = "0.1.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-fzf-native.nvim",
        "nvim-telescope/telescope-media-files.nvim",
        "tom-anders/telescope-vim-bookmarks.nvim",
        "ThePrimeagen/git-worktree.nvim",
      },
      cmd = "Telescope",
      opts = function()
        return require("nvim.telescope")
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
        "p00f/nvim-ts-rainbow",
        "nvim-treesitter/playground",
        "windwp/nvim-ts-autotag",
        "nvim-treesitter/nvim-treesitter-textobjects",
      },
      event = { "BufReadPost", "BufNewFile" },
      opts = function()
        return require("nvim.treesitter")
      end,
    },

    {
      "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
      opts = {
        indent = {
          char = "│",
          tab_char = "│",
        },
        scope = { enabled = true },
        exclude = {
          filetypes = {
            "help",
            "alpha",
            "dashboard",
            "neo-tree",
            "Trouble",
            "lazy",
            "notify",
            "toggleterm",
            "lazyterm",
          },
        },
      },
    },

    {
      "karb94/neoscroll.nvim",
      config = function()
        require('neoscroll').setup()
      end,
    },

    {
      "tversteeg/registers.nvim",
      config = function()
        require("registers").setup({
          hide_only_whitespace = true,
          show_empty = true,
          trim_whitespace = true,
          insert_mode = true,
          visual_mode = true,
          normal_mode = true,
          window = {
            border = "rounded",
            max_width = 100,
            min_height = 3
          }
        })
      end,
    },

    {
      "willothy/nvim-cokeline",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons",
      },
      config = true,
    },
    -- Snippets
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",

    -- Marks
    "christianchiarulli/harpoon",
    "MattesGroeger/vim-bookmarks",

    -- Media and Note Taking
    "nvim-telescope/telescope-media-files.nvim",
    "tom-anders/telescope-vim-bookmarks.nvim",
    "mickael-menu/zk-nvim",
    {
      "vhyrro/luarocks.nvim",
      priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
      config = true,
    },
    -- {
    --   "nvim-neorg/neorg",
    --   lazy = false,  -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    --   version = "*", -- Pin Neorg to the latest stable release
    --   config = true,
    -- },

    -- Colors and Themes
    "NvChad/nvim-colorizer.lua",
    "ziontee113/color-picker.nvim",
    "lunarvim/onedarker.nvim",
    "lunarvim/darkplus.nvim",
    "folke/tokyonight.nvim",
    "lunarvim/colorschemes",

    -- UI Utilities
    "rcarriga/nvim-notify",
    "stevearc/dressing.nvim",
    "ghillb/cybu.nvim",
    "moll/vim-bbye",
    "lewis6991/impatient.nvim",
    "lalitmee/browse.nvim",
    "echasnovski/mini.icons",

    -- Statusline and Startup
    {
      "nvim-lualine/lualine.nvim",
      dependencies = {
        "nvim-tree/nvim-web-devicons",
        "SmiteshP/nvim-navic",
      },
      event = "VeryLazy",
      config = function()
        require("nvim.lualine")
      end,
    },

    -- File Management and Project Tools
    "christianchiarulli/lir.nvim",
    "numToStr/Comment.nvim",
    "folke/todo-comments.nvim",
    "akinsho/toggleterm.nvim",
    "ahmedkhalf/project.nvim",
    "windwp/nvim-spectre",

    -- Session Management
    {
      "rmagatti/auto-session",
      dependencies = {
        "rmagatti/session-lens",
      },
    },

    -- Quickfix and Code Running
    "kevinhwang91/nvim-bqf",
    "is0n/jaq-nvim",

    -- Git Integration
    "lewis6991/gitsigns.nvim",
    "f-person/git-blame.nvim",
    "ruifm/gitlinker.nvim",
    {
      "mattn/vim-gist",
      dependencies = {
        "mattn/webapi-vim",
      },
    },

    -- GitHub Integration
    "pwntester/octo.nvim",

    -- Editing Support
    "windwp/nvim-autopairs",
    "monaqa/dial.nvim",
    "nacro90/numb.nvim",
    "andymass/vim-matchup",
    "folke/zen-mode.nvim",
    "junegunn/vim-slash",

    -- Motion and Navigation
    "phaazon/hop.nvim",
    "folke/which-key.nvim",

    -- Language Specific
    "mfussenegger/nvim-jdtls",
    {
      "christianchiarulli/rust-tools.nvim",
      branch = "modularize_and_inlay_rewrite",
    },
    "Saecki/crates.nvim",
    "jose-elias-alvarez/typescript.nvim",

    -- Additional Tools
    "folke/trouble.nvim",

    -- Surround
    {
      "kylechui/nvim-surround",
      event = "VeryLazy",
      config = function()
        require("nvim-surround").setup()
      end,
    },

    {
      "goolord/alpha-nvim",
      event = "VimEnter",
      config = function()
        require("nvim.alpha")
      end,
    },

    {
      "tzachar/cmp-tabnine",
      build = "./install.sh",
      dependencies = "hrsh7th/nvim-cmp",
      event = "InsertEnter",
    },

    -- LSP
    "neovim/nvim-lspconfig",
    "williamboman/nvim-lsp-installer",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    {
      "nvimtools/none-ls.nvim",
      dependencies = {
        "nvimtools/none-ls-extras.nvim",
      },
    },
  },

  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

