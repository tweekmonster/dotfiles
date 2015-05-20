scriptencoding utf-8
set encoding=utf-8

" Parts are from Doug Black's vimrc

" Vundle {{{
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Bundle 'chriskempson/base16-vim'
Bundle 'gmarik/Vundle.vim'
Bundle 'sjl/gundo.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-sleuth'
Bundle 'tomtom/tcomment_vim'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimfiler.vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'bling/vim-airline'
Bundle 'edkolev/tmuxline.vim'
Bundle 'scrooloose/syntastic'
" Bundle 'davidhalter/jedi-vim'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'groenewege/vim-less'
Bundle 'terryma/vim-multiple-cursors'
" Bundle 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
Bundle 'majutsushi/tagbar'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'hynek/vim-python-pep8-indent'
Bundle 'tpope/vim-unimpaired'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'Raimondi/delimitMate'
Bundle 'ervandew/supertab'
Bundle 'honza/vim-snippets'
Bundle 'SirVer/ultisnips'
Bundle 'Valloric/YouCompleteMe'

call vundle#end()
" }}}

" GUI {{{
" set guifont=Source\ Code\ Pro\ for\ Powerline:h11
set guioptions=gm
" }}}

" Misc {{{
syntax enable
filetype plugin indent on

let xml_syntax_folding=1

set background=dark
set ttyfast
set modelines=1
set number
set relativenumber
set showcmd
set cursorline
set wildmenu
set lazyredraw
set showmatch
set splitbelow
set splitright
set nowrap
set colorcolumn=80
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
set foldmethod=syntax
set foldlevelstart=10
set foldnestmax=10

nnoremap <space> za
set foldmethod=indent
" }}}

" Whitespace {{{
" set nolist
" set listchars=
" }}}

" Backup Files {{{
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
" }}}

" Persistent Undo {{{
set undofile
set undodir=~/.vim/undo
" }}}

" Theme {{{
let base16colorspace=256
try
    " Ignore the theme doesn't exist for dotfiles installation
    colorscheme base16-tomorrow
catch /^Vim\%((\a\+)\)\=:E185/
endtry

highlight Search term=reverse ctermfg=18 ctermbg=3 guifg=#969896 guibg=#f0c674
highlight CursorLineNr term=bold ctermfg=3 ctermbg=18 gui=bold guifg=#969896 guibg=#282a2e

setglobal listchars=tab:▸\ ,eol:¬
try
    setglobal listchars+=space:.
catch
endtry

" Make sure whitespace characters remain muted even on CursorLine
" Refactor this later
highlight AnalWhiteSpaces term=bold ctermfg=19 guifg=#585858
augroup AnalWhiteSpacesHighlight
    autocmd!
    autocmd BufEnter * :call <SID>AnalWhiteSpaceTrigger()
    autocmd WinEnter * :call <SID>AnalWhiteSpaceTrigger()
    autocmd InsertLeave * :call <SID>AnalWhiteSpaceTrigger()
augroup END

function! <SID>AnalWhiteSpaceTrigger()
    if &ft != '' && &ft !~? '^qf\|tagbar\|vimfiler\|unite\|help\|man\|gitcommit\>'
        setlocal list
        match AnalWhiteSpaces /[\t\n\x0b\x0c\r ]\+/
    else
        setlocal nolist
        match none
    endif
endfunction
" }}}

" Annoying {{{
augroup Annoying
    autocmd!
    " Stop screen flashing
    autocmd VimEnter * set visualbell t_vb=
    autocmd GUIEnter * set visualbell t_vb=
augroup END
" }}}

" Key Bindings {{{
let mapleader=","

" Meta key navigates splits
nnoremap j <C-W><C-J>
nnoremap k <C-W><C-K>
nnoremap l <C-W><C-L>
nnoremap h <C-W><C-H>

" Meta+arrows resizes splits
nnoremap [1;9A :resize +1<CR>
nnoremap [1;9B :resize -1<CR>
nnoremap [1;9D :vertical:resize +1<CR>
nnoremap [1;9C :vertical:resize -1<CR>

" Meta+shift+arrows resizes by 5
nnoremap [1;10A :resize +5<CR>
nnoremap [1;10B :resize -5<CR>
nnoremap [1;10D :vertical:resize +5<CR>
nnoremap [1;10C :vertical:resize -5<CR>

nnoremap j gj
nnoremap k gk

nnoremap <silent> <leader>l :call ToggleNumber()<CR>

" highlight last inserted text
nnoremap gV `[v`]

" jk is escape
inoremap jk <esc>

" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

nnoremap <silent> <leader>sws :call <SID>StripTrailingWhitespaces()<CR>
" "}}}

" VimFiler {{{
nnoremap <silent> <leader>n :VimFilerBufferDir -buffer-name=explorer -split -simple -winwidth=35 -toggle -quit<CR>
let g:vimfiler_as_default_explorer = 1
" }}}

" " NERDTree {{{
" nnoremap <leader>n :NERDTreeToggle<CR>
" let NERDTreeIgnore = ['\.pyc$', 'build', 'venv', 'egg', 'egg-info/', 'dist', 'docs']
" " }}}

" Airline {{{
let g:airline_theme = 'base16_tomorrow'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#tab_nr_type = 2
let g:airline#extensions#tabline#show_tab_type = 1

let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '┃'
let g:airline#extensions#tmuxline#enabled = 0
let g:airline_left_sep = ''
let g:airline_left_alt_sep = '┃'
let g:airline_right_sep = ''
let g:airline_right_alt_sep = '┃'
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

" We're all grown ups here, flake8. I'll decide how long is too long okay.
let g:syntastic_python_checkers=['flake8']
let g:syntastic_python_flake8_args='--ignore=E501,E226'
" }}}

" CtrlP settings {{{
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = '\vbuild/|dist/|venv/|target/|\.(o|swp|pyc|egg)$'
" }}}

" YCM {{{
" let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-j>'
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
" }}}

" Ultisnips {{{
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
" }}}

" Jedi {{{
" let g:jedi#auto_vim_configuration = 0
" let g:jedi#popup_on_dot = 0
" let g:jedi#popup_select_first = 0
" let g:jedi#completions_enabled = 0
" let g:jedi#completions_command = ""
" let g:jedi#show_call_signatures = "1"
"
" let g:jedi#goto_assignments_command = "<leader>pa"
" let g:jedi#goto_definitions_command = "<leader>pd"
" let g:jedi#documentation_command = "<leader>pk"
" let g:jedi#usages_command = "<leader>pu"
" let g:jedi#rename_command = "<leader>pr"
" }}}

" Tagbar {{{
nnoremap <leader>t :TagbarToggle<CR>
" }}}

" Silver Searcher {{{
if executable('ag')
    set grepprg=ag\ --vimgrep\ -w\ $*

    if executable('agtrunc')
        set grepprg+=\ \\\|\ agtrunc
    endif

    set grepformat=%f:%l:%c:%m
    command! -nargs=+ Ag exec 'silent! grep! <args>' | copen | exec 'silent /<args>' | redraw!
    nnoremap <leader>a :Ag <c-r>=expand('<cword>')<CR><CR>

    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    let g:ctrlp_use_caching = 0
endif
" }}}

" GitGutter {{{
let g:gitgutter_sign_column_always = 1
" }}}

" File Type Auto Groups {{{
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
    autocmd FileType python setlocal completeopt-=preview textwidth=79
    autocmd FileType man setlocal nolist norelativenumber nonumber nomodifiable
    autocmd FileType xml setlocal foldlevelstart=2
    " autocmd BufEnter * :call <SID>FTSetup()
    " autocmd WinEnter * :call <SID>FTSetup()
    autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md,*.rb :call <SID>StripTrailingWhitespaces()
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
    " Force quickfix to the bottom
    " autocmd FileType qf wincmd J | call AdjustWindowHeight(3, 10)
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

function! AdjustWindowHeight(minheight, maxheight)
    exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

" function! <SID>FTSetup()
"     " Sets up the buffer for a file type
"     " This is a separate function because it's easier than
"     " creating a bunch of autocommands to do the exact same
"     " thing, and it can make exclusions instead of inclusions.
"     if &ft !~? 'vimfiler\|unite\|help\|man'
"     endif
" endfunction

" function! HostStatusLine(...)
"     call a:1.add_raw(' ' . hostname() . ' ')
"     return 0
" endfunc
" try
"     call airline#add_statusline_func('HostStatusLine')
" catch
" endtry
"}}}

let s:vimrc_local = expand("$HOME/.vimrc_local")
if filereadable(s:vimrc_local)
    exec "source " . s:vimrc_local
endif

" vim:foldmethod=marker:foldlevel=0
