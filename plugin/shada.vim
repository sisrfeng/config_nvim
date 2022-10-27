if exists('g:loaded_shada_plugin')
    finish
en
let g:loaded_shada_plugin = 1

augroup ShaDaCommands
    autocmd!
    " why :if instead of  if ??
    au      BufReadCmd *.shada,*.shada.tmp.[a-z]
                \ :if !empty(v:cmdarg) |  throw '++opt not supported' | endif
                \ | call setline('.', shada#get_strings(readfile(expand('<afile>'),'b')))
                \ | setl     filetype=shada
    au      FileReadCmd *.shada,*.shada.tmp.[a-z]
                \ :if !empty(v:cmdarg)|throw '++opt not supported'|endif
                \ |call append("'[", shada#get_strings(readfile(expand('<afile>'), 'b')))


    " key step:  writefile
        au      BufWriteCmd *.shada,*.shada.tmp.[a-z]
                    \ :if !empty(v:cmdarg)|throw '++opt not supported'|endif
                    \ |if writefile(shada#get_binstrings(getline(1, '$')),
                                                 \expand('<afile>'), 'b') == 0
                    \ |  let &l:modified =  (  expand('<afile>') is# bufname(+expand('<abuf>')  )
                                                            "\is# same instance  # means match case
                                                                 \? 0
                                                                 \: stridx(&cpoptions, '+') != -1)
                    \ |endif


        au      FileWriteCmd *.shada,*.shada.tmp.[a-z]
                    \ :if !empty(v:cmdarg)|throw '++opt not supported'|endif
                    \ |call writefile(
                                \shada#get_binstrings(getline(min([line("'["), line("']")]),
                                                             \max([line("'["), line("']")]))),
                                \expand('<afile>'),
                                \'b')
        au      FileAppendCmd *.shada,*.shada.tmp.[a-z]
                    \ :if !empty(v:cmdarg)|throw '++opt not supported'|endif
                    \ |call writefile(
                                \shada#get_binstrings(getline(min([line("'["), line("']")]),
                                                                                         \max([line("'["), line("']")]))),
                                \expand('<afile>'),
                                \'ab')


    au      SourceCmd *.shada,*.shada.tmp.[a-z]
                \ :execute 'rshada' fnameescape(expand('<afile>'))
augroup END
