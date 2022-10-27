fun! vim#Short_iT() abort
    mark s
    try
        sil! % sub @\v^\s*\zsfunction!\ze @fun!@g
    endt

    try
        sil! % sub @\v^\s*\zsendfunction>@endf@g
    endt

    try
        sil! % sub @\v^\s*\zselse>@el@g
    endt

    try
        sil! % sub @\v^\s*\zsendif>@en@g
    endt

    try
        sil! % sub @\v^\s*\zsexecute@exe @g
    endt

    try
        sil! % sub @\v^\s*\zsnoremap!@no! @g
    endt

    try
        sil! % sub @\v^\s*\zsnoremap@no @g
    endt

    try
        sil! % sub @\v^\s*\zsonoremap@ono @g
    endt

    try
        sil! % sub @\v^\s*\zsxnoremap@xno @g
    endt



    try
        sil! % sub @^\s*\zscommand!@com! @g
    endt

    try
        sil! % sub @\v^\s*\zshighlight\ze(!| )@hi@g
    endt

    try
        sil! % sub @\v^\s*\zssyntax\ze\s@syn @g
    endt

    try
        sil! % sub @\vsetlocal\ze\s@setl @g
    endt


    try
        sil! % sub @\v^\s*(n|v|c|i|t)\zsnoremap\ze\s@no @g
    endt

    try
        sil! % sub @\v^\s*\zsautocmd\ze @au@g
    endt
    try
        sil! % sub @\v^\s*\zsautocmd\ze!($| )@au@g
    endt

    try
        sil! % sub @\v^\s*\zsaugroup\ze @aug @g
    endt

    try
        sil! % sub @\v^\s*\zsnormal\ze( |!)@norm@g
    endt

    try
        sil! % sub @\v^\s*\zsendtry$@endt@g
    endt

    try
        sil! % sub @\v^\s*\zssilent\ze!? @sil@g
    endt


    "\ 奇怪: 这能把#替换为¿norm¿
        "\ try
        "\     sil! % sub ##norm#g
        "\ endtry


    call histdel("search", -27,)
    norm  's



endf


fun! vim#To_taG()
    let g:Old_isK = &isk
    set isk+=#
    exe "normal!  \<c-]>"
    " exe 'normal!  \<c-]>'  单引号内, backslash can not escape?
    let isk = g:Old_isK
    " echo 'iskeywords:'  &isk
endf

