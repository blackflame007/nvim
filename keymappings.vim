" delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d

lua require('telescope').setup({defaults = {file_sorter = require('telescope.sorters').get_fzy_sorter}})

nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>pf :lua require('telescope.builtin').find_files()<CR>

nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
" Search Help
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>vrc :lua require('nvim.telescope').search_dotfiles()<CR>
nnoremap <leader>va :lua require('nvim.telescope').anime_selector()<CR>
nnoremap <leader>vc :lua require('nvim.telescope').chat_selector()<CR>
" Git Checkout
nnoremap <leader>gc :lua require('nvim.telescope').git_branches()<CR>
nnoremap <leader>gw :lua require('telescope').extensions.git_worktree.git_worktrees()<CR>
nnoremap <leader>gm :lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>
nnoremap <leader>td :lua require('nvim.telescope').dev()<CR>

" Comments
nnoremap <leader>/ :lua require('Comment.api').toggle()<CR>
vnoremap <leader>/ :lua require('Comment.api').gc(vim.fn.visualmode())<CR>, { noremap = true, silent = true })<CR>

" Buffers
noremap <C-w> :bd!<Cr>

" Explorer
nnoremap <C-e> :NERDTreeToggle<CR>

" Terminal
tnoremap <Esc> <C-\><C-n>
