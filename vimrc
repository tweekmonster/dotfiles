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
endif


" vim-plug (Plugins) {{{1
filetype off
call plug#begin('~/.vim/plugged')
Plug '~/dotfiles/misc/vim_bundle/base16_custom'
Plug '~/dotfiles/misc/vim_bundle/django-custom'
Plug '~/dotfiles/misc/vim_bundle/misc'
Plug '~/dev/vim/sshclip'
Plug '~/dev/vim/fzf-filesmru'
Plug '~/dev/vim/braceless.vim'

" Theming
Plug 'bling/vim-airline'

" Git Related
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv'
Plug 'airblade/vim-gitgutter'

" Snippets
Plug 'mattn/emmet-vim'
if v:version > 703
    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
endif

" Linting
Plug 'scrooloose/syntastic'

" File Types
Plug 'hdima/python-syntax'
Plug 'fatih/vim-nginx'
Plug 'othree/xml.vim'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'nono/jquery.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'groenewege/vim-less'
Plug 'tmux-plugins/vim-tmux'
Plug 'fatih/vim-go'
Plug 'garyburd/go-explorer'
Plug 'elzr/vim-json'
Plug 'icook/Vim-Jinja2-Syntax'
Plug 'cespare/vim-toml'
Plug 'csscomb/vim-csscomb'

" Python
" Plug 'klen/python-mode'
Plug 'davidhalter/jedi-vim'
Plug 'fisadev/vim-isort'

" File Navigation
Plug 'Shougo/vimfiler.vim'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --bin'}
Plug 'junegunn/fzf.vim'

" Text Utilities
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'Lokaltog/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'
Plug 'Raimondi/delimitMate'
Plug 'michaeljsmith/vim-indent-object'
Plug 'edsono/vim-matchit'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'tomtom/tcomment_vim'
Plug 'chrisbra/NrrwRgn'
Plug 'wellle/targets.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vader.vim'

" General Utilities
Plug 'tpope/vim-scriptease'
Plug 'editorconfig/editorconfig-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-obsession'
Plug 'airblade/vim-rooter'
Plug 'vim-scripts/BufOnly.vim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimproc.vim', {'do': 'make'}

Plug 'Shougo/deoplete.nvim'
Plug 'mbbill/undotree'
Plug 'ryanoasis/vim-devicons'

" call neobundle#end()
call plug#end()

filetype plugin indent on
" PlugCheck


" Vim settings {{{1
syntax enable

set concealcursor=nc
set spell
set completeopt-=preview
set completeopt+=menuone
silent! set completeopt+=noinsert
set ttyfast
set modelines=5
set number
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

set listchars=tab:▸\ ,eol:¬,trail:$
try
    set listchars+=space:.
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
set viminfo='100,<50,:20
if has('nvim')
    set viminfo+=n~/.vim/nviminfo
else
    set viminfo+=n~/.vim/viminfo
endif

set undofile
let s:undo_dir = expand('~/.cache/vim_undo')
if !isdirectory(s:undo_dir)
    call mkdir(s:undo_dir, 'p', 0700)
endif
exec 'set undodir=' . s:undo_dir


" Theme {{{1
try
    " Ignore the theme doesn't exist for dotfiles installation
    colorscheme base16_custom
catch /^Vim\%((\a\+)\)\=:E185/
endtry


" Annoying Shit {{{1
let g:vim_json_syntax_conceal = 0

function! <SID>fuck_you_q()
    if expand('%') == '[Command Line]'
        nnoremap <buffer> q <c-U>:q<cr>
    endif
endfunction

function! <SID>set_help_options()
    let runtimep = expand('$VIMRUNTIME')
    let helpp = expand('%')
    if helpp =~ '^'.runtimep || helpp =~ '^'.expand('~/.vim')
        setlocal nolist norelativenumber nonumber nomodifiable readonly buftype=help noswapfile nobuflisted
        exec 'sign unplace * file='.helpp
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
    autocmd BufEnter __doc__ nnoremap <buffer> q :bdel

    " Restore help buffers to their original glory
    autocmd FileType help call <SID>set_help_options()
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

imap <Nul> <Space>

" No idea what's causing it, but pressing <esc> leads to a delay, possibly
" waiting for more keys.  I'm not having it.
inoremap <nowait> <esc> <esc>

inoremap <expr> <c-j> pumvisible() ? "\<c-n>" : "\<c-j>"
inoremap <expr> <c-k> pumvisible() ? "\<c-p>" : "\<c-k>"

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

nnoremap <silent> <leader>DD :exe ":profile start profile.log"<cr>:exe ":profile func *"<cr>:exe ":profile file *"<cr>
nnoremap <silent> <leader>DQ :exe ":profile pause"<cr>:noautocmd qall!<cr>


function! <SID>HTMLPretty(mode)
  let search = @/
  let htmlpat = '/\v(\<script[^\>]*)@<!\>\s*\</\>\r\</ge'
  let tplpat = '/\v%(\<script[^\>]*)@<!(\>|\})\s*(\<|\{)/\1\r\2/ge'
  let sel = '%s'
  let c = htmlpat
  let fmt = 'ggVG='
  if a:mode !~? 'v'
    exec 'normal! ggVGJ'
  else
    let sel = "'<,'>s"
    let fmt = '`[V`]='
    exec 'normal! J'
  endif

  if &ft != 'html'
    let c = tplpat
  endif

  exec ':'.sel.c.' | normal! '.fmt.' | :'.sel.'/>\s*</></ge | normal! `[ | :nohl'
  let @/ = search
  " exec ':'.sel.c | exec 'normal '.fmt | exec ':'.sel.'/>\s*</></ge' | exec ':nohl' | let @/ = search
endfunction

" File type keymaps
augroup vimrc_keymaps
    autocmd!
    autocmd FileType c,cpp,objc nnoremap <silent><buffer> <leader>t :call <SID>c_swap_source()<cr>
" Unwrap html tag
    autocmd FileType html,htmldjango,jinja nnoremap <leader>tu vit"txvat"tp
" Prettify html
    autocmd FileType html,htmldjango,jinja nnoremap <leader>p :call <SID>HTMLPretty('n')<cr>
    autocmd FileType html,htmldjango,jinja vnoremap <leader>p :call <SID>HTMLPretty('v')<cr>
" Original prettify for posterity
"    autocmd FileType html cabbrev <buffer><silent> pretty exec 'normal ggVGJ' <bar> exec ':%s/\v(\<script[^\>]*)@<!\>\s*\</\>\r\</ge' <bar> exec 'normal ggVG=' <bar> exec ':%s/>\s*</></ge' <bar> :nohl
"    autocmd FileType htmldjango,jinja cabbrev <buffer><silent> pretty exec 'normal ggVGJ' <bar> exec ':%s/\v%(\<script[^\>]*)@<!(\>\|\})\s*(\<\|\{)/\1\r\2/ge' <bar> exec 'normal ggVG=' <bar> exec ':%s/>\s*</></ge' <bar> :nohl
    autocmd FileType json cabbrev <buffer><silent> jq exec '%!jq .'
    autocmd FileType python :iabbrev improt import
    autocmd FileType python,coffee BracelessEnable +fold +highlight-cc2
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
    autocmd FileType python,toml let b:delimitMate_nesting_quotes = ['"', "'"]
    autocmd FileType htmldjango,jinja UltiSnipsAddFiletypes html
    autocmd FileType jinja UltiSnipsAddFiletypes jinja2
augroup END


" General Autocmds {{{1
augroup vimrc_general
    autocmd!
    autocmd FileType man setlocal nolist norelativenumber nonumber nomodifiable
    autocmd FileType xml setlocal foldlevelstart=2
    autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
    autocmd FileType scss setlocal foldmethod=marker foldmarker={,} iskeyword+=-
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
let g:airline_theme = 'base16_custom'
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

let s:old_omni = ''

function! Multiple_cursors_before()
    let s:old_omni = &omnifunc
    let &omnifunc = ''
    if exists('*youcompleteme#EnableCursorMovedAutocommands')
        let g:ycm_auto_trigger = 0
        let s:old_ycm_whitelist = g:ycm_filetype_whitelist
        let g:ycm_filetype_whitelist = {}
        call youcompleteme#DisableCursorMovedAutocommands()
    endif
endfunction

function! Multiple_cursors_after()
    let &omnifunc = s:old_omni
    let s:old_omni = ''
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
let g:unite_force_overwrite_statusline = 1
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
    autocmd FileType vimfiler normal gs
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

let g:syntastic_rst_checkers=['rstcheck']

let g:syntastic_tex_checkers=['chktex']

let g:syntastic_html_tidy_ignore_errors = [
            \ 'plain text isn''t allowed in <head> elements',
            \ 'trimming empty',
            \ ]

let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

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
" Not sure why I'm still using python-mode
let g:pymode_virtualenv = 0
let g:pymode_trim_whitespaces = 0
let g:pymode_doc = 0
let g:pymode_folding = 0
let g:pymode_rope = 0
let g:pymode_lint = 0
let g:pymode_options_max_line_length = 79
let g:pymode_run = 0
let g:pymode_motion = 0


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
augroup vimrc_deoplete
    autocmd!
    autocmd FileType go let b:deoplete_disable_auto_complete=1
augroup END


" Plugin - UltiSnips {{{1
let g:UltiSnipsExpandTrigger = '<c-]>'


" Plugin - emmet {{{1
let g:user_emmet_leader_key = '<c-c>'


" Plugin - go-vim {{{1
let g:go_autodetect_gopath = 1
let g:go_auto_type_info = 0
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"
let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_functions = 1
let g:go_highlight_extra_types = 0
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_snippet_engine = "neosnippet"


" Plugin - tmux-navigator {{{1
let g:tmux_navigator_no_mappings = 1

if has('nvim')
    nnoremap <silent> <m-h> :TmuxNavigateLeft<cr>
    nnoremap <silent> <m-j> :TmuxNavigateDown<cr>
    nnoremap <silent> <m-k> :TmuxNavigateUp<cr>
    nnoremap <silent> <m-l> :TmuxNavigateRight<cr>
else
    nnoremap <silent> <a-h> :TmuxNavigateLeft<cr>
    nnoremap <silent> <a-j> :TmuxNavigateDown<cr>
    nnoremap <silent> <a-k> :TmuxNavigateUp<cr>
    nnoremap <silent> <a-l> :TmuxNavigateRight<cr>
endif


" Plugin - surround {{{1
" echo char2nr("<key>")
" insert mode: ctrl-c, then digigraph
let g:surround_49 = "‘\r’"
let g:surround_50 = "“\r”"
let g:surround_51 = "'''\r'''"
let g:surround_52 = '"""\r"""'


" Plugin - editorconfig {{{1
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
function! VimrcEditorConfigFiletypeHook(config)
    if has_key(a:config, 'vim_filetype')
        let &filetype = a:config['vim_filetype']
    endif

    return 0   " Return 0 to show no error happened
endfunction

call editorconfig#AddNewHook(function('VimrcEditorConfigFiletypeHook'))


" Plugin - FZF {{{1
if executable('pt')
    " Filter items through ag to respect gitignore
    let $FZF_DEFAULT_COMMAND = 'pt -l -g ""'
endif

function! <SID>save_history()

endfunction

autocmd BufReadPre * call <SID>save_history()

let g:fzf_layout = {'window': 'aboveleft 10new'}
nnoremap <c-p> :FilesMru<cr>
nnoremap <leader>e :BTags<cr>
nnoremap <leader>E :BLines<cr>
nnoremap <leader>L :Lines<cr>
nnoremap <leader>B :Buffers<cr>

augroup vimrc_fzf
    autocmd!
    autocmd FileType help nmap <buffer> <c-p> :Helptags<cr>
augroup END


" Plugin - easy-align
vmap <Enter> <Plug>(LiveEasyAlign)
nmap ga <Plug>(LiveEasyAlign)

" }}}

"  vim: set ft=vim ts=4 sw=4 tw=78 et fdm=marker :
