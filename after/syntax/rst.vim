syn match  rstMeth   #:meth:#  conceal
"\ syn match  rstTilde   #:meth:`\zs\~#  conceal
"\ 还得是matchadd来暴力封印
call matchadd('Conceal', '\v:\w+:`\zs\~', 100, -1, {'conceal':''})
call matchadd('Conceal', '\*\*', 100, -1, {'conceal':''})


syn region  rstDouble_BackTick  concealends matchgroup=conceal  start=/``/ end=/``/
hi link rstDouble_BackTick String

"\ syn region  rstDouble_BackTick  concealends   start=#``# end=#``#
"\ syn region  rstDouble_BackTick concealends matchgroup=conceal  start=#``# end=#``#
"\ conceal contained containedin=rstInlineLiteral
"\ syn match  rstDouble_BackTick   #``#  conceal contained containedin=rstCruft

