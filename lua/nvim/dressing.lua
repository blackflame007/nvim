local status_ok, dressing = pcall(require, "dressing")
if not status_ok then
  return
end

dressing.setup {
  input = {
    -- Set to false to disable the vim.ui.input implementation
    enabled = true,

    -- Default prompt string
    default_prompt = "Input:",

    -- Can be 'left', 'right', or 'center'
    prompt_align = "left",

    -- When true, <Esc> will close the modal
    insert_only = true,

    -- These are passed to nvim_open_win
    border = "rounded",
    -- 'editor' and 'win' will default to being centered
    relative = "cursor",

    -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    prefer_width = 40,
    width = nil,
    max_width = { 140, 0.9 },
    min_width = { 20, 0.2 },
    win_options = {
      winblend = 10,
      winhighlight = "",
    },

    override = function(conf)
      conf.anchor = "SW"  -- Set the anchor as needed
      return conf
    end,

    get_config = nil,
  },
  select = {
    enabled = true,
    backend = { "builtin", "telescope", "nui" },
    trim_prompt = true,
    telescope = nil,

    nui = {
      position = "50%",
      size = nil,
      relative = "editor",
      border = { style = "rounded" },
      buf_options = { swapfile = false, filetype = "DressingSelect" },
      win_options = { winblend = 10 },
      max_width = 80,
      max_height = 40,
      min_width = 40,
      min_height = 10,
    },

    builtin = {
      border = "rounded",
      relative = "editor",
      win_options = {
        winblend = 10,
        winhighlight = "",
      },
      width = nil,
      max_width = { 140, 0.8 },
      min_width = { 40, 0.2 },
      height = nil,
      max_height = 0.9,
      min_height = { 10, 0.2 },

      override = function(conf)
        conf.anchor = "NW"  -- Set the anchor as needed
        return conf
      end,
    },

    format_item_override = {},
    get_config = nil,
  },
}
