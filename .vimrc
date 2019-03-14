
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2017 Sep 20
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

set number relativenumber
set autowriteall
set nowrap
set guioptions+=t
set runtimepath+=,~/.vim,~/.vim/plugged
set guifont=Courier_New:h9:cANSI:qDRAFT
set encoding=utf-8
set tabstop=4
set shiftwidth=4
set expandtab
set autoread
set expandtab
set termguicolors
set clipboard^=unnamed,unnamedplus

" PLUGINS
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'ayu-theme/ayu-vim'
Plug 'bling/vim-bufferline'
Plug 'craigemery/vim-autotag'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/a.vim'
Plug 'vim-scripts/grep.vim'
Plug 'vim-scripts/VisIncr'
call plug#end()

" ayu theme
let ayucolor="mirage"
colorscheme ayu 
 
" Airline configurations
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
let g:bufferline_echo=0
let g:airline_theme='murmur'
set laststatus=2
set signcolumn=yes
set encoding=utf-8   
set updatetime=100

if has("win32")
    let g:airline_powerline_fonts=0
else
    if has("unix")
        let g:airline_powerline_fonts=1
  endif
endif

" gitgutter
autocmd BufWritePost * GitGutter


let Grep_OpenQuickfixWindow=1
let Grep_Default_Options="-I -r"

" Make double-<Esc> clear search highlights
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>
" Search in files
vnoremap <F9> y:execute 'Grep -r -I --include=\*.{c,h,C,H} ' . escape(@@, '/\') . ' .'<CR>
vnoremap <F8> y:execute 'Grep -r -I --include=\*.{c,h,C,H} ' . escape(@@, '/\') . ' %'<CR>
nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
xnoremap p pgvy

function! s:FixWhitespace(line1,line2)
    let l:save_cursor = getpos(".")
    silent! execute ':' . a:line1 . ',' . a:line2 . 's/\\\@<!\s\+$//'
    call setpos('.', l:save_cursor)
endfunction

command! -range=% Fw call <SID>FixWhitespace(<line1>,<line2>)

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif
