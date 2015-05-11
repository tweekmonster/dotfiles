scriptencoding utf-8
set encoding=utf-8

" Parts are from Doug Black's vimrc

" Vundle {{{
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Bundle 'gmarik/Vundle.vim'
Bundle 'sjl/gundo.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-sleuth'
Bundle 'tomtom/tcomment_vim'
Bundle 'scrooloose/nerdtree'
Bundle 'airblade/vim-gitgutter'
Bundle 'bling/vim-airline'
Bundle 'edkolev/tmuxline.vim'
Bundle 'scrooloose/syntastic'
Bundle 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}

call vundle#end()
" }}}

" Misc {{{
syntax enable
filetype plugin indent on

set ttyfast
set modelines=1
set number
set showcmd
set cursorline
set wildmenu
set lazyredraw
set showmatch
" }}}

" Spacing {{{
filetype indent on
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set backspace=2
" }}}

" Search {{{
set incsearch
set hlsearch
nnoremap <leader><space> :nohlsearch<CR>
" }}}

" Folding {{{
set foldenable
set foldlevelstart=10
set foldnestmax=10

nnoremap <space> za
set foldmethod=indent
" }}}

" Whitespace {{{
set list
set listchars=tab:▸\ ,eol:¬
try
    set listchars+=space:.
catch
endtry
" }}}

" Backup Files {{{
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
" }}}

" Theme {{{
try
    " Ignore the theme doesn't exist for dotfiles installation
    colorscheme Tomorrow-Night
catch /^Vim\%((\a\+)\)\=:E185/
endtry

" Make sure whitespace characters remain muted even on CursorLine
highlight AnalWhiteSpaces term=bold ctermfg=239 guifg=#585858
augroup AnalWhiteSpacesHighlight
    autocmd!
    autocmd VimEnter * match AnalWhiteSpaces /[\t\n\x0b\x0c\r ]\+/
    autocmd InsertLeave * match AnalWhiteSpaces /[\t\n\x0b\x0c\r ]\+/
augroup END
" }}}

" Key Bindings {{{
let mapleader=","

nnoremap j gj
nnoremap k gk

" highlight last inserted text
nnoremap gV `[v`]

" jk is escape
inoremap jk <esc>

" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

" open ag.vim
nnoremap <leader>a :Ag
" "}}}

" NERDTree {{{
let NERDTreeIgnore = ['\.pyc$', 'build', 'venv', 'egg', 'egg-info/', 'dist', 'docs']
" }}}

" Airline {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = '|'
" " let g:airline#extensions#tmuxline#enabled = 0
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
set laststatus=2
" }}}

" Syntastic {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" }}}

" CtrlP settings {{{
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = '\vbuild/|dist/|venv/|target/|\.(o|swp|pyc|egg)$'
" }}}

" File Type Auto Groups {{{
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd FileType python setlocal completeopt-=preview
    autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md,*.rb :call <SID>StripTrailingWhitespaces()
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
augroup END
" }}}

" Functions {{{
" toggle between number and relativenumber
function! ToggleNumber()
    if (&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

function! HostStatusLine(...)
    call a:1.add_raw(' ' . hostname() . ' ')
    return 0
endfunc
try
    call airline#add_statusline_func('HostStatusLine')
catch
endtry
"}}}

" vim:foldmethod=marker:foldlevel=0
