autocmd BufWritePre,TextChanged,InsertLeave *.lua lua vim.lsp.buf.formatting()
