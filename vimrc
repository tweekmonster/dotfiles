if !1 | finish | endif

scriptencoding utf-8
set encoding=utf-8

if has('nvim')
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  set clipboard+=unnamed
  set t_Co=256
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
NeoBundle 'simnalamburt/vim-mundo'
NeoBundle 'FelikZ/ctrlp-py-matcher'
NeoBundle 'kien/ctrlp.vim'
" NeoBundle 'tpope/vim-sleuth'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'Shougo/unite.vim'
" NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/vimproc.vim', {
      \ 'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'linux' : 'make',
      \     'unix' : 'gmake',
      \    },
      \ }
" NeoBundle 'Shougo/neomru.vim'
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
" NeoBundle 'majutsushi/tagbar'
NeoBundle 'Lokaltog/vim-easymotion'
" NeoBundle 'hynek/vim-python-pep8-indent'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'ervandew/supertab'
NeoBundle 'honza/vim-snippets'
NeoBundle 'SirVer/ultisnips'
" NeoBundle 'mtth/scratch.vim'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'hdima/python-syntax'
NeoBundle 'michaeljsmith/vim-indent-object'
" NeoBundle 'rdnetto/YCM-Generator'
" NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'klen/python-mode'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'fatih/vim-nginx'
NeoBundle 'othree/xml.vim'
NeoBundle 'othree/html5.vim'
NeoBundle 'edsono/vim-matchit'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'nono/jquery.vim'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-line'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'itchyny/vim-cursorword'
NeoBundle 'Shougo/deoplete.nvim'
NeoBundle 'xolox/vim-misc'
NeoBundle 'xolox/vim-notes'
NeoBundle 'xolox/vim-session'
NeoBundle 'airblade/vim-rooter'
NeoBundleLocal ~/dotfiles/misc/vim_bundle

call neobundle#end()

filetype plugin indent on
NeoBundleCheck
" }}}

let g:rooter_patterns = ['.vimroot']

let g:session_autoload = 'no'
let g:notes_directories = ['~/Dropbox/Sync/vim_notes']

let g:deoplete#enable_at_startup = 0
let g:pymode_trim_whitespaces = 0
let g:pymode_doc = 0
let g:pymode_folding = 0
let g:pymode_rope = 0
let g:pymode_lint = 0
let g:pymode_trim_whitespaces = 1
let g:pymode_options_max_line_length = 79
let g:pymode_run = 0
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#show_call_signatures = 0
let g:jedi#max_doc_height = 10

" GUI {{{
" set guifont=Source\ Code\ Pro\ for\ Powerline:h11
set guioptions=gm
" }}}

" Misc {{{
syntax enable

let python_highlight_all = 1
let xml_syntax_folding=1

if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

set mouse=a

if &term =~ '^screen'
  set ttymouse=xterm2
endif

set background=dark
set concealcursor=nc
set spell
set noshowmode
set completeopt-=preview
set ttyfast
set modelines=5
set number
" set relativenumber
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

let g:indentLine_faster = 1
let g:indentLine_leadingSpaceChar = '∙'
let g:indentLine_char = '│'
let g:indentLine_first_char = '│'
" let g:indentLine_leadingSpaceEnabled = 1
" let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_fileTypeExclude = ['qf', 'gitv', 'tagbar', 'vimfiler', 'unite', 'help', 'man', 'gitcommit', 'vimwiki', 'notes']

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
" inoremap <expr> <C-Space> <C-x><C-o><C-p>
" inoremap <C-@> <C-Space>
"
" function! Complete_trigger()
"   if &omnifunc == ''
"     return "\<c-n>\<c-p>"
"   else
"     return "\<c-x>\<c-o>\<c-p>"
"   endif
" endfunction
"
" inoremap <expr> <c-space> Complete_trigger()
" imap <C-@> <C-Space>

cmap w!! w !sudo tee > /dev/null %
cmap w; :echoe 'NO DAMMIT!'<cr>
cmap w' :echoe 'NO DAMMIT!'<cr>
cmap w/ :echoe 'NO DAMMIT!'<cr>

nnoremap / /\v
vnoremap / /\v

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
nnoremap <leader><space> :nohlsearch<cr>

" highlight last inserted text
nnoremap gV `[v`]

" jk is escape
inoremap jk <esc>

" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

nnoremap <silent> <leader>sws :call <SID>StripTrailingWhitespaces()<CR>
nnoremap <leader>q :bp<bar>sp<bar>bn<bar>bd<cr>


" Unite
" let g:unite_source_history_yank_enable = 1
" let g:unite_split_rule = 'botright'
let g:unite_prompt='» '
let g:unite_source_line_enable_highlight = 1
let g:unite_winheight = 8

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#profile('default', 'context', {
      \ 'cursor_line_highlight': 'CursorLine',
      \ })
if executable('ag')
  let g:unite_source_rec_async_command = 'ag --follow --nocolor --nogroup --hidden -g ""'
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts =
        \ '-i --line-numbers --nocolor --nogroup --hidden --ignore ' .
        \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
  let g:unite_source_grep_recursive_opt = ''
endif

" nnoremap <silent> <c-p> :Unite -auto-resize -toggle -start-insert -buffer-name=files file_mru file_rec/async<cr>
" nnoremap <silent> <leader>/ :Unite grep:.<cr>
" nnoremap <silent> <leader>o :<C-u>Unite -buffer-name=outline -toggle -auto-resize -direction=topleft outline<cr>
nnoremap <silent> <leader>y :<C-u>Unite -buffer-name=yank -toggle -quick-match -auto-resize -direction=topleft history/yank<cr>
nnoremap <silent> <leader>e :<C-u>Unite -buffer-name=buffer -quick-match -toggle -auto-resize -direction=topleft buffer<cr>

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  let b:SuperTabDisabled=1
  imap <buffer> <C-j> <Plug>(unite_select_next_line)
  imap <buffer> <C-k> <Plug>(unite_select_previous_line)
endfunction

nnoremap <silent> <leader>e :CtrlPBufTag<cr>
" }}}

" VimFiler {{{
nnoremap <silent> <leader>v :VimFiler -find -project -split -simple -winwidth=35 -toggle -force-quit -edit-action=choose<CR>
let g:vimfiler_as_default_explorer = 1
call vimfiler#custom#profile('default', 'context', {
      \ 'safe': 0,
      \ })
let g:vimfiler_ignore_pattern = '\(\.git\|__pycache__\|\.pyc\|\.DS_Store$\)'
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '*'

function! s:vimfiler_esttings()
  set nonumber
  set norelativenumber
  nmap <buffer> q Q
endfunction

autocmd FileType vimfiler call s:vimfiler_esttings()
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
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" We're all grown ups here, flake8. I'll decide how long is too long okay.
let g:syntastic_python_checkers=['flake8']
let g:syntastic_python_flake8_args='--ignore=E501,E226,F403'
" }}}

" CtrlP settings {{{
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_match_window = 'top,order:ttb'
let g:ctrlp_match_func = {'match': 'pymatcher#PyMatch'}
let g:ctrlp_lazy_update = 50
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 'a'
let g:ctrlp_custom_ignore = '\vbuild/|dist/|venv/|target/|\.(o|swp|pyc|egg)$'
let g:ctrlp_extensions = ['buffertag']
let g:ctrlp_mruf_exclude = '\.git/*\|/tmp/.*\|/temp/.*\|/var/folders/.*\|/usr/local/Cellar/neovim/.*'
" }}}

" YCM {{{
" let g:ycm_add_preview_to_completeopt = 1
" let g:ycm_min_num_of_chars_for_completion = 99
let g:ycm_filetype_blacklist = {
      \ 'notes': 1,
      \ 'markdown': 1,
      \ 'unite': 1,
      \ 'tagbar': 1,
      \ 'pandoc': 1,
      \ 'qf': 1,
      \ 'vimwiki': 1,
      \ 'text': 1,
      \ 'infolog': 1,
      \ 'mail': 1,
      \ 'python': 1,
      \ 'less': 1,
      \ }
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-j>'
let g:SuperTabCrMapping = 0
" nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

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
" nnoremap <leader>t :TagbarOpen fj<cr>
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
  nnoremap <leader>/ :Ag
  let g:ctrlp_user_command = 'ag ""%s -l --nocolor -g ""'
  " let g:ctrlp_use_caching = 0
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

" delimitMate {{{
let delimitMate_expand_cr = 2
let delimitMate_jump_expansion = 1
let delimitMate_matchpairs = "(:),[:],{:}"
" }}}

" File Type Auto Groups {{{
augroup configgroup
  autocmd!
  autocmd VimEnter * highlight clear SignColumn
  autocmd VimEnter * :Rooter
  autocmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
  autocmd BufEnter * if (exists('b:syntastic_skip_checks')) | unlet b:syntastic_skip_checks
  autocmd FileType c,cpp,objc nnoremap <silent><buffer> <leader>t :call <SID>c_swap_source()<cr>
  autocmd FileType python setlocal completeopt-=preview textwidth=79 shiftwidth=4 tabstop=4 softtabstop=4
  autocmd FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
  autocmd FileType python nnoremap <buffer> <leader>3 :call jedi#force_py_version(3)<cr>
  autocmd FileType man setlocal nolist norelativenumber nonumber nomodifiable
  autocmd FileType xml setlocal foldlevelstart=2
  " autocmd FileType gitcommit wincmd J
  autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md,*.rb :call <SID>StripTrailingWhitespaces()
  autocmd BufEnter *.cls setlocal filetype=java
  autocmd BufEnter *.zsh-theme setlocal filetype=zsh
  autocmd BufEnter Makefile setlocal noexpandtab
  autocmd BufEnter *.sh setlocal tabstop=2
  autocmd BufEnter *.sh setlocal shiftwidth=2
  autocmd BufEnter *.sh setlocal softtabstop=2
  autocmd BufNewFile,BufRead *.html setlocal filetype=htmldjango
  autocmd FileType htmldjango inoremap </ </<c-x><c-o><esc>a
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
  let l:modeline = printf(' vim: set ft=%s ts=%d sw=%d tw=%d %set :',
        \ &filetype, &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:commentstring = &commentstring
  if tcomment#TypeExists(&filetype) != ''
    let l:commentstring = tcomment#GetCommentDef(&filetype).commentstring
  endif
  let l:modeline = printf(l:commentstring, l:modeline)
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

" c-kinds of file swapping
let s:sources = ['.c', '.cpp', '.cc', '.cxx', '.m', '.mm']
let s:headers = ['.h', '.hh', '.hpp']

function! <SID>c_swap_source()
  let search = s:headers
  if expand('%:e') =~? '^h'
    let search = s:sources
  endif

  for ext in search
    let filename = expand('%:r') . ext
    if filereadable(filename)
      exec printf(':edit %s', filename)
    endif
  endfor
endfunction

"}}}

" Gitv {{{
let g:Gitv_OpenHorizontal = 1
let g:Gitv_OpenPreviewOnLaunch = 1
" }}}

let s:vimrc_local = expand("$HOME/.vimrc_local")
if filereadable(s:vimrc_local)
  exec "source " . s:vimrc_local
endif

" vim:foldmethod=marker:foldlevel=0
