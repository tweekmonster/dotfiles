" Toggle line numbers and listchars if I need to copy text from a remote session
function! <SID>Toggle()
    if !exists('b:togglefancy_orig_number')
        let b:togglefancy_orig_number = &l:number
        let b:togglefancy_orig_rnumber = &l:relativenumber
        let b:togglefancy_orig_list = &l:list
        let &l:number = 0
        let &l:relativenumber = 0
        let &l:list = 0
    else
        let &l:number = b:togglefancy_orig_number
        let &l:relativenumber = b:togglefancy_orig_rnumber
        let &l:list = b:togglefancy_orig_list
        unlet b:togglefancy_orig_number
        unlet b:togglefancy_orig_rnumber
        unlet b:togglefancy_orig_list
    endif
endfunc

nmap <silent> <leader>p :call <SID>Toggle()<CR>
