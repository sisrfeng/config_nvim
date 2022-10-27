" 可以把其他补充的语言也放到这里  参考:
    " " Extends standard help syntax with highlighting of Scala code.
    "
    " "  conceal  codes between !sc!
    "     syntax region   rgnScala
                       "\ \ matchgroup=Ignore
                       "\ \ concealends
                       "\ \ start='!sc!'
                       "\ \ end='!/sc!'
                       "\ \ contains=`@ScalaCode`

if exists("b:current_syntax")  | finish  | endif

syn include $nV/syntax/vim.vim
"\ 代替了这一堆:
    "\ source $nV/syntax/vim.vim
    "\ unlet b:current_syntax

    "\ "\ 不生效:
    "\ "\ 清理vim.vim搞出来的conceal
    "\     setl conceallevel=0
    "\     call clearmatches()  " remove conceal effect
    "\     call nvim_buf_clear_namespace(0,-1,0,-1)
    "\     setl conceallevel=2
    "\
    "\ "\ 覆盖, 取消对for的'封印':    (现在要手动敲<c-k>, 再通过<c-s>重新conceal)
    "\ syn keyword Not_conceaL for

syn region helpComment_above_code
                        \ oneline
                        \ matchgroup=helpHidE
                        \ concealends
                        \ start=#\v^\s*\zs"\ze\s(\(|\u)#
                                      "\ 可能有string被误杀
                        \ end=#$#
                        \ contains=@vimCmts
    "\ syn match  helpComment_above_code  #\v^\s*" \u# contains=@In_fancY
        "\ help文档没说match可以用syn-include进来的group


" conceal
    hi def link  helpIgnore  Ignore
    syn match helpIgnore      "."  contained    conceal
                              " 为了后续使用 nextgroup=helpIgnore和matchgroup=helpIgnore, 使得某些位置的任意内容不高亮
        hi helpHeader guifg=#10a0a0 guibg=none
        syn match helpHeader        "\v\s*\zs.{-}\ze\s=\~$"   nextgroup=helpIgnore
                                                " 波浪号结尾的 是2级标题
        hi def link helpExample        Normal
                                       " 大部分>和<都被我删掉了, 很少匹配项
        syn region   helpExample       matchgroup=helpIgnore start=" >$"
                                                           \ start="^>$"
                                                           \
                                                           \ end="^[^ \t]"me=e-1
                                                           \ end="^<"
                                                        \ concealends
                                                        " the 2 ends of the region  are marked as concealable,

    hi  helpCmD guibg=#f4f0d3 guifg=none gui=none
        syn region  helpCmD
                \ oneline
                \ matchgroup=HideE
                \ start="\v^\s{10,}\zs:\ze\S"
                  "\ \ start="\v^\s{4,}\zs:\ze\S"
                  "\ 这会匹配:[count]spe等, 导致中括号无法隐藏
                  \ end="[^*]\zs$"
                  "\ 避免匹配 *:ls*等
                  \ end="\v\ze\s{4,}"
                \ concealends


                " 这里,两端用得不对:
                    " syn region   helpCmD       matchgroup=HidE start="\v^\s{4,}\zs:"hs=s+1   end="[^*]$"me=e-1

                " 之前用match 而非region, 不好:
                    "                       " 加了^ 导致无法封印: "^\s*\zs:"
                    " syn  match helpCmD   "\v^\s{4,}\zs:\p*[^*]$" contains=@Help_fancY,Cmd_begiN
                    "     " 不起作用
                    "                       " 只匹配缩进大于4的:Ex命令  (usually it is in an example)
                    " syn match Cmd_begiN   "\v^\s{4,}\zs:"   "   避免内部的冒号被封印
                    "     hi link Cmd_begiN  HidE1

hi  link   helpOption   In_Single_quotE
    syn match helpOption  "'\v[a-z]{2,}'"
    "\ 有时被In_Single_quotE覆盖



hi Old_guY  gui=strikethrough
    syn match Old_guY    "typo"
    "\ 这是啥?
    "\ syn match Old_guY    "\V++\.\*++"
    syn match Old_guY    "'cpoptions'"
    syn match Old_guY    "'cpo'"


    syn keyword Old_guY      DEPRECATED DEPRECATED: Deprecated: deprecate
    syn match   Old_guY                "'t_..'"
                                        " Nvim does not have special `t_XX` options
                                        " nor <t_XX> keycodes to configure  terminal capabilities.
                                        " Instead Nvim treats the terminal as any other UI,
                                        " e.g. 'guicursor' sets the terminal cursor style if possible.

hi In_Underline guifg=none gui=underline
    syn match In_Underline   contains=Exclam_up_down    "\v¡[-_a-zA-Z0-9'"*+/:%#=[\]<>.,]+¡"
                                                 " ¡包裹的
    syn match Exclam_up_down   '¡' contained conceal  cchar= " 加注释 防止删掉最后的空格

syn match  helpReset   '\vis reset( to)\@!' conceal cchar=✗
syn match  helpSet      'is set( to)\@!'  conceal cchar=✓


syn match StaR   "\*"  contained conceal
    " last win失败的特例:
        " - An item that ¿starts in an earlier position¿
        "     (show in the target file, which you are using syntax group)
        "     has priority over  items that start in later positions.

    "\ hi  In_StaR  guibg=none gui=none guifg=#e0eada "\   浅色 勉强能辨别
    hi  In_StaR  guibg=none gui=none guifg=#104220 "\   深绿色
    " " hi  In_StaR    guifg=#a05058 gui=none
        syn match In_StaR        "\v\*[#-)!+-~]+\*$"         contains=StaR
        syn match In_StaR        "\v\*[#-)!+-~]+\*\s"he=e-1  contains=StaR
    "                                                  " 加了这个 避免空格被高亮:
    "                                                  "    he   offset for where the Highlight End
    "                                                  "    e   end of the matched pattern
        syn match In_StaR_erroR        "\v\*E\d+\*$"         contains=StaR conceal
        syn match In_StaR_erroR        "\v\*E\d+\*\s"he=e-1  contains=StaR conceal



    " 让行末的help tag的fg和bg_wf一样, 藏起来
    hi  link In_StaR_EOL Normal
    "\ hi  In_StaR_EOL guifg=#fdf6e3
    " 明明在¿/XX¿搜索时可以匹配到行末的helptag,
    " 改highlight group却不生效 treesitter也显示无highlight
    syn match In_StaR_EOL    "\v[[:graph:]]\s{2,}\zs\*[#-)* +-~]+\*$"  conceal
                                   " [[:graph:]] 如何用\p等代替?
                                           " \s:用空格不好, 有些地方是tab
    syn match In_StaR_EOL    "\v^\s{9,}\zs\*[#-)* +-~]+\*$"            conceal
                                        " 别用conceal
                                        " (有些help_tag 被我拿来当小标题了)
                                        " \p\s+: 排除掉位于行首(作为小标题)的情况
                                        " \S\s+遇到中括号 或大括号结束时, 不能匹配
                                        " 为啥有的内容 能被这个regex 匹配, 但还是In_StaR的高亮?

    "\ syn match In_StaR_heaD    "\v^\*[#-)!+-~]+\*$"               conceal
    "\ 行首的helptag



" hi helpSpecial_key guifg=#707000 gui=none  " 太花了
hi helpSpecial_key guifg=none gui=none
        syn match helpSpeical_key               "CTRL-."
        syn match helpSpeical_key               "CTRL-SHIFT-."
        syn match helpSpeical_key               "CTRL-Break"
        syn match helpSpeical_key               "CTRL-PageUp"
        syn match helpSpeical_key               "CTRL-PageDown"
        syn match helpSpeical_key               "CTRL-Insert"
        syn match helpSpeical_key               "CTRL-Del"
        syn match helpSpeical_key               "CTRL-{char}"
        syn match helpSpeical_key               "META-."
        syn match helpSpeical_key               "ALT-."
        syn match helpSpeical_key               "<[SCM]-.>"
            "                                    <S-某某>
            "                                    <C-某某>
            "                                    <M-某某>
        syn match helpSpecial_key               "<[-a-zA-Z0-9_]\+>"
            "                                      <aa>
            "                                      <CR>
            "                                      <NL>
            "                                      <my_any_Thing_11>等

hi helpSpecial guifg=#886655 gui=bold
" N在help里表示数字吧
    syn match helpSpecial               "\v<N>"
    syn match helpSpecial               "\v<N\.$"me=e-1
    syn match helpSpecial               "\v<N\.\s"me=e-2

    syn match helpSpecial               "(N\>"ms=s+1
    "
    syn match helpSpecial               "Nth"me=e-2
    syn match helpSpecial               "N-1"me=e-2
    syn match helpSpecial               "\[N]"
    "  avoid highlighting N  N in help.txt
        hi helpNormal gui=none guifg=none guibg=none
            syn match helpNormal                "<---*>"
            syn match helpNormal                "N  N"he=s+1


" 处理中括号包裹的: last win
    " 很多挪去lei_light了
    "
    "
    syn match help_OptionaL               "\v\s\[[-a-z^A-Z0-9_]{2,}]"ms=s+1
                                              " [count] 等
                                              " [flags]
                                              " 这是optional吧?  之前错写成special?
    hi help_OptionaL guifg=#b0b0b0
    " 本来叫做helpSpecial

    " 笨办法 枚举
        syn match helpOptionaL         '\[!]'
        syn match helpOptionaL         '\["x]'
        syn match helpOptionaL         '\[{options}]'
        syn match helpOptionaL         '\V[{\a\+}]'

        syn match helpOptionaL         "\[range]"
        syn match helpOptionaL         "\[line]"
        syn match helpOptionaL         "\[count]"
        syn match helpOptionaL         "\[offset]"
        syn match helpOptionaL         "\[cmd]"
        syn match helpOptionaL         "\[num]"
        syn match helpOptionaL         "\[+num]"
        syn match helpOptionaL         "\[-num]"
        syn match helpOptionaL         "\[+cmd]"
        syn match helpOptionaL         "\[++opt]"
        syn match helpOptionaL         "\[arg]"
        syn match helpOptionaL         "\[arguments]"
        syn match helpOptionaL         "\[ident]"
        syn match helpOptionaL         "\[addr]"
        syn match helpOptionaL         "\[group]"


          " Don't highlight those [某某] do not have a tag
            syn match helpNormal      "\v\[(readonly|fifo|socket|converted|crypted)]"



    syn match helpURL `\v<(((https?|ftp|gopher)://|(mailto|file|news):)[^'  <>"]+|(www|web|w3)[a-z0-9_-]*\.[a-z0-9._-]+\.[^'        <>"]+)[a-zA-Z0-9/]`
    hi def link    helpURL               String
    hi  helpURL   guifg=#333333 guibg=none gui=none

" 这些没啥用, 只处理固定的几个关键字, (为了显示help文档的示例颜色?)
" 这里的Statement等 是普通字符串, 没特别含义, 不是变量
    syn match helpStatement          "\s[* ]Statement\s\+[a-z].*"
    hi def link    helpStatement   Statement

    "     .. ..
        "\ syn match helpTodo               "\t[* ]Todo\t\+[a-z].*"



" hi def link   helpHeadline       Ignore
"     syn match helpHeadline    "\v^[-A-Z .][-a-zA-Z0-9 .\(\)_]*\ze($|\s+\*)"
                    "    改乱了


hi def link helpSectionDelim  Ignore
    syn match helpSectionDelim  "^===.*===$"
    syn match helpSectionDelim  "^---.*--$"



let g:vimsyn_embed = 'lPr'
                    " lua python ruby
                    "
" 官方文件里 这三行是这个顺序, 且在最后
    let b:current_syntax = "help"



" 这是?
" syn match helpvim                   "{[-_a-zA-Z0-9'"*+/:%#=[\]<>.,]\+}"
" hi def link    helpVim               Identifier
"
" todo: 删掉help里的:
    " syn match helpVim               "\<Vim version [0-9][0-9.a-z]*"
    " syn match helpVim               "VIM REFERENCE.*"
    " syn match helpVim               "NVIM REFERENCE.*"
    " syn match helpNormal               "VIM REFERENCE.*"
    " syn match helpNormal               "NVIM REFERENCE.*"

