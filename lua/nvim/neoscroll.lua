local neoscroll = require('neoscroll')
neoscroll.setup()

local mappings = {}

mappings['<c-k>'] = function()
    neoscroll.scroll(-vim.wo.scroll, true, 250)
end

mappings['<c-j>'] = function()
    neoscroll.scroll(vim.wo.scroll, true, 250)
end

for k, v in pairs(mappings) do
    vim.keymap.set('n', k, v, { silent = true })
end
