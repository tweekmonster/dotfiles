" The django/python/htmldjango filetype situation is a gigantic clusterfuck.
"
" This file contains stuff for htmldjango files, but is named django.vim because the
" htmldjango.vim file that ships with vim sources html.vim and django.vim.
"
" Of course, using python.django for the Python files ALSO sources django.vim.
"
" Awesome.

let b:surround_{char2nr("v")} = "{{ \r }}"
let b:surround_{char2nr("{")} = "{{ \r }}"
let b:surround_{char2nr("%")} = "{% \r %}"
let b:surround_{char2nr("b")} = "{% block \1block name: \1 %}\r{% endblock \1\1 %}"
let b:surround_{char2nr("i")} = "{% if \1condition: \1 %}\r{% endif %}"
let b:surround_{char2nr("w")} = "{% with \1with: \1 %}\r{% endwith %}"
let b:surround_{char2nr("f")} = "{% for \1for loop: \1 %}\r{% endfor %}"
let b:surround_{char2nr("c")} = "{% comment %}\r{% endcomment %}"
let b:surround_{char2nr("T")} = "{% \1tag\1 %}\r{% end\1\1 %}"

if (&ft == "htmldjango" || &ft == "htmljinja" || &ft == "jinja")
    if exists("loaded_matchit")
        let b:match_ignorecase = 1
        let b:match_skip = 's:Comment'
        let b:match_words = '<:>,' .
        \ '<\@<=[ou]l\>[^>]*\%(>\|$\):<\@<=li\>:<\@<=/[ou]l>,' .
        \ '<\@<=dl\>[^>]*\%(>\|$\):<\@<=d[td]\>:<\@<=/dl>,' .
        \ '<\@<=\([^/][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>,'  .
        \ '{% *if .*%}:{% *else *%}:{% *endif *%},' .
        \ '{% *ifequal .*%}:{% *else *%}:{% *endifequal *%},' .
        \ '{% *ifnotequal .*%}:{% *else *%}:{% *endifnotequal *%},' .
        \ '{% *ifchanged .*%}:{% *else *%}:{% *endifchanged *%},' .
        \ '{% *for .*%}:{% *endfor *%},' .
        \ '{% *with .*%}:{% *endwith *%},' .
        \ '{% *comment .*%}:{% *endcomment *%},' .
        \ '{% *block .*%}:{% *endblock *%},' .
        \ '{% *filter .*%}:{% *endfilter *%},' .
        \ '{% *spaceless .*%}:{% *endspaceless *%}'
    endif
endif
