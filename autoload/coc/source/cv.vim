function! coc#source#cv#init() abort
  return {
        \ 'priority': 92,
        \ 'shortcut': 'cv',
        \ 'triggerCharacters': ['@']
        \}
endfunction

function! coc#source#cv#complete(opt, cb) abort
  let items = ['AlexNet', 'GoogLeNet', 'Inception', 'ResNet', 'VGG']
  call a:cb(items)
endfunction

