" Neoformat

" Don't forget to install prettier globally (npm install -g prettier)
autocmd FileType javascript nmap <buffer> <LEADER>b :Neoformat<CR>
autocmd BufWritePre *.js Neoformat
autocmd FileType javascript setlocal formatprg=prettier\ --stdin\ --parser\ typescript

autocmd FileType json nmap <buffer> <LEADER>b :Neoformat<CR>
autocmd BufWritePre *.json Neoformat
autocmd FileType json setlocal formatprg=prettier\ --stdin\ --parser\ json

autocmd FileType typescript nmap <buffer> <LEADER>b :Neoformat<CR>
" autocmd BufWritePre *.ts Neoformat " Disabled because I find it cumbersome
autocmd FileType typescript setlocal formatprg=prettier\ --stdin\ --parser\ typescript

autocmd FileType scss nmap <buffer> <LEADER>b :Neoformat<CR>
autocmd BufWritePre *.scss Neoformat
autocmd FileType scss setlocal formatprg=prettier\ --stdin\ --parser\ css

autocmd FileType yaml nmap <buffer> <LEADER>b :Neoformat<CR>
autocmd BufWritePre *.yml Neoformat
autocmd BufWritePre *.yaml Neoformat
autocmd FileType yaml setlocal formatprg=prettier\ --stdin\ --parser\ yaml

let g:neoformat_try_formatprg = 1 
