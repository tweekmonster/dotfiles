if !1 | finish | endif

" Init {{{1
scriptencoding utf-8
set encoding=utf-8

if has('nvim')
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
endif

" Load local settings {{{1
let s:vimrc_local = expand("$HOME/.vimrc_local")
if filereadable(s:vimrc_local)
    exec "source " . s:vimrc_local
endif

if has('vim_starting')
    if !has('nvim')
        set nocompatible
    endif
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif


" NeoBundle (Plugins) {{{1
filetype off
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundleLocal ~/dotfiles/misc/vim_bundle
NeoBundleLocal ~/.vim/bundle_dev

" Theming
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'bling/vim-airline'

" Git Related
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'gregsexton/gitv'
NeoBundle 'airblade/vim-gitgutter'

" Snippets
NeoBundle 'mattn/emmet-vim'
" NeoBundle 'ervandew/supertab'
NeoBundle 'honza/vim-snippets'
NeoBundle 'bonsaiben/bootstrap-snippets'
NeoBundle 'SirVer/ultisnips', {
            \ 'vim_version': '7.4',
            \ }

" Linting
NeoBundle 'scrooloose/syntastic'

" File Types
NeoBundle 'hdima/python-syntax'
NeoBundle 'fatih/vim-nginx'
NeoBundle 'othree/xml.vim'
NeoBundle 'othree/html5.vim'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'nono/jquery.vim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'groenewege/vim-less'

" Python
NeoBundle 'klen/python-mode'
NeoBundle 'davidhalter/jedi-vim'

" File Navigation
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'junegunn/fzf', {'build': './install'}
NeoBundle 'junegunn/fzf.vim'

" Text Utilities
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'michaeljsmith/vim-indent-object'
NeoBundle 'edsono/vim-matchit'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-line'
NeoBundle 'itchyny/vim-cursorword'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'chrisbra/NrrwRgn'

" General Utilities
NeoBundle 'tweekmonster/sshclip'
NeoBundle 'tpope/vim-obsession'
NeoBundle 'airblade/vim-rooter'
NeoBundle 'vim-scripts/BufOnly.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc.vim', {
      \ 'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'linux' : 'make',
      \     'unix' : 'gmake',
      \    },
      \ }
" NeoBundle 'Shougo/deoplete.nvim'

call neobundle#end()

filetype plugin indent on
NeoBundleCheck


" Vim settings {{{1
syntax enable

set concealcursor=nc
set spell
set completeopt-=preview
silent! set completeopt+=noinsert
set ttyfast
set modelines=5
set number
set showcmd
set cursorline
set wildmenu
set nolazyredraw
set showmatch
set splitbelow
set splitright
set nowrap
set colorcolumn=80
set hidden
set scrolloff=5
set incsearch
set hlsearch
set mouse=a
set mousemodel=extend

if &term =~ '^screen'
    set ttymouse=xterm2
endif

" Spacing and Tabs {{{1
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set backspace=2

setglobal listchars=tab:▸\ ,eol:¬,trail:$
try
    setglobal listchars+=space:.
catch
endtry


" Folding {{{1
set foldenable
set foldmethod=syntax
set foldlevelstart=10
set foldnestmax=10


" Backup and Undo {{{1
set backup
let s:backup_dir = expand('~/.cache/vim_tmp')
if !isdirectory(s:backup_dir)
    call mkdir(s:backup_dir, 'p', 0700)
endif
let s:backup_dir .= '//'  " Store backups in a full path
exec 'set backupdir=' . s:backup_dir . ' directory=' . s:backup_dir
set backupskip=/tmp/*,/private/tmp/*
set writebackup
set viminfo='100,<50,:20,n~/.vim/viminfo

set undofile
let s:undo_dir = expand('~/.cache/vim_undo')
if !isdirectory(s:undo_dir)
    call mkdir(s:undo_dir, 'p', 0700)
endif
exec 'set undodir=' . s:undo_dir


" Theme {{{1
set background=dark
let base16colorspace=256
try
    " Ignore the theme doesn't exist for dotfiles installation
    colorscheme base16-tomorrow-custom
catch /^Vim\%((\a\+)\)\=:E185/
endtry


" Annoying Shit {{{1
function! <SID>fuck_you_q()
    if expand('%') == '[Command Line]'
        nnoremap <buffer> q <c-U>:q<cr>
    endif
endfunction

augroup Annoying
    autocmd!
    " Stop screen flashing
    autocmd VimEnter * set visualbell t_vb=
    autocmd GUIEnter * set visualbell t_vb=

    " <insert some expression about nickels and being rich here>
    autocmd FileType vim call <SID>fuck_you_q()
    autocmd FileType help nmap <buffer> q :q<cr>

    " Restore help buffers to their original glory
    autocmd FileType help setlocal nolist norelativenumber nonumber nomodifiable readonly buftype=help noswapfile
    autocmd FileType help exec 'sign unplace * file=' . expand('%')
augroup END


" Cursor {{{1
" Assume screen-whatever means we're in tmux
if &term =~ '^screen' && !exists('$STY')
    silent! let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    silent! let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
    silent! let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    silent! let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    silent! let &t_SR = "\<Esc>]50;CursorShape=2\x7"
    silent! let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif


" General Key Maps {{{1
" Plugin specific key maps should be found in their own fold
let mapleader=","

" Annoying things
cmap w!! w !sudo tee > /dev/null %
cmap w; :echoe 'NO DAMMIT!'<cr>
cmap w' :echoe 'NO DAMMIT!'<cr>
cmap w/ :echoe 'NO DAMMIT!'<cr>

nnoremap <leader><space> :nohlsearch<cr>

" jk is escape, THEN move to the right to preserve the cursor position, unless
" at the first column.
inoremap <expr> jk col('.') == 1 ? '<esc>' : '<esc>l'
imap JK jk
imap Jk jk

" No idea what's causing it, but pressing <esc> leads to a delay, possibly
" waiting for more keys.  I'm not having it.
inoremap <nowait> <esc> <esc>

" Highlight last inserted text
nnoremap gV `[v`]

" Toggle folds with space
nnoremap <space> za

" Close file and delete its buffer
nnoremap <silent> <leader>q :bp<bar>sp<bar>bn<bar>bd<cr>

nnoremap / /\v
vnoremap / /\v
nnoremap <leader><space> :nohlsearch<cr>
nnoremap <silent> <leader>l :call <SID>toggle_line_numbers()<cr>
nnoremap <silent> <leader>sws :call <SID>strip_white_space()<cr>
nnoremap <silent> <leader>ml :call <SID>append_mode_line()<cr>

" Navigate lines as shown on the screen
nnoremap j gj
nnoremap k gk

" Split navigation
if has('nvim')
    nnoremap <m-j> <c-w><c-j>
    nnoremap <m-k> <c-w><c-k>
    nnoremap <m-l> <c-w><c-l>
    nnoremap <m-h> <c-w><c-h>

    " Escape for nvim's terminal
    tnoremap jk <C-\><C-n>
else
    nnoremap <A-j> <C-W><C-J>
    nnoremap <A-k> <C-W><C-K>
    nnoremap <A-l> <C-W><C-L>
    nnoremap <A-h> <C-W><C-H>
endif

" File type keymaps
augroup vimrc_keymaps
    autocmd!
    autocmd FileType c,cpp,objc nnoremap <silent><buffer> <leader>t :call <SID>c_swap_source()<cr>
    autocmd FileType html,htmldjango nnoremap <leader>tu vit"txvat"tp
augroup END



" Functions {{{1
function! <SID>toggle_line_numbers()
    if &relativenumber == 1
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunction

function! <SID>strip_white_space()
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

function! <SID>append_mode_line()
    let l:modeline = printf(' vim: set ft=%s ts=%d sw=%d tw=%d %set :',
                \ &filetype, &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
    let l:commentstring = &commentstring
    if tcomment#TypeExists(&filetype) != ''
        let l:commentstring = tcomment#GetCommentDef(&filetype).commentstring
    endif
    let l:modeline = printf(l:commentstring, l:modeline)
    call append(line("$"), l:modeline)
endfunction

let s:c_swap_sources = ['.c', '.cpp', '.cc', '.cxx', '.m', '.mm']
let s:c_swap_headers = ['.h', '.hh', '.hpp']

function! <SID>c_swap_source()
    let search = s:c_swap_headers
    if expand('%:e') =~? '^h'
        let search = s:c_swap_sources
    endif

    for ext in search
        let filename = expand('%:r') . ext
        if filereadable(filename)
            exec printf(':edit %s', filename)
        endif
    endfor
endfunction


" Python {{{1
" So in use it deserves its own section
let python_highlight_all = 1

augroup vimrc_python
    autocmd FileType python setlocal completeopt-=preview textwidth=79 shiftwidth=4 tabstop=4 softtabstop=4
    autocmd FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
    autocmd FileType python nnoremap <buffer> <leader>3 :call jedi#force_py_version(3)<cr>
    autocmd FileType htmldjango UltiSnipsAddFiletypes html
augroup END


" General Autocmds {{{1
augroup vimrc_general
    autocmd!
    autocmd FileType man setlocal nolist norelativenumber nonumber nomodifiable
    autocmd FileType xml setlocal foldlevelstart=2
    autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
    autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md,*.rb :call <SID>strip_white_space()
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter zshrc,*.zsh setlocal filetype=zsh
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd FileType vim setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd BufNewFile,BufRead *.html setlocal filetype=htmldjango

    if has('nvim')
        autocmd TermOpen * setlocal nospell
    endif
augroup END


" Plugin - sshclip {{{1
let g:clipboard_min_bytes = 1


" Plugin - Airline {{{1
let g:airline_theme = 'base16_tomorrow'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#tab_nr_type = 2
let g:airline#extensions#tabline#show_tab_type = 1

let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '┃'

let g:airline_left_sep = ''
let g:airline_left_alt_sep = '┃'
let g:airline_right_sep = ''
let g:airline_right_alt_sep = '┃'

set laststatus=2


" Plugin - indentLine {{{1
let g:indentLine_faster = 1
let g:indentLine_leadingSpaceChar = '∙'
let g:indentLine_char = '│'
let g:indentLine_first_char = '│'
let g:indentLine_fileTypeExclude = ['', 'qf', 'gitv', 'tagbar', 'vimfiler', 'unite', 'help', 'man', 'gitcommit', 'vimwiki', 'notes']


" Plugin - gitv {{{1
let g:Gitv_OpenHorizontal = 1
let g:Gitv_OpenPreviewOnLaunch = 1


" Plugin - GitGutter {{{1
let g:gitgutter_sign_column_always = 1

" Force a refresh after fugitive interactions
function! <SID>gitgutter_refresh()
    autocmd! vimrc_gitgutter_refresh
    call gitgutter#all()
endfunction

function! <SID>gitgutter_prep_refresh()
    augroup vimrc_gitgutter_refresh
        autocmd!
        exec 'autocmd BufUnload ' . bufname('%') . ' call <SID>gitgutter_refresh()'
    augroup END
endfunction

augroup vimrc_gitgutter
    autocmd!
    autocmd SessionLoadPost * GitGutterAll
    autocmd BufEnter * GitGutter
    autocmd FileType gitcommit call <SID>gitgutter_prep_refresh()
augroup END


" Plugin - delimitMate {{{1
let delimitMate_expand_cr = 2
let delimitMate_jump_expansion = 1
let delimitMate_matchpairs = "(:),[:],{:}"

augroup vimrc_delimitMate
    autocmd!
    autocmd FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END


" Plugin - multiple-cursors {{{1
let g:multi_cursor_exit_from_insert_mode = 0

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


" Plugin - ctrlp {{{1
let g:ctrlp_match_window = 'top,order:ttb'
let g:ctrlp_match_func = {'match': 'pymatcher#PyMatch'}
let g:ctrlp_lazy_update = 50
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 'a'
let g:ctrlp_custom_ignore = '\vbuild/|dist/|venv/|target/|\.(o|swp|pyc|egg)$'
let g:ctrlp_extensions = ['buffertag']
let g:ctrlp_mruf_exclude = '\.git/*\|/tmp/.*\|/temp/.*\|/var/folders/.*\|/usr/local/Cellar/neovim/.*'


" Plugin - Unite {{{1
let g:unite_enable_start_insert = 1
let g:unite_split_rule = "topleft"
let g:unite_force_overwrite_statusline = 0
let g:unite_winheight = 10

call unite#custom_source('file_rec/async,file_mru,file,buffer,grep',
      \ 'ignore_pattern', join([
      \ '\.git/',
      \ ], '\|'))

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#profile('default', 'context', {
            \   'cursor_line_highlight': 'CursorLine',
            \ })

autocmd FileType unite call s:unite_settings()

function! s:unite_settings()
  let b:SuperTabDisabled=1
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  imap <silent><buffer><expr> <C-x> unite#do_action('split')
  imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  imap <silent><buffer><expr> <C-t> unite#do_action('tabopen')
endfunction


" Plugin - vimfiler {{{1
let g:vimfiler_as_default_explorer = 1
call vimfiler#custom#profile('default', 'context', {
      \     'safe': 0,
      \ })
let g:vimfiler_ignore_pattern = '\(\.git\|__pycache__\|\.pyc\|\.DS_Store$\)'
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '*'


augroup vimrc_vimfiler
    autocmd!
    autocmd FileType vimfiler nmap <buffer> q Q
    autocmd FileType vimfiler set nonumber norelativenumber
    autocmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
augroup END

nnoremap <silent> <leader>v :VimFiler -find -project -split -simple -winwidth=35 -toggle -force-quit -edit-action=choose<CR>


" Plugin - syntastic {{{1
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_disabled_filetypes=['html.django']

" We're all grown ups here, flake8. I'll decide how long is too long okay.
let g:syntastic_python_checkers=['flake8']
let g:syntastic_python_flake8_args='--ignore=E501,E226,F403'

let g:syntastic_html_tidy_ignore_errors = [
            \ 'plain text isn''t allowed in <head> elements',
            \ 'trimming empty',
            \ ]

augroup vimrc_syntastic
    autocmd BufEnter * if (exists('b:syntastic_skip_checks')) | unlet b:syntastic_skip_checks
augroup END


" Plugin - Obsession {{{1
augroup vimrc_obessession
    autocmd!
    autocmd VimEnter * nested
                \ if !argc() && empty(v:this_session) && filereadable('Session.vim') |
                \   source Session.vim |
                \ endif
augroup END


" Plugin - jedi {{{1
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#show_call_signatures = 0
let g:jedi#max_doc_height = 10


" Plugin - python-mode {{{1
let g:pymode_trim_whitespaces = 0
let g:pymode_doc = 0
let g:pymode_folding = 0
let g:pymode_rope = 0
let g:pymode_lint = 0
let g:pymode_options_max_line_length = 79
let g:pymode_run = 0


" Plugin - rooter {{{1
let g:rooter_patterns = ['.vimroot']

augroup vimrc_rooter
    autocmd VimEnter * :Rooter
augroup END


" Plugin - supertab {{{1
let g:SuperTabDefaultCompletionType = '<C-j>'
let g:SuperTabCrMapping = 0


" Plugin - deoplete {{{1
let g:deoplete#enable_at_startup = 1
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"


" Plugin - UltiSnips {{{1
let g:UltiSnipsExpandTrigger = '<c-]>'


" Plugin - emmet {{{1
let g:user_emmet_leader_key = '<c-c>'

" Plugin - FZF {{{1
if executable('ag')
    " Filter items through ag to respect gitignore
    let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'
endif

let g:fzf_layout = {'window': 'aboveleft 10new'}
nnoremap <c-p> :Files<cr>
nnoremap <leader>e :BTags<cr>
nnoremap <leader>E :BLines<cr>
nnoremap <leader>L :Lines<cr>
nnoremap <leader>B :Buffers<cr>

augroup vimrc_fzf
    autocmd!
    autocmd FileType help nmap <buffer> <c-p> :Helptags<cr>
augroup END


" }}}

"  vim: set ft=vim ts=4 sw=4 tw=78 et fdm=marker :
