local status_ok, opencode = pcall(require, "opencode")
if not status_ok then
  return
end

---@type opencode.Opts
vim.g.opencode_opts = {}

vim.o.autoread = true
