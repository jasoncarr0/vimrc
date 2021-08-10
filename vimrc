
set nocompatible
" pathogen
" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" execute pathogen#infect()
" set rtp+=fnamemodify(expand("$VIM_PLUGINS",':f:p'))

call plug#begin('~/.vim/plugged')

Plug 'https://github.com/vim-airline/vim-airline.git'
Plug 'https://github.com/vim-ariline/vim-airline-themes.git'
Plug 'https://github.com/tpope/vim-vinegar.git'

Plug 'https://github.com/jasoncarr0/sidewalk-colorscheme.git'

call plug#end()

" syntax
syntax on
filetype plugin indent on

" various settings

set incsearch hlsearch              " incremental search, highlights results
set clipboard+=unnamed,unnamedplus  " system clipboard for yank and put
set scrolloff=7                     " leaves seven characters before scrolling
set autoindent smartindent
set expandtab tabstop=4 shiftwidth=4
set smarttab 
set backup noswapfile writebackup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set wildmode=longest:list,full
set splitbelow splitright
set number relativenumber

if or(has('gui_running'), has('gui_vimr'))
    colorscheme base16-atelier-dune
else
    colorscheme sidewalk-dark
    let g:airline_theme="deus"
end


" airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" set termguicolors
set nocompatible

"""""""""""""
" Shortcuts "
"""""""""""""

" mappings
let mapleader= ","
let maplocalleader = "\\"
noremap <space> :

" aliases because shift
command! WQ wq
command! Wq wq
command! W w
command! Q q

" faster windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" move by visual lines
nnoremap j gj
nnoremap k gk

" remove nuisance keys
nnoremap <F1> <nop>

" buffer jetpack
nnoremap gb :ls<cr>:b<space>

" retabs
command! -range=% -nargs=0 Tab2Space execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'
command! -range=% -nargs=0 Space2Tab execute '<line1>,<line2>s#^\( \{'.&ts.'\}\)\+#\=repeat("\t", len(submatch(0))/' . &ts . ')'

" color the current column, for lining things up
" also works as a mark for __
" highlighting
"let &colorcolumn="80,".join(range(120,999),",")
"highlight ColorColumn ctermbg=DarkGray
"hi CursorLine cterm=underline ctermbg=Black
"set cursorline
hi CursorColumn ctermbg=Black
hi Search cterm=inverse ctermfg=Yellow ctermbg=NONE
hi ColorColumn ctermbg=DarkGray guibg=LightGray
"
function! StickColumn()
   if &cc == virtcol(".")
      let &cc=0
   else
      let &cc=virtcol(".")
   endif
endfunction
nnoremap <silent> z_ :call StickColumn()<cr>
" jump to column
nnoremap <silent> g_ :execute "normal" &cc . "\|"<cr>

" insert single character
nnoremap <C-i> i_<esc>r
nnoremap <C-a> a_<esc>r

" edit vimrc
nnoremap <leader>ss :source ~/.vim/vimrc<cr>
nnoremap <leader>sb :bufdo source ~/.vim/vimrc<cr>
nnoremap <leader>se :e ~/.vim/vimrc<cr>

" matching
augroup SpecialSyntax
   au!
   au Syntax * syntax match ExtraSpaces /\s\+$/
   au Syntax * hi ExtraSpaces ctermbg=magenta guibg=Gray
augroup END
syntax match ExtraSpaces /\s\+$/
hi ExtraSpaces ctermbg=Gray guibg=Gray

" Scratch buffers with options, credit:
" http://dhruvasagar.com/2014/03/11/creating-custom-scratch-buffers-in-vim
function! ScratchEdit(cmd, options)
   exe a:cmd tempname()
   setl buftype=nofile bufhidden=wipe noswapfile
   " silent file Scratch~
   if !empty(a:options) | exe 'setl' a:options | endif
endfunction

command! -bar -nargs=* Sedit call ScratchEdit('edit', <q-args>)
command! -bar -nargs=* Ssplit call ScratchEdit('split', <q-args>)
command! -bar -nargs=* Svsplit call ScratchEdit('vsplit', <q-args>)
command! -bar -nargs=* Stabedit call ScratchEdit('tabe', <q-args>)

nnoremap <silent> <leader>re :Sedit<cr>
nnoremap <silent> <leader>rv :Ssplit<cr>
nnoremap <silent> <leader>rp :Svsplit<cr>

nnoremap <silent> <leader>dp :split<cr>
nnoremap <silent> <leader>dv :vsplit<cr>

" toggle numbers
nnoremap <silent> <leader>an :set number! relativenumber!<cr>
" turn off search highlighting temporarily
nnoremap <silent> <leader>ah :noh<cr>

" writing and quitting
nnoremap <leader>w :w<cr>
nnoremap <leader>qq :q<cr>
nnoremap <leader>e :e<space>


""""""""""""""
" Misc fixes "
""""""""""""""

" tmux fix
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
else
    let &t_SI = "\e[5 q"
    let &t_EI = "\e[2 q"
endif
"
