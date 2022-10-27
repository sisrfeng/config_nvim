if exists("b:current_syntax")  | finish  | endif

syn match	qf_FirstPart	#^[^|]*# nextgroup=qfSeparator

syn match	qfSeparator	"|"      nextgroup=qfLineNr contained  conceal cchar= " space
syn match	qfLineNr	#[^|]*#  contained          contains=qfError
syn match	qfError		"error"  contained

syn match	qf_Fname	#^\f\+\.\f\+|[^|]\+|  \?#   conceal
                         "\ foo.bar|xxxx| 后面的空格数为1-2



syn match  qf_HidE     #/home/wf/dotF/cfg/nvim/#  conceal cchar=
          "\ /home/linuxbrew/.linuxbrew/Cellar/neovim/0.7.2_1/share/nvim/runtime
syn match  qf_HidE
        \ #/home/linuxbrew/.linuxbrew/Cellar/neovim/0.7.2_1/share/nvim/#
        \ conceal
        \ cchar=

syn match  qf_HidE
       \ #~/PL#
        \ conceal
        \ cchar=


syn match  qf_HidE     #\.vim|| $#  conceal   cchar=·



"\ 不需要了
        "\ syn match qf_error_location
        "\     \ "\v\\@<!\|\d+ col \d+ (info|warning|error)| "
        "\     \ contains=Bar_with_lnuM
        "\     \ conceal

setl modifiable


" The default highlighting.
    hi def link   qf_FirstPart	Directory
    hi def link   qfLineNr	    LineNr
    hi def link   qfError	    Error

let b:current_syntax = "qf"

