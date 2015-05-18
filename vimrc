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
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimfiler.vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'bling/vim-airline'
Bundle 'edkolev/tmuxline.vim'
Bundle 'scrooloose/syntastic'
Bundle 'davidhalter/jedi-vim'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'groenewege/vim-less'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
Bundle 'Valloric/YouCompleteMe'

call vundle#end()
" }}}

" GUI {{{
set guifont=Source\ Code\ Pro\ for\ Powerline:h11
set guioptions=gm
" }}}

" Misc {{{
syntax enable
filetype plugin indent on

let xml_syntax_folding=1

set ttyfast
set modelines=1
set number
set showcmd
set cursorline
set wildmenu
set lazyredraw
set showmatch
set splitbelow
set splitright
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
set nolist
set listchars=
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
try
    " Ignore the theme doesn't exist for dotfiles installation
    colorscheme Tomorrow-Night
catch /^Vim\%((\a\+)\)\=:E185/
endtry

" Make sure whitespace characters remain muted even on CursorLine
highlight AnalWhiteSpaces term=bold ctermfg=239 guifg=#585858
augroup AnalWhiteSpacesHighlight
    autocmd!
    autocmd BufEnter * :call <SID>AnalWhiteSpaceTrigger()
    autocmd WinEnter * :call <SID>AnalWhiteSpaceTrigger()
    autocmd InsertLeave * :call <SID>AnalWhiteSpaceTrigger()
augroup END

function! <SID>AnalWhiteSpaceTrigger()
    if &ft != '' && &ft !~? '^qf|vimfiler\|unite\|help\|man\|gitcommit\>'
        set listchars=tab:▸\ ,eol:¬
        try
            set listchars+=space:.
        catch
        endtry

        set list
        match AnalWhiteSpaces /[\t\n\x0b\x0c\r ]\+/
    else
        set nolist
        set listchars=
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

" As mentioned in zsh/keyboard.zsh, this depends on key mappings
" from the OS X Terminal theme. I will cry a river if I have
" to use vim through PuTTY.
" Meta key navigates splits
nnoremap j <C-W><C-J>
nnoremap k <C-W><C-K>
nnoremap l <C-W><C-L>
nnoremap h <C-W><C-H>

" Meta+arrows resizes splits
nnoremap [1;3A :resize +1<CR>
nnoremap [1;3B :resize -1<CR>
nnoremap [1;3D :vertical:resize +1<CR>
nnoremap [1;3C :vertical:resize -1<CR>

" Meta+shift+arrows resizes by 5
nnoremap [1;4A :resize +5<CR>
nnoremap [1;4B :resize -5<CR>
nnoremap [1;4D :vertical:resize +5<CR>
nnoremap [1;4C :vertical:resize -5<CR>

nnoremap j gj
nnoremap k gk

nnoremap <silent> <leader>l :call ToggleNumber()<CR>

" highlight last inserted text
nnoremap gV `[v`]

" jk is escape
inoremap jk <esc>

" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

" open ag.vim
nnoremap <leader>a :Ag

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
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#tab_nr_type = 2
let g:airline#extensions#tabline#show_tab_type = 1
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

" YCM {{{
" let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion=1
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
" }}}

" Jedi {{{
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
let g:jedi#completions_enabled = 0
let g:jedi#completions_command = ""
let g:jedi#show_call_signatures = "1"

let g:jedi#goto_assignments_command = "<leader>pa"
let g:jedi#goto_definitions_command = "<leader>pd"
let g:jedi#documentation_command = "<leader>pk"
let g:jedi#usages_command = "<leader>pu"
let g:jedi#rename_command = "<leader>pr"
" }}}

" Silver Searcher {{{
if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif
nnoremap <silent> K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" }}}

" File Type Auto Groups {{{
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
    autocmd FileType python setlocal completeopt-=preview
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
