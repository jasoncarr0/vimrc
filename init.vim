source ~/.vim/vimrc

let g:python3_host_prog='/usr/local/bin/python3'

" nvimrc-specific commands 
nnoremap <leader>ss :source ~/.config/nvim/init.vim<cr>
nnoremap <leader>sn :e ~/.config/nvim/init.vim<cr>

" terminal specific commands
" escape to leave term
tnoremap <Esc> <C-\><C-n>

" control-r in terminal
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
