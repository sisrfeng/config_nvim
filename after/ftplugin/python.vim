fun! s:clean_py()
    silent! %sub @\V# %% [code]\.\*\$@# ----------------------------@ge
    silent! %sub @\V# %% [markdown]\.\*\$@# ----------------------------@ge
endf

"\ nno <buffer>  si  <cmd>call s:clean_py()<cr>
nno <buffer>  si  <cmd>call <SID>clean_py()<cr>
