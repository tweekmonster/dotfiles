" Removes the search highlight on insert mode and restores it in normal mode
function! s:HideHighlight(b)
    if a:b
        " Would use histget('search', -1), but doesn't make sense for restoration
        let b:last_search = @/
        let @/ = ""
    else
        if exists('b:last_search')
            let @/ = b:last_search
            unlet b:last_search
        endif
    endif
endfunction

augroup AutoHideSearch
    autocmd!
    autocmd InsertEnter * :call s:HideHighlight(1)
    autocmd InsertLeave * :call s:HideHighlight(0)
augroup END
