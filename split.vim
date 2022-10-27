"\ -------------------------下面全用于半自动断句, 帮助阅读英文论文/doc------------------------------------------
" 定义停词
    " stop word: https://gist.github.com/sebleier/554280

" 用g: 方便debug

fun! Short_is_beautY()

" right 系列
    let pause_right =  '%('
        " 1.标点符号
            let pause_right .=  '%('
                    let pause_right .= '.{3,10}'
                                     "\ 貌似没生效
                                         " 标点符号前, 有3个以上字符时 才切, 避免切得太碎
                    " '(' . '<\k+>' . '["]|''}0-9 ]?' . ')'
                     " collection里, 空格不用转义
                        " 单引号里面要用单引号, 必须多写一个
                        " '[某某]某某某某] 方括号里的方括号, 表示literal的]
                        " 加这行, 避免标点符号单独成行?
                        " 还是不行:
                    let pause_right .=  '[,;.!?:]'
            let pause_right .=   ')'

        let pause_right .=  '|'
        " 2. conditional split
            " 避免 这种情况下会切得很碎: a word, which
            let pause_right .=  '\w [,;''"]?'
            let pause_right .=  '<' . '%('
                    let pause_right .=  'or|'
                    let pause_right .=  'and|'
                    let pause_right .=  'which|'

                    let pause_right .=  'since'
                                " 最后一个不能有¿|¿
            let pause_right .=        ')' . '>'

        let pause_right .=  '|'
        " 3. unconditional split
            let pause_right .=  '<' . '%('
                    let rightS = []
                        let rightS ->add(  'in which case'         )
                        let rightS ->add(  'than'                  )
                        let rightS ->add(  'through'               )
                        let rightS ->add(  'and then'              )
                        let rightS ->add(  'until'                 )
                        let rightS ->add(  'as if'                 )
                        let rightS ->add(  'because'               )
                        let rightS ->add(  'ensure that'           )
                        let rightS ->add(  'so that'               )
                        let rightS ->add(  'by'                    )
                        let rightS ->add(  'used to'               )
                        let rightS ->add(  'helps to'              )
                        let rightS ->add(  'or not'                )
                        let rightS ->add(  'in order to'           )
                        let rightS ->add(  'is composed of'        )
                        let rightS ->add(  'of this is that'       )
                        let rightS ->add(  'It is \w{-} to'        )
                        let rightS ->add(  'evaluated to'          )
                        let rightS ->add(  'there are cases where' )
                        let rightS ->add(  'possible to'           )
                        let rightS ->add(  'means that'            )
                        let rightS ->add(  'via'                   )
                        let rightS ->add(  'example'               )
                        let rightS ->add(  'what if'               )
                        let rightS ->add(  'between'               )
                        let rightS ->add(  'leading to'            )
                        let rightS ->add(  'is worth noting that'  )
                        let rightS ->add(  'demonstrate that'      )
                        let rightS ->add(  'in that'               )
                        let rightS ->add(  'such that'             )
                        let rightS ->add(  'to make it'            )
                        let rightS ->add(  'based on'              )
                        let rightS ->add(  'that leads to'         )
                        let rightS ->add(  'that is'               )
                        let rightS ->add(  'the assumption that'   )
                        let rightS ->add(  'without the need of'   )
                    let pause_right .=   rightS ->join('|')
            let pause_right .=         ')' . '>'

            let pause_right .=  '|'

            let pause_right .=  '%('
            let right2 = []
                let right2 ->add(  '\)' )
                let right2 ->add(  ':}' ) " latex里{tittle:}
                let right2 ->add(  '\.}' )  " {Sentence in brace.}
                let right2 ->add(  '\w}' )   " {phrase in brace}
            let pause_right .=  right2 ->join('|')
            let pause_right .=  ')'  "\  之前少了这个括号,浪费半小时debug


    let pause_right .=  ')'


    let s:Split_Right =  pause_right . '\zs' . ' ' . '\ze' . '.{2,}'
                                              " ☝ 要找的是空格, 其前后方要有指定的内容
" left系列
             " lt: list
    let pause_left =  '<' . '%('
        let leftS = []
        let leftS ->add( 'then'           )
        let leftS ->add( 'using'          )
        let leftS ->add( 'if'             )
        let leftS ->add( 'If'             )
        let leftS ->add( 'without'        )
        let leftS ->add( 'but'            )
        let leftS ->add( 'as well as'     )
        let leftS ->add( 'guarantees that')
        let leftS ->add( 'whether')
        let leftS ->add( 'then'           )
        let leftS ->add( 'in another word')
    let pause_left .=  leftS ->join('|')
    let pause_left .=         ')' . '>'


    let s:Split_Left = '\zs \ze' . pause_left . '.{2,}'
                         " ☝ 要找的是空格

" in系列 (之前叫inside)
" between
    let s:Split_In = '<' . '%('
    let in_them = []
        let in_them ->add('when.{-}\zs \zeit')
                                "{-}: matches 0 or more of the preceding atom, as few as possible
                                " 和点号搭配 能避免匹配的内容太长
        let in_them ->add('when.{-}\zs \zeis')
        let in_them ->add('when.{-}\zs \zethey')
        let in_them ->add(  'transform .{-}\zs \zeto')
        let in_them ->add( 'transforms .{-}\zs \zeto')
        let in_them ->add('transformed .{-}\zs \zeto')
        let in_them ->add(      'from .{-} \zs \zeto')
        "\ let in_them ->add('%(is|was|are|were)>\zs \ze%(the|a)')
        let in_them ->add('avoid.{-}\zs \zefrom')
        let in_them ->add('and\zs \zethe other')

    let s:Split_In .=  in_them ->join('|')
    let s:Split_In .=       ')' . '>'

        " todo
        " 划分主谓宾:
           " \v<when .{-}(a|an|the)[^,]{30,}\zs\s\ze(is|are|was|were)([^,]){2,},
          " when a function
              " that has been defined before
              " is defined again
                  " it will die

    let s:Split_In .= '|'
    let s:Split_In .='%('
        let s:Split_In .= '\S\zs' . '\s{2,}' . '\ze[^*[:space:]]'
                          "\ 2个以上的space          排除*wf_help_tag*等
    let s:Split_In .= ')'

" Subject Verb Object
    let s:Split_Sbj =  '\S.{30,40}\zs \ze<%(is|are|was|were)>.{10,20}'
    "\ 导致其前面的标点不能被match?
                        " 主语很长 就切开?
"\ CJK
    let s:Split_CJK = '[，。）：；、和及“]'
    "\ let s:Split_CJK = '[和及(以及)]'
                    "\ ¿[]¿里, ¿()¿不能捆绑,
                    "\ 单独被match:
                        "¿(¿  ¿以¿  ¿及¿ ¿)¿
    let s:Split_CJK .= '|'

    let cjk = []
        let cjk ->add('然后')
        let cjk ->add('所以\ze\w')
    let cjk = cjk ->join('|')

    let s:Split_CJK .= cjk



    "\ 可以单独用:
    "\ nnor <silent>  <M-c>  <Cmd>call Find_next_cjk()<CR>
            func! g:Find_next_cjk()
                if @/ != s:Split_CJK
                    let @/ = s:Split_CJK
                el
                    norm! n
                en
            endf

"\ others
    let s:Split_Others = '\zs \ze\('


" todo:
    " 多行空行 变一行
    " nnor <Leader>d :%subs!\n\n\n\+!\r\r!g

" todo:  remove废话词:
    let useless_Str = '\v' . '<' . '%('
        let del_them = []
        let del_them ->add('note that')
        let del_them ->add('furthermore')
        let del_them ->add('in fact')
        let del_them ->add('it is well known that')
        let del_them ->add('that being said,')
    let useless_Str .= del_them->join('|')
    let useless_Str .=              ')' . '>'

"\ main function:
func! Split_line()  " 特定位置的空格替换为\r(换行)

    let search_hist = @/

    let ori_idt = indent( line('.') )
    let pre_idt = indent( line('.') - 1 )
    if pre_idt > 0 && ori_idt - pre_idt > 4
    "\ 专治help里的无用大缩进
        let ori_idt = pre_idt + 4
    en
        if ori_idt < 4
            let ori_idt = 4
        elseif ori_idt < 8
            let ori_idt = 8
        elseif ori_idt < 12
            let ori_idt = 12
        elseif ori_idt < 16
            let ori_idt = 16
        elseif ori_idt < 20
            let ori_idt = 20
        el
            let ori_idt = 24
        en
    let ori_idt -= 4  " 不加这行会多缩进4 space, do not know why

    mark t
    " 如果不用mark, 光标会跳到新得到的\r处, 函数后续的操作就不进行了
    silent! .,/^\s*$/+1sub#^\s*$#\r#e
    norm! `t
        " 失败的尝试:
            " fun! g:Split_paragrapH()
            "     exe '.,/^\s*$/+1' . 'sub#' . '^\s*$' . '#' . '\r' . '#g'
            "         " from current line to next 空行
            "         " 一个空行变2个
            "         " 避免粘连到下一段
            "         " 且函数结束后, 2段之间还有空行
            "     exe 'norm! \<c-o>'
            " endf

            " call Split_paragrapH()
                " 加了这行导致 整个函数没变化
            " exe '.,/^\s*$/+1' . 'sub#' . '^\s*$' . '#' . '\r' . '#g'
                " 直接放着也不行

    hi Visual  guibg=none guifg=none gui=none
        " 避免高亮干扰.


    " 百分号前断行  (not work):
        " if &ft == 'tex'
        "     silent! .,/%/sub#$\n\zs%#\r%#gce
        "     normal <c-o>
        " endif

    " exe 'normal'  '\<Leader>x'
    " 避免粘连 上一行 但多一个空行
        norm O
        norm! j
        norm! vip

        " 失败的方法:
            " norm! vip
            " norm! o
            " norm! k
                " 但现在执行'o'时, 光标behaves like at the fisrt line of paragraph

            " normal v}
                " 想避免粘连 上一行 但不行...


    norm! J
    " norm! gq
        " 有点复杂, 先不用

    " 开始subst:
        " todo: 一个subs命令里 分多个group 分别替换?

        exe "'<,'>" . 'subs #\v' . s:Split_Right . '#\r#ge'
        exe "'<,'>" . 'subs #\v' . s:Split_Left . '#\r#ge'
        exe "'<,'>" . 'subs #\v' . s:Split_In . '#\r#ge'


        " 在then等处indent
            " 不行
                " exec 'subs #' . s:Split_Right . '#\r_X_X#ge'
                                                    " 然后:
                                                    "✗ 最后sub#_X_X#    #ge✗

                "\ exec "'<,'>" . 'subs #\v' . s:Split_Left . '#\r' . repeat('┗',4) . '#ge'
                "\ exec "'<,'>" . 'subs #\v' . s:Split_Right . '#\r' . repeat('┚',4) . '#ge'

                " 放到¿:left¿ 后  处理特殊单词前的缩进
                    " norm! V:<C-U>call cursor(line("'}")-1,col("'>"))<CR>`<1v``
                    " sub#┗┗┗┗#    #ge
                    " sub#┚┚┚┚#    #ge



        " norm! gv
        exec 'subs #:\zs #\r\t#ge'
                    " 冒号后的空格, 变成换行并缩进
        " exec 'subs #\v^\s*##ge'
            " 注释了这行没变化

        " 断掉的word, 复原
            norm! vip
            sub #\v\w\zs‐ {0,3}\ze\w##ge

        " 去掉开头的空格, 以便看着整齐:
        " exec 'subs #' . '\v^\s{5,}' . '#    #ge'
            " 五个以上的空格, 变4个
        exec "'<,'>" . 'sub #\v' . s:Split_Sbj    . '#\r#ge'
        exec "'<,'>" . 'sub #\v' . s:Split_Others . '#\r#ge'

        exec "'<,'>" . 'sub #\v' . s:Split_CJK    . '#\0\r#ge'

                " indent({lnum})
                "
                "     The result is a Number,
                "     which is indent of line {lnum} in the current buffer.
                "     The indent is counted in spaces,
                "         the value of 'tabstop' is relevant.
                "     {lnum} is used just like in  |getline()|.
                "     When {lnum} is invalid -1 is returned.

    " 取2个空行之间
    exe  'silent'  '?^\s*$?' . '+1' . ',\/-1' . 'left' ori_idt
                    " ¿?any__?¿: 上一个match,
                    " ^\s*$表示空行      ¿\/¿下一个match

    norm! vip
    " norm! vip   和在exec后加上它 作用一样?   ¿"'<,'>"¿
    exec 'subs #\v^\S+\zs\s\s+##ge'
                    " 行内的任何2个以上的空格 变成1个空格
                        " 数字待调整



    " '<by [^(default)]|'  这样匹配¿by  xxxx¿, 2个空格
    " 把不应该split的重新合并
    norm! v
    "\ norm! vip  \ 导致文本里 多插入¿p¿ 奇怪了
    exec "'<,'>" . 'sub #' . 'by\n\s*default' . '#by default#ge'

    norm! v
    exec "'<,'>" . 'sub #' . 'outside\n\s*of' . '#outside of#ge'

    let @/ = search_hist
endf


let s:Manual_Sbj =  '%(\S.{10,40}\zs \ze<%(the|an|a|is|are|was|were)>.{10,})'
let s:Manual_Sbj .=  '|'
let s:Manual_Sbj .=  '%(\S.{10,40}<%(to|that|of|by)>\zs \ze.{10,})'

" 汇总
    "\ 现在split系列里 只有这个global变量
    "\ Split_line函数也不是global的了, 因为script外可以通过map调用

    "\ If more than  one branch matches,
        "\ the first one is used.
       "\ (出现在文本里的第1个, 而非定义时的第1个branch?)

    let g:Split_Them =  '\v' . s:Split_Right
                 \ . '|' . s:Split_Others
                 \ . '|' . s:Split_In
                 \ . '|' . s:Split_Left
                 \ . '|' . s:Split_CJK

                 "\ \ . '|' . s:Split_Sbj

                 "\ 它太容易被匹配到, 抑制了其他branch?
                 "\           s:Manual_Sbj
                       "\ let s:Manual_Sbj =  '%(\S.{1,20}\zs \ze)'
                 "\ 用了它,
                 "\ 这里¿.}¿就无法匹配
                    "\ Self-training assumption.} The predictions



" • key mapping
    nnor <silent> <M-j>  <Cmd>call Find_Them()<CR>
        func! Find_Them()
            if @/ != g:Split_Them
                let @/ = g:Split_Them
            el
                norm! n
                    " 敲¿:/¿和¿/¿ 竟然是一样的
                    " exe '/' . g:Split_Them
                    " exe 'norm! /' . g:Split_Them

                    " 涉及prompt shortmess,
                    " 能改变/ register, 但有bug, 要往上翻/的历史
            en
        endf
                " 失败:
                    " nnor  <M-j>   <Cmd>call g:Search_ahead()<cr>
                    " func! g:Search_ahead()
                    "     let g:current_line_nuM = line('.')
                    "      exec ' norm!'   '/%>' . g:current_line_nuM . g:Split_Them
                    "     echom 'hi'
                    " endf


    nno <silent> <M-p>  <cmd>mark t<cr>
                       \<Cmd>call Split_line()<cr>`t

    "\ nno <silent> <M-p>  <Cmd>let search_hist = @/<cr>
    "\                    \<Cmd>call Split_line()<cr>
    "\                     \<Cmd>call histdel('search', -15,)<cr>o<esc>
    "\                     \<Cmd>let @/ = search_hist<cr>
                                                                                     " zz: center of the screen
        " nno <silent> <M-p>  vip:call Split_line()<cr>
        "                  _ If the paragraph has n lines,
        "                  the functions will be called n times.(confirmed by echo)

    vnor <silent> <M-p> J: call Split_line()<cr>

    nnor <silent> <M-n>  hnrb
    " nnor <silent> <M-n>  hnr\rb  "  会被替换为b

    nnor <silent> <S-M-l> VJ: call Split_line()<cr>gv>j
        " todo: 选中到行末 \.$

        " 我的笔记:https://zhuanlan.zhihu.com/p/494987947?

" formatexpr
                             " visual区域光标开始行号
    " set formatexpr=Split_line(v:lnum, v:lnum+v:count-1)
        " || E475: Invalid argument: v:lnum)
        " set formatexpr=Split_line(v:lnum, v:lnum+v:count-1)
                  " 等号后的 任意位置的空格⤴ ,
                  " 导致这行出错 (空格把一行命令分成了2个命令?)

endf

silent call Short_is_beautY()
