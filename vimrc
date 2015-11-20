
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'itchyny/lightline.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'
Plugin 'klen/python-mode'
Plugin 'davidhalter/jedi-vim'
Plugin 'vim-scripts/Align'
Plugin 'vim-scripts/SQLUtilities'
Plugin 'moll/vim-node'
Plugin 'elixir-lang/vim-elixir'
Plugin 'marijnh/tern_for_vim'

call vundle#end()            " required
filetype plugin indent on    " required

let mapleader = '\'
let maplocalleader = '\'

syntax on
set number
set incsearch
set laststatus=2
set backspace=2 
set mouse=a
set clipboard=unnamed

if has('nvim') == 0
  set ttymouse=xterm2
endif

set scrolloff=5
set noerrorbells                   " Silence!
set list                           " Displays whitespace
set listchars=eol:¬                " Set end of line character
set noerrorbells
set expandtab
set autochdir

set backupdir=~/.vim/backup//
set directory=~/.vim/swp//

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

 " leave insert mode quickly
if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif


set background=dark
colorscheme base16-railscasts

highlight clear SignColumn
highlight VertSplit    ctermbg=0 ctermfg=235
highlight ColorColumn  ctermbg=237
highlight linenr       ctermbg=235 ctermfg=240
highlight CursorLineNr ctermbg=236 ctermfg=240
highlight CursorLine   ctermbg=236
highlight StatusLineNC ctermbg=238 ctermfg=0
highlight StatusLine   ctermbg=240 ctermfg=12
highlight IncSearch    ctermbg=3   ctermfg=1
highlight Search       ctermbg=1   ctermfg=3
highlight Visual       ctermbg=3   ctermfg=0
highlight Pmenu        ctermbg=240 ctermfg=12
highlight PmenuSel     ctermbg=3   ctermfg=1
highlight SpellBad     ctermbg=0   ctermfg=1
highlight Folded       ctermbg=235 ctermfg=240

set ts=2 sw=2 sts=2 expandtab

autocmd Filetype javascript setlocal ts=2 sw=2 sts=0 expandtab
autocmd FileType javascript setlocal completeopt-=preview
autocmd Filetype python setlocal ts=4 sw=4 expandtab
autocmd FileType python setlocal completeopt-=preview
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

" Python-mode
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 0

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 0
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<Leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 0
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 1

" Hide that silly col
let g:pymode_options_colorcolumn = 0


let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_custom_ignore = {
 \ 'dir':  '\.(git|hg|svn)$',
 \}


function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction com! DiffSaved call s:DiffWithSaved()


