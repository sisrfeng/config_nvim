"\ why I can use VimtexCompile in this buffer (vim file)
"\ but not other buffers which are not tex files.

let g:vimtex_grammar_textidote = {
    \ 'jar'   :  '/home/linuxbrew/.linuxbrew/Cellar/textidote/0.8.3/libexec/textidote.jar' ,
    \ 'args'  :  '--ignore sh:stacked,sh:c:itemix' ,
    \}

"\ 有些latex语法无法识别, 导致误报多, 但能找到textidote找不到的错误
"\ 作用是, 从.tex文件提取出纯文本, languagetool 找错误
let g:vimtex_grammar_vlty = #{
                        \ lt_command       : 'languagetool' ,
                        \ show_suggestions : 1              ,
                        \ shell_options    :
                                    \   ' --multi-language'
                                    \ . ' --packages "*"'
                                    \ . ' --replace  /home/wf/dotF/cfg/vimtex_languagetool_YaLaFi_repls.txt'
                                    \ . ' --equation-punctuation   display'
                                    \ . ' --define /data2/wf2/tT/wf_tex/thusetup.tex'
                                                \ }

        "\ - By default, the vlty compiler passes names of all ¿necessary¿ LaTeX packages  to YaLafi,
        "\ which may result in annoying warnings.
            "\ In multi-file projects,
                "\ these are suppressed by `--packages "*"` (存在s:vlty.shell_options里)  that simply
                "\ loads all packages known to the filter.

        "\ Option --single-letters ...
        "activates search for isolated single letters.
        "Note that only the '|' signs need to be escaped here 这是说还给python的时候不用escape?;
                                        "\ \ . ' --single-letters "i.\,A.\|z.\,B.\|\|"'


au AG User  VimtexEventView         echo '找到pdf'

"\ let =
    let g:vimtex_parser_bib_backend                  = 'bibtexparser'
    let g:vimtex_mappings_enabled                    = 1
    let g:vimtex_quickfix_autoclose_after_keystrokes = 20

    let g:vimtex_view_reverse_search_edit_cmd = 'split'
    let g:vimtex_complete_close_braces        = 1
    let g:vimtex_complete_bib = {'simple':1}
    let g:vimtex_view_use_temp_files          = 0
    "\ let vimtex_view_use_temp_files = 1    "\ 编译成功才update viewer
                                   "\ 导致编译成功后, 显示的还是老pdf

fun! Continuous_callbacK(msg)
    let outs = matchlist(
                  \ a:msg,
                  \ '\vRun number (\d+) of rule ''(.*)''',
                \ )
                    "\ 最外层改成双引号不行

    if !empty(outs)
        echo  '     ' . split(outs[2], "'\n")[0] . '  '  outs[1]
    en
endf


"\ " 要进了buffer后 VimtexCompile才被定义?
    "\ au AG BufEnter PasS.tex,*/tT/wf_tex/*/*.tex
    "\ \ try | echo b:vimtex.compiler.is_running() | echo '开了continuous' | catch | VimtexCompile | endtry

"\ continuous不能让tex文件一进入就开连续模式,
" 只是影响插件的这里
    "\ if self.continuous
        "\ let l:cmd .= ' -pvc -view=none'

"\ 'continuous' : 1, 开了以后 想关关不了?

let g:vimtex_compiler_latexmk = {
    "\ 所有选项都在这了
    \ 'build_dir'  : 'out扩展',
    \ 'callback'   : 1,
    \ 'continuous' : 0,
    "\ \ 'executable' : '/home/linuxbrew/.linuxbrew/bin/latexmk',  \ 没有官方的那么新
    "\ \ 'executable' : '~/d/texlive/bin/x86_64-linux/latexmk',  \ 在local.zsh里 加入到PATH
    \ 'hooks'      : [ function( 'Continuous_callbacK' ),  ],
    \ 'options'    : [
                "\ \   '-silent',
                    \ ],
    \}

"\ 默认的是F7, <C-F7>有时被识别为F7, 这里map了, 默认里的F7就不会map了
"\ 好像没啥用
    ino  t<F7>    <plug>(vimtex-cmd-create)
    nno  t<F7>    <plug>(vimtex-cmd-create)
    xno  t<F7>    <plug>(vimtex-cmd-create)


"\ toc
    "\ au AG BufRead  *.tex    VimtexTocToggle
    "\ au AG BufRead  *.tex    exe 'VimtexTocToggle | wincmd w'
    au AG User  VimtexEventTocCreated   wincmd w

    let g:vimtex_toc_show_preamble  = 0
    au wf_tex_autogroup  FileType tex call CreateTocs()

        fun! CreateTocs()
            "\ 作者教的
            nno  <buffer><silent>  gO :call g:toc_includE.toggle()<cr>
                                                        "\ 别用open(), 不会自动create toc
            let g:toc_includE = vimtex#toc#new(#{
                    \ name         : 'includes',
                    \ layers       : ['include'],
                    \})
        endf


    let g:vimtex_toc_config = #{
            \show_numbers       :  0,
            \indent_levels      :  1,
            \todo_sorted        :  1,
            \hotkeys_enabled    :  0,
           \ hotkeys_leader     :  '',
            \split_width        :  50,
            "\ \split_pos          :  'vert', 放右边会看不见
            \name               :  'tex目录',
            \fold_level_start   :  1,
            "\ 标题序号
            \fold_enable         :  1,
            \hotkeys            :  ',;.>abcdeilmnopuvxyz',
            \show_help          :  0,
            \hide_line_numbers  :  1,
            \refresh_always     :  1,
            \tocdepth           :  99,
            \resize             :  1,
            \layer_status       :  #{
                                    \label    :  0,
                                    \include  :  0,
                                    \todo     :  0,
                                    \content  :  1,
                                    \},
            \layer_keys         :  #{
                                     \label    :  'L',
                                     \include  :  'I',
                                     \todo     :  'T',
                                     \content  :  'C',
                                    \},
            \}

    let g:vimtex_toc_todo_labels = #{
                                \TODO_  :  'TODO: ',
                                \Todo_  :  'Todo: ',
                                \todo_  :  'todo: ',
                                \TODO  :  'TODO',
                                \Todo  :  'Todo',
                                \todo  :  'todo',
                                \FIXME :  'FIXME: ',
                                \}



let g:vimtex_quickfix_open_on_warning = 0
" let g:vimtex_fold_manual = 0
" let g:vimtex_fold_enabled = 0

let g:vimtex_quickfix_ignore_filters = [
    \ 'LaTeX Font Warning*using *instead',
    \ 'Package inputenc Warning: inputenc package ignored with utf8 based engines',
    \ 'Underfull',
    \ 'Overfull',
   \  'Missing "journal"'        ,
    \ 'Missing "author" in'      ,
    \ 'Warning--empty author in' ,
    \ 'Missing "year" in' ,
    "\ \ 'You have requested package',
    "\ \ 'warn',
    "\ \ 'warning',
    "\ \ 'Warning',
    "\ \ 'Marginpar on page',
    \]


let g:vimtex_log_ignore = [
            \ 'compilation complete',
           \  'Compiling selected lines ... done',
           \  'Compiling selected lines',
            \ ]


let g:vimtex_quickfix_method =  'latexlog'
"\ let g:vimtex_quickfix_method =  'pplatex'
"\ let g:vimtex_lint_chktex_ignore_warnings = ''
"\ let g:vimtex_lint_chktex_ignore_warnings = '-n1 -n3 -n8 -n25 -n36 -n25 -n40 -n57 -n76'
"

au AG  QuickFixCmdPost  lmake lwindow


"\ view:
    let g:vimtex_view_method          =  'zathura'
            " man zathura
                "    function! Synctex()
                "      execute "silent !zathura --synctex-forward " . line('.') . ":" . col('.') . ":" . bufname('%') . " " . g:syncpdf
                "      redraw!
                "    endfunction
                "    map <C-enter> :call Synctex()<cr>
                "
                " Then launch zathura with
                "
                    "\ zathura -x "gvim --servername vim -c \"let g:syncpdf='$1'\" --remote +%{line} %{input}" $file

    " let g:vimtex_view_method = 'zathura --mode fullscreen'  " 不行
    " let g:vimtex_view_zathura_options =  ''  " By default: '',
    " let g:vimtex_view_zathura_options =  '--mode fullscreen'
                                        " 没生效

let g:vimtex_syntax_custom_cmds = [ ]
    let simple_list = [
    "\ 不隐藏{a_arg我是参数}
           "\ 'par'     导致paragraph被隐藏了一部分
        \ 'hat'         ,
        \ 'begin'       ,
        \ 'multicolumn' ,
        \ 'end'         ,
        \ 'left'        ,
        \ 'right'       ,
        \ 'nonumber'    ,
        \ 'big'        ,
        \ 'hline'        ,
        \ 'hfill'        ,
        \ 'mathrm'        ,
    \ ]

        for noise in simple_list
            let dict_0 = #{name:'',  conceal:1}
            let dict_1 = #{name:'',  conceal:1, mathmode:1}
            let dict_0['name'] = noise
            let dict_1['name'] = noise

            let g:vimtex_syntax_custom_cmds
              \ = g:vimtex_syntax_custom_cmds ->add(dict_0)
                \ ->add(dict_1)
        endfor
        unlet simple_list


    let cchar_dictS = [
        "\ \ #{n: 'frac'    ,  cc:'除'  }   ,
        "\ \ #{n: 'in'         , cc: '' } ,
        \ #{n: 'exp'        , cc: 'e' } ,
        \ #{n: 'caption'    , cc: 'ﬆ' } ,
        \ #{n: 'rbrack'     , cc: ']' } ,
        \ #{n: 'x'          , cc: 'x' } ,
        \ #{n: 'times'      , cc: 'x' } ,
        \ #{n: 'hat'        , cc: '^' } ,
        \ #{n: 'tilde'      , cc: '∼' } ,
        \ #{n: 'leftarrow'  , cc: '←' } ,
        \ #{n: 'rightarrow' , cc: '→' } ,
        \ #{n: 'Vert'       , cc: '|' } ,
        \ #{n: 'quad'       , cc: ' ' } ,
        \ #{n: 'checkmark'  , cc: '✓' } ,
        \ #{n: 'Cref'       , cc: '♣' } ,
        \ #{n: 'cref'       , cc: '♣' } ,
        "\ \ #{n: 'sum_'       , cc: '⅀' } ,
        "\ \ #{n: 'alpha'      , cc: 'α' },
        "\ \ #{n: 'beta'       , cc: 'β' },
        "\ \ #{n: 'gamma'      , cc: 'γ' },
        "\ \ #{n: 'delta'      , cc: 'δ' },
        "\ \ #{n: 'epsilon'    , cc: 'ϵ' },
        "\ \ #{n: 'varepsilon' , cc: 'ε' },
        "\ \ #{n: 'zeta'       , cc: 'ζ' },
        "\ \ #{n: 'eta'        , cc: 'η' },
        "\ \ #{n: 'theta'      , cc: 'θ' },
        "\ \ #{n: 'vartheta'   , cc: 'ϑ' },
        "\ \ #{n: 'iota'       , cc: 'ι' },
        "\ \ #{n: 'kappa'      , cc: 'κ' },
        "\ \ #{n: 'lambda'     , cc: 'λ' },
        "\ \ #{n: 'mu'         , cc: 'μ' },
        "\ \ #{n: 'nu'         , cc: 'ν' },
        "\ \ #{n: 'xi'         , cc: 'ξ' },
        "\ \ #{n: 'pi'         , cc: 'π' },
        "\ \ #{n: 'varpi'      , cc: 'ϖ' },
        "\ \ #{n: 'rho'        , cc: 'ρ' },
        "\ \ #{n: 'varrho'     , cc: 'ϱ' },
        "\ \ #{n: 'sigma'      , cc: 'σ' },
        "\ \ #{n: 'varsigma'   , cc: 'ς' },
        "\ \ #{n: 'tau'        , cc: 'τ' },
        "\ \ #{n: 'upsilon'    , cc: 'υ' },
        "\ \ #{n: 'phi'        , cc: 'ϕ' },
        "\ \ #{n: 'varphi'     , cc: 'φ' },
        "\ \ #{n: 'chi'        , cc: 'χ' },
        "\ \ #{n: 'psi'        , cc: 'ψ' },
        "\ \ #{n: 'omega'      , cc: 'ω' },
        "\ \ #{n: 'Gamma'      , cc: 'Γ' },
        "\ \ #{n: 'Delta'      , cc: 'Δ' },
        "\ \ #{n: 'Theta'      , cc: 'Θ' },
        "\ \ #{n: 'Lambda'     , cc: 'Λ' },
        "\ \ #{n: 'Xi'         , cc: 'Ξ' },
        "\ \ #{n: 'Pi'         , cc: 'Π' },
        "\ \ #{n: 'Sigma'      , cc: 'Σ' },
        "\ \ #{n: 'Upsilon'    , cc: 'Υ' },
        "\ \ #{n: 'Phi'        , cc: 'Φ' },
        "\ \ #{n: 'Chi'        , cc: 'Χ' },
        "\ \ #{n: 'Psi'        , cc: 'Ψ' },
        "\ \ #{n: 'Omega'      , cc: 'Ω' },
    \ ]


        for a_dict in cchar_dictS
            let math0 = {}
                let math0['mathmode']    = 0
                let math0['conceal']     = 1
                let math0['name']        = a_dict['n']
                let math0['concealchar'] = a_dict['cc']
            call add(g:vimtex_syntax_custom_cmds,  math0)

            let math1 = {}
                let math1['mathmode']    = 1
                let math1['name']        = a_dict['n']
                let math1['concealchar'] = a_dict['cc']
                let math1['conceal']     = 1
            call add(g:vimtex_syntax_custom_cmds,  math1)
        endfor
        unlet cchar_dictS


    let hide_arg_dictS = [
        \ 'label'           ,
        \ 'etal'           ,
        \ 'ref'             ,
        \ 'fbox'            ,
        \ 'setlength'       ,
        \ 'eqref'           ,
        \ 'lbrack'          ,
        \ 'noindent'        ,
        \ 'underset'        ,
        \ 'overset'         ,
        \ 'flushleft'       ,
        \ 'setlength'       ,
        \ 'emph'            ,
        \ 'el'              ,
        \ 'cref'            ,
        \ 'figref'          ,
        \ 'secref'          ,
        \ 'includegraphics' ,
        \ 'f' ,
        \ 'centering'       ,
        \ 'itemsep'         ,
        \ 'setlength'       ,
        \ 'limits'          ,
        \ 'nolimits'        ,
    \ ]



        for noise in hide_arg_dictS
            let dict_0 = #{name:'',  conceal:1, hide_arg:1}
            let dict_1 = #{name:'',  conceal:1, hide_arg:1, mathmode:1}
                                            "\ 我加了这个功能
            let dict_0['name'] = noise
            let dict_1['name'] = noise

            let g:vimtex_syntax_custom_cmds
                \ = g:vimtex_syntax_custom_cmds ->add(dict_0)
                \ ->add(dict_1)
        endfor
        unlet hide_arg_dictS


    let regex_dictS = [
        \ #{n: 'Comma'  , re: '\,'       , cc:' '}   ,
        \ #{n: 'braceS' , re: '\\\{'     , cc:'{'  } ,
        \ #{n: 'braceE' , re: '\\}'      , cc:'}'  } ,
        \ #{n: 'in'     , re: 'in\ze\W'  , cc:'∈'  } ,
        \ #{n: 'etc'    , re: 'etc[.,]?' , cc:'_'  } ,
        \ #{n: 'ie'     , re: 'ie,'      , cc:'˘'   } ,
        \ #{n: 'eg'     , re: 'eg,'      , cc:'˘'  } ,
            "\ n: 'eg,'  "逗号导致报错
        \ #{n: 'eg2'    , re: 'e.g.'     , cc:'˘'  } ,
        \ #{n: 'eg3'    , re: 'e\.g\.'   , cc:'˘'  } ,
          "\ --- 封印它: \xrightarrow[]{} ----
        \ #{n: 'To_Right'    , re: 'xrightarrow\[]\{}'   , cc:'→'  } ,
        \ #{n: 'To_left'    , re: 'xleftarrow\[]\{}'   , cc:'←'  } ,
        \ #{n: 'split0'    , re: 'begin\{split}'   , cc:''  } ,
        \ #{n: 'split1'    , re: 'end\{split}'   , cc:''  } ,
        \]
                               "\ ¿\, ¿ :Include a thin space in math mode.


        "\ \ #{n: 'e'      , re: 'e\ze\u'   , cc:''  }  ,
        "\ \ #{n: 'b'      , re: 'b(egin)@!'     , Sty: 'bold'} ,
        "\ \ #{n: 'b'      , re: 'b(egin)@!'     , Sty: 'bold'} ,
        "\  \bomega \by等  只是\newcommand定义的bold$y$ 之类的, 不是通用命令
        "\ \ #{n: 'frac'    ,  concealchar:'除'               }   ,
        "\ 这导致大括号没了,分子分母粘在一起
        for a_dict in regex_dictS

            let math0 = {}
                let math0['mathmode']    = 0
                let math0['conceal']     = 1
                let math0['name']        = a_dict['n']
                let math0['cmdre']       = a_dict['re']
                try
                    let math0['concealchar'] = a_dict['cc']
                catch
                    "\ pass
                endtry

            call add(g:vimtex_syntax_custom_cmds,  math0)

            let math1 = {}
                let math1['mathmode']    = 1
                let math1['conceal']     = 1
                let math1['name']        = a_dict['n']
                let math1['cmdre']       = a_dict['re']
                try
                    let math1['concealchar'] = a_dict['cc']
                catch
                    "\ pass
                endtry

            call add(g:vimtex_syntax_custom_cmds,  math1)
        endfor
        unlet regex_dictS

    let arg_sty_dictS = [
        \ #{n: 'bm'        , cc:' ' , Sty: 'bold'} ,
        \ #{n: 'math'      , cc:' ' , Sty: 'bold'} ,
        \ #{n: 'textbf'    , cc:' ' , Sty: 'bold'} ,
        \ #{n: 'textit'    , cc:' ' , Sty: 'bold'} ,
        \ #{n: 'textsc'    , cc:' ' , Sty: 'bold'} ,
        \ #{n: 'paragraph' , cc:' ' , Sty: 'bold'} ,
        \ ]

        for a_dict in arg_sty_dictS
            let math0 = {}
                let math0['mathmode']    = 0
                let math0['conceal']     = 1
                let math0['name']        = a_dict['n']
                let math0['concealchar'] = a_dict['cc']
                let math0['argstyle']    = a_dict['Sty']
                let math0['cmdre']       = math0['name'] . '>'
            call add(g:vimtex_syntax_custom_cmds,  math0)

            let math1 = {}
                let math1['mathmode']    = 1
                let math1['conceal']     = 1
                let math1['name']        = a_dict['n']
                let math1['concealchar'] = a_dict['cc']
                let math1['argstyle']    = a_dict['Sty']
                let math1['cmdre']       = math1['name'] . '>'
            call add(g:vimtex_syntax_custom_cmds,  math1)

                "\ vimtex_syntax_custom_cmds 里这个, 使得¿{xxx}¿的¿{}¿被conceal
                    "\ if l:cfg.conceal && empty(l:cfg.concealchar)
                    "\     let l:arg_cfg.opts .= ' concealends'
                    "\ en

                " concealchar=' '
                    " (加空格)  才能conceal掉{xx_arg}?
                    "\ 矛盾?


        endfor
        unlet arg_sty_dictS




    " let g:vimtex_log_verbose       = 0
                                " 还是无法去掉和qf重复的echo
                                " 我改了~/PL/TeX/autoload/vimtex/echo.vim
                                " silent了echo和echon
                                " 还是不行
                                "
    "\ let g:vimtex_quickfix_autojump = 1
    "\ 放进map里了,动态调整,
    let g:vimtex_quickfix_autojump = 0  "\  没啥用

    let g:matchup_override_vimtex  = 1
        "\ To enable the plugin ¿match-up¿

    "\ let g:matchup_matchparen_deferred = 1  \ 在PL.vim里面设置了
        "\ If you experience slowdowns while moving the cursor,
        "\ To delay highlighting slightly while navigating


    let g:vimtex_syntax_nospell_comments = 1

    "\ 有些conceal只能处理数字, 字母不行, 找不到对应的unicode
    let g:vimtex_syntax_conceal = {
            \ 'cites'          :1,
            \ 'fancy'          :1,
            \ 'accents'        :1,
            \ 'ligatures'      :1,
            \ 'greek'          :1,
            \ 'math_bounds'    :1,
            \ 'math_fracs'     :1,
            \ 'math_symbols'   :1,
            \ 'sections'       :1,
            \ 'styles'         :1,
            \ 'math_delimiters':1,
            \ 'math_super_sub' :1,
            \}

    let g:vimtex_syntax_conceal_cites =  {
            \ 'type': 'icon',
            \ 'icon': '⊥',
            "\ \ 'icon': '',
            \}

        " " vim自带的tex插件的配置, 不需要?
        " let g:tex_xX = 'abdmg'
        " let g:tex_xX += 's'
        "
    "todo:
    " g:vimtex_syntax_packages

    let g:vimtex_syntax_nospell_comments = 1

    let  g:vimtex_compiler_silent = 0
    "\ let  g:vimtex_compiler_silent = 1
    "\ ✗用User 的event, 别用作者的echo信息✗
        "\ 别, vimtexlog被这废了

    au User VimtexEventCompileSuccess
            \ echo '应该输出到pdf了'

            "\ \ | VimtexView
            "\ \ echom 'compile success了' | VimtexView
                " 不加vimewtexvim, 也自动开view ? 好像只会在旧的pdf上跳到当前编辑位置


    "\ au User   VimtexEventCompileFailed
    "\     \ echo '编译失败, 好像会自动继续'

    "\ 这2个会echo多行:
            "\ "\ Only relevant when 'continuous compile':
                "\ au User VimtexEventCompileStopped
                        "\ \ echo '停止自动编译'
            "\
            "\ au User VimtexEventCompileStarted      echo '开始自动编译'
            "\             "\ 不必了, 这里有echo
            "\             "\  call vimtex#log#info('在compile')
    "\
    "\     au User  VimtexEventCompiling
    "\         \ echom '触发event: 连续编译'

aug  END

