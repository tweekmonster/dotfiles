runtime! syntax/jinja.vim
syntax include @Python syntax/python.vim
syntax region pyblock matchgroup=PyBlock start=/{% python %}\zs/ end=/\zs{% endpython %}/ contains=@Python
