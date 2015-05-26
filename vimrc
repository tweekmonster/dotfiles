if !1 | finish | endif

scriptencoding utf-8
set encoding=utf-8

if has('nvim')
   set clipboard+=unnamed
   let g:clipboard_min_bytes = 1
endif

if has('vim_starting')
   if &compatible
     set nocompatible
   endif

   set runtimepath+=~/.vim/bundle/neobundle.vim/
 endif


" Parts are from Doug Black's vimrc

" NeoBundle {{{
filetype off

call neobundle#begin(expand('~/.vim/bundle/'))
let g:neobundle#install_process_timeout = 1500

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'tweekmonster/sshclip'
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'gmarik/Vundle.vim'
NeoBundle 'simnalamburt/vim-mundo'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'tpope/vim-sleuth'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'bling/vim-airline'
" NeoBundle 'edkolev/tmuxline.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'gregsexton/gitv'
NeoBundle 'tpope/vim-surround'
NeoBundle 'groenewege/vim-less'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'hynek/vim-python-pep8-indent'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'ervandew/supertab'
NeoBundle 'honza/vim-snippets'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'mtth/scratch.vim'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'rdnetto/YCM-Generator'
NeoBundle 'Valloric/YouCompleteMe'

call neobundle#end()

filetype plugin indent on
NeoBundleCheck
" }}}

" GUI {{{
" set guifont=Source\ Code\ Pro\ for\ Powerline:h11
set guioptions=gm
" }}}

" Misc {{{
syntax enable

let xml_syntax_folding=1

set mouse=a

if &term =~ '^screen'
    set ttymouse=xterm2
endif

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
set hidden
set scrolloff=5
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
" http://vimdoc.sourceforge.net/htmldoc/options.html#'viminfo'
set viminfo='100,<50,:20,n~/.vim/viminfo
" }}}

" Persistent Undo {{{
set undofile
set undodir=~/.vim/undo
" }}}

" Theme {{{
let base16colorspace=256
try
    " Ignore the theme doesn't exist for dotfiles installation
    colorscheme base16-tomorrow-custom
catch /^Vim\%((\a\+)\)\=:E185/
endtry


setglobal listchars=tab:▸\ ,eol:¬,trail:□
" try
"     setglobal listchars+=space:.
" catch
" endtry

let g:indentLine_leadingSpaceChar = '∙'
let g:indentLine_char = '│'
let g:indentLine_first_char = '│'
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_fileTypeExclude = ['qf', 'gitv', 'tagbar', 'vimfiler', 'unite', 'help', 'man', 'gitcommit', 'vimwiki']

"
" " Make sure whitespace characters remain muted even on CursorLine
" " Refactor this later
" highlight AnalWhiteSpaces term=bold ctermfg=19 guifg=#585858
" augroup AnalWhiteSpacesHighlight
"     autocmd!
"     autocmd BufEnter * :call <SID>AnalWhiteSpaceTrigger()
"     autocmd WinEnter * :call <SID>AnalWhiteSpaceTrigger()
"     autocmd InsertLeave * :call <SID>AnalWhiteSpaceTrigger()
" augroup END
"
" function! <SID>AnalWhiteSpaceTrigger()
"     if &ft != '' && &ft !~? '^qf\|gitv\|tagbar\|vimfiler\|unite\|help\|man\|gitcommit\>'
"         setlocal list
"         match AnalWhiteSpaces /[\t\n\x0b\x0c\r ]\+/
"     else
"         setlocal nolist
"         match none
"     endif
" endfunction
" }}}

" Annoying {{{
let g:multi_cursor_exit_from_insert_mode = 0

augroup Annoying
    autocmd!
    " Stop screen flashing
    autocmd VimEnter * set visualbell t_vb=
    autocmd GUIEnter * set visualbell t_vb=
augroup END
" }}}

" key bindings {{{
let mapleader=","

if has('nvim')
    " meta key navigates splits
    nnoremap <m-j> <c-w><c-j>
    nnoremap <m-k> <c-w><c-k>
    nnoremap <m-l> <c-w><c-l>
    nnoremap <m-h> <c-w><c-h>

    " meta+arrows resizes splits
    nnoremap <m-up> :resize +1<cr>
    nnoremap <m-down> :resize -1<cr>
    nnoremap <m-right> :vertical:resize +1<cr>
    nnoremap <m-left> :vertical:resize -1<cr>

    " meta+shift+arrows resizes by 5
    nnoremap <m-s-up> :resize +5<cr>
    nnoremap <m-s-down> :resize -5<cr>
    nnoremap <m-s-right> :vertical:resize +5<cr>
    nnoremap <m-s-left> :vertical:resize -5<cr>

    tnoremap jk <C-\><C-n>
else
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
endif



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
nnoremap <leader>q :bp<bar>sp<bar>bn<bar>bd<cr>

nnoremap <c-b> :CtrlPBuffer<cr>
nnoremap <c-c> :CtrlPMRU<cr>
" "}}}

" VimFiler {{{
nnoremap <silent> <leader>n :VimFilerBufferDir -buffer-name=explorer -split -simple -winwidth=35 -toggle -no-quit<CR>
let g:vimfiler_as_default_explorer = 1
call vimfiler#custom#profile('default', 'context', {})
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '*'
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
" let g:airline#extensions#tmuxline#enabled = 1
let g:airline_left_sep = ''
let g:airline_left_alt_sep = '┃'
let g:airline_right_sep = ''
let g:airline_right_alt_sep = '┃'
"
" let g:tmuxline_separators = {
"     \ 'left' : '',
"     \ 'left_alt': '┃',
"     \ 'right' : '',
"     \ 'right_alt' : '┃',
"     \ 'space' : ' '}

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
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-j>'
let g:SuperTabCrMapping = 0
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

" The protection this is supposed to provide shouldn't be outweighed by how
" annoying the focus stealing prompt is.
let g:ycm_confirm_extra_conf = 0
" }}}

" Ultisnips {{{
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
" }}}

" Tagbar {{{
nnoremap <leader>t :TagbarOpen fj<cr>
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

    let g:ctrlp_user_command = 'ag ""%s -l --nocolor -g ""'
    let g:ctrlp_use_caching = 0
endif
" }}}

" GitGutter {{{
let g:gitgutter_sign_column_always = 1
" }}}

" Multiple Cursors {{{
function! Multiple_cursors_before()
   if exists('*youcompleteme#EnableCursorMovedAutocommands')
      let g:ycm_auto_trigger = 0
      let s:old_ycm_whitelist = g:ycm_filetype_whitelist                           
      let g:ycm_filetype_whitelist = {}  
      call youcompleteme#DisableCursorMovedAutocommands()
   endif
endfunction

function! Multiple_cursors_after()
   if exists('*youcompleteme#EnableCursorMovedAutocommands')
      let g:ycm_auto_trigger = 1
      let g:ycm_filetype_whitelist = s:old_ycm_whitelist
      call youcompleteme#EnableCursorMovedAutocommands()
   endif
endfunction
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

function! AppendModeline()
    let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
                \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
    let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
    call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

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
