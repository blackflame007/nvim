local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  return
end

local status_ok_1, _ = pcall(require, "lsp-inlayhints")
if not status_ok_1 then
  return
end

comment.setup {
  ignore = "^$",
  pre_hook = function(ctx)
    -- Clear inlay hints for the affected lines if inlay hints are enabled
    local line_start = (ctx.srow or ctx.range.srow) - 1
    local line_end = ctx.erow or ctx.range.erow
    
    -- Temporarily disable inlay hints during comment operation
    local inlay_hints_enabled = vim.lsp.inlay_hint.is_enabled()
    if inlay_hints_enabled then
      vim.lsp.inlay_hint.enable(false, { bufnr = 0 })
    end

    require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()

    if vim.bo.filetype == "javascript" or vim.bo.filetype == "typescript" then
      local U = require "Comment.utils"

      -- Determine whether to use linewise or blockwise commentstring
      local type = ctx.ctype == U.ctype.linewise and "__default" or "__multiline"

      -- Determine the location where to calculate commentstring from
      local location = nil
      if ctx.ctype == U.ctype.blockwise then
        location = require("ts_context_commentstring.utils").get_cursor_location()
      elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
        location = require("ts_context_commentstring.utils").get_visual_start_location()
      end
      
      -- Re-enable inlay hints after pre_hook
      if inlay_hints_enabled then
        vim.defer_fn(function()
          vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
        end, 100) -- Small delay to ensure comment operation completes
      end

      return require("ts_context_commentstring.internal").calculate_commentstring {
        key = type,
        location = location,
      }
    end
    
    -- Re-enable inlay hints after pre_hook for non-JS/TS files
    if inlay_hints_enabled then
      vim.defer_fn(function()
        vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
      end, 100) -- Small delay to ensure comment operation completes
    end
  end,
}
