" pathogen

execute pathogen#infect()

" airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" syntax
syntax on
filetype plugin indent on
" set termguicolors
set nocompatible

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

if or(has('gui_running'), has('gui_vimr'))
    colorscheme base16-atelier-dune
else
    colorscheme sidewalk-dark
end

augroup filetypes
    au!
    " odt
    au BufReadPost *.odt :%!pandoc % -f odt -t markdown
    au BufWritePost *.odt :%!pandoc -f markdown -t odt -o %

    " scala
    " au BufRead,BufNewFile,BufFilePre *.scala set filetype=scala
    " au! Syntax source ~/.vim/syntax/scala.vim

    " markdown
    au BufRead,BufNewFile,BufFilePre *.md set filetype=markdown
    au BufRead,BufNewFile,BufFilePre README set filetype=markdown

    " sml
    au BufRead,BufNewFile,BufFilePre *.sml set tabstop=8 shiftwidth=3
    au BufRead,BufNewFile,BufFilePre *.sig set tabstop=8 shiftwidth=3
    au BufRead,BufNewFile,BufFilePre *.fun set tabstop=8 shiftwidth=3
    au BufRead,BufNewFile,BufFilePre *.mlb set tabstop=8 shiftwidth=3
    au BufRead,BufNewFile,BufFilePre *.sxml set tabstop=8 softtabstop=3 shiftwidth=3 filetype=sml
    au BufRead,BufNewFile,BufFilePre *.ssa set tabstop=8 softtabstop=3 shiftwidth=3 filetype=sml
    au BufRead,BufNewFile,BufFilePre *.ssa2 set tabstop=8 softtabstop=3 shiftwidth=3 filetype=sml

augroup END


" highlighting
"let &colorcolumn="80,".join(range(120,999),",")
"highlight ColorColumn ctermbg=DarkGray
"hi CursorLine cterm=underline ctermbg=Black
"set cursorline
hi CursorColumn ctermbg=Black
hi Search cterm=inverse ctermfg=Yellow ctermbg=NONE
hi ColorColumn ctermbg=DarkGray guibg=LightGray

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

" retabs
command! -range=% -nargs=0 Tab2Space execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'
command! -range=% -nargs=0 Space2Tab execute '<line1>,<line2>s#^\( \{'.&ts.'\}\)\+#\=repeat("\t", len(submatch(0))/' . &ts . ')'

" color the current column, for lining things up
" also works as a mark for __
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

" moves the cursor to the first nonwhitespace before column
" function! SearchBefCol (col, flags)
"     call cursor(0, a:col)
"     call search('\%<' . string(virtcol('.')) . 'v\S', a:flags)
" endfunction

" find next text upwards in column
" nnoremap <silent> <leader>?_ :call SearchBefCol(&cc, "bWz")<cr>
" nnoremap <silent> <leader>/_ :call SearchBefCol(&cc, "Wz")<cr>
" nnoremap <silent> <leader>_? :call SearchBefCol(&cc, "bWz")<cr>
" nnoremap <silent> <leader>_/ :call SearchBefCol(&cc, "Wz")<cr>
" nnoremap <silent> <leader>?. :call SearchBefCol(col("."), "bWz")<cr>
" nnoremap <silent> <leader>/. .call SearchBefCol(col("."), "Wz")<cr>
" nnoremap <silent> <leader>.? :call SearchBefCol(col("."), "bWz")<cr>
" nnoremap <silent> <leader>./ :call SearchBefCol(col("."), "Wz")<cr>

" insert single character
nnoremap <C-i> i_<esc>r
nnoremap <C-a> a_<esc>r

" edit vimrc
nnoremap <leader>ss :source ~/.vim/vimrc<cr>
nnoremap <leader>sb :bufdo source ~/.vim/vimrc<cr>
nnoremap <leader>se :e ~/.vim/vimrc<cr>

" buffer jetpack
nnoremap gb :ls<cr>:b<space>

" eclim shortcuts
nnoremap <localleader>ef :LocateFile<cr>
nnoremap <localleader>jl :ProjectList<cr>
nnoremap <localleader>jt :ProjectTree<cr>
nnoremap <localleader>ja :Ant

" useful eclim aliases
command! LF LocateFile
command! PL ProjectList
command! PT ProjectTree
command! WS WorkspaceSettings

" eclim java-specific shortcuts
augroup Java
    au!
    au FileType java nnoremap <buffer> <localleader>jr :JavaRename<Space>
    au FileType java nnoremap <buffer> <localleader>jg :JavaGet<cr>
    au FileType java nnoremap <buffer> <localleader>js :JavaSet<cr>
    au FileType java nnoremap <buffer> <localleader>jb :JavaGetSet<cr>
    au FileType java nnoremap <buffer> <localleader>jc :JavaConstructor<cr>
    au FileType java nnoremap <buffer> <localleader>ji :JavaImport<cr>
    au FileType java nnoremap <buffer> <localleader>jo :JavaImportOrganize<cr>
    au FileType java nnoremap <buffer> <localleader>jf :JavaSearch<cr>
    au FileType java nnoremap <buffer> <localleader>p ipublic <esc>
augroup END


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
