" terraform
autocmd BufWritePre *.tf lua vim.lsp.buf.formatting_sync()

" javascript
autocmd! BufRead,BufNewFile *.{jsx,jx,js} setlocal filetype=javascript.jsx
autocmd FileType javascript.jsx setlocal commentstring={/*\ %s\ */}

" lua
autocmd BufWritePre *.lua lua vim.lsp.buf.formatting()
