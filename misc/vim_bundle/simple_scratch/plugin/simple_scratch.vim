augroup Shit
    autocmd!
    autocmd BufEnter __shit__ setlocal buftype=nofile
    autocmd BufEnter __shit__ setlocal bufhidden=hide
    autocmd BufEnter __shit__ setlocal noswapfile
augroup END

command! Scratch :e __shit__
