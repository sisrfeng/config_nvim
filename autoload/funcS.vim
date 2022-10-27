func! funcS#PrinT_N()
    let b:autopairs_enabled = 0     " 避免自动给我插入成对符号
    " silent! call AutoPairsToggle()  " 避免自动给我插入成对符号

    if &ft == 'python'
        " todo 加叹号
        " normal! 表示不允许mapping
        exe "normal yiWoprint(f'{= }')"
        exe "normal hhhhp"
    elseif &ft == 'cpp'
        " exe 'normal yiWocout<<""<<' | exe 'normal hhhpf<lpa<<endl;'
        exe 'normal yiWocout<<""<<'
        exe 'normal hhpf<lpa<<endl;'
    elseif &ft == 'zsh'
        exe 'normal yiwoecho ${}'
                       " ⤴  zsh等号2边没有space, 用W不好
        exe "normal p"
    elseif &ft == 'vim'
        exe 'normal! yiWoechom " 是: "    '
        normal  pHeelp
    endif

    let b:autopairs_enabled = 1
endf

func! funcS#PrinT_V()
    let b:autopairs_enabled = 0

    silent! call AutoPairsToggle()
    if &ft == 'python'
        exe "normal! gv"
            " 退到normal mode, 再选中刚才visual mode选中的
            " exe "visual y"  visual 是退出ex mode，进入normal mode, 不是在visual mode 执行
            " https://stackoverflow.com/questions/5084428/how-do-i-execute-visual-mode-commands-from-a-vim-function
        exe "normal! yoprint(f'{= }')"
            " 这样不行:
                " exe "normal! gv" . "normal! yoprint(f'{= }')"
        exe "normal! 5hp"
    elseif &ft == 'vim'
        exe "normal! gv"
        exe 'normal! yoechom " 是: "    '
                           " ⤴ 有空格, 所以要套在exe里
        exe "normal  pHeelp"
    endif

    let b:autopairs_enabled = 1
endf

func! funcS#Py_wf()
        if   getline(1)  !~    'if "wf_package":'
      \ &&  getline(1)  !~    '^#!'

            call append(0 , 'if "wf_package":')
            call append(1 , '    import os       ; wf_home = os.path.expanduser("~/")'   )
            call append(2 , '    import sys      ; sys.path.append(wf_home)'             )
            call append(3 , '    import warnings ; warnings.filterwarnings("ignore")'    )
            call append(4 , '    from  dotF.leo_common.leo_base   import *')
            call append(5 , '')
            call append(5 , '')
        en
        " update
            " 如果由autocmd触发, 别自动保存, 避免搞乱不了解的file
        norm! gg
        "\ echo '美化注释'
        "\ if search('#  ', '' ) != 0  | % sub @#  \ze\S@# @gec  | en
endf

"\ 淘汰了:
    " 自动插入文件 前面部分
    "\ func! funcS#AutoHead()
    "\     if &ft == 'sh'
    "\         call setline(1, "\#!/bin/zsh")
    "\     elseif &ft == 'python'
    "\         " google Python风格规范: 不要在行尾加分号, 也不要用分号将两条命令放在同一行。
    "\         " 但不会报错
    "\
    "\         call setline(1, 'if "wf_package":')
    "\
    "\         " call append(1, '#-----------------------自动import结束------------------------#')
    "\         call append(2, '    from dotF.snippetS import *')
    "\         call append(2, '    sys.path.append(wf_home)')
    "\         call append(2, '    wf_home = os.path.expanduser("~/")')
    "\         call append(1, '    import sys')
    "\         call append(1, '    import os')
    "\         call append(1, '    import json')
    "\         call append(1, '    import numpy as np')
    "\         call append(1, '    import cv2 as cv,cv2')
    "\         " call append(1, '#-----------------------自动import开始------------------------#')
    "\
    "\         " call append(2, '    ')
    "\         " call append(2, '    print(round(wf_str,2))')
    "\         " call append(2, '    if type(wf_variable) ==r ')
    "\         " call append(2, 'def xprint(wf_variable):')
    "\         " 括号内部不能换行
    "\     endif
    "\
    "\     normal G
    "\     normal o
    "\     normal o
    "\ endf


func! funcS#VerBosE(level, ex_cmd) abort
    "\ let temp = '/tmp/leo_nvim_tmp.vim'
    let temp = tempname() . '.vim'
    let ver_file = &verbosefile
    call writefile(
              \[':' . a:level . 'Verbose  ' . a:ex_cmd ],
              \temp,
              \'',
          \  )
            "\ \)
            " 'b':   binary, (no NL used)

    "\ 用command而非function的好处: 可以自动补全
    return
        \ '\vtry\|' .
        "\ \ 'try|' .
        \     'let &verbosefile = ' . string(temp) . '|' .
        \     'silent ' . a:level . 'verbose exe ' . string(a:ex_cmd) . '|' .
        \ 'finally|' .
        \      'let &verbosefile = ' . string(ver_file) . '|' .
        \ 'endtry'

        "\ \ 'endtry|' .
        "\ \
        "\ \ 'pedit ' . temp . '|wincmd P'
    " todo: 放进quickfix
endf



" put =Vim_out('你的命令')
    " 似乎:Verbose更好, 暂时不用:
    func! funcS#Vim_out(my_cmd)
    " https://unix.stackexchange.com/a/8296/457327
        redir =>my_output
        " a 表示argument
        silent exe a:my_cmd
        redir END
        return my_output
    endf
    " 无论单引号还是双引号包裹Vim_out('m'), 都不生效.放弃:
        "\ cnorea <expr> m  getcmdtype() == ":" && getcmdline() == 'Vim_out('m')'  ? 'put = Vim_out('messages')'  :   'm'




func! funcS#Conceal_tmp()
    syn match conceal_StranG  /[^[:print:]]/ conceal cchar=   " 空格会被自动删掉
    set conceallevel=2
    set concealcursor=vc
endf

" au AG BufRead *.txt  exe ":call Conceal_strang_chr_3()"
func! funcS#Conceal_strang_chr_3()
    " set isprint=1-255  " 设了屏幕会很乱
    set isprint+=9  " 设了屏幕会很乱
    " syn match name_you_like  /[^[:print:]]/ conceal cchar=%
    " set conceallevel=3
    " set concealcursor =vcni
endf

func! funcS#RuN()
    exe "w"

    if &ft == 'python'
        exe "Verbose !python %"
        " 跑votenet的某个文件时,若这样执行,pc_util.write_ply没被调用;
        " 若正常在zsh下敲python执行,则正常(nvim所用的python环境 不是votenet所在环境吧)
    elseif &ft == 'vim'
        exe "message clear | source %"
    elseif &ft == 'sh'
        exe "! zsh %"
    elseif &ft == 'zsh'
        exe "! zsh %"
    elseif &ft == 'cpp'
        exe " ! rm -f /d/script.wf_cpp; g++ -std=c++11 % -Wall -g -o /d/script.wf_cpp `pkg-config --cflags --libs opencv` ; /d/script.wf_cpp "
    endif
endf

" files
    fun! funcS#TrasH(...) abort
        if a:0 > 0   "  有传参
            " if a:1   之前用这行, 不行, 因为if 'abc' 等于if FALSE,  if '1abc' 才等于if TRUE

            exe '! mv'  a:1  '~/.t/'..a:1..'__moved_by_vim'
            echo "moved"  a:1
        el
            " silent! write
            let _file = filereadable(expand("%:p"))
            if _file
                exe '! mv'  fnameescape(expand("%:p"))  '    ~/.t/'..fnameescape( expand("%:p:t") )..'__moved_by_vim'
                                                        " put some spaces here , to see the interval easily
                " echom "moved" fnameescape(expand("%:p"))
            else
                echom bufname() ":  This buffer is not from a file__"
            en
            bwipeout!
        en
    endf

    " Create the directory path.  This will also create any intermediate  directories.
    fun! funcS#md(path) abort
        let need_dir = expand(a:path)
        if need_dir is# ''
            let need_dir = expand('%:p:h')
        en

        if isdirectory(need_dir)
            return
        en

        if filereadable(need_dir)
            echohl Error | echom printf("%s exists and isn't a directory", need_dir) | echohl None
            return
        en

        echom    'Hi,  Creating directory: '.need_dir
        " 虽然没有错误,但会被当作error, 进入Messages:
            " echoerr 'e Creating directory: '.need_dir


        call mkdir( need_dir, 'p')

    endf





func! funcS#Out_linE(pattern_str)
    normal! mo
    let @/ =  a:pattern_str

    setl foldlevel=3
    setl foldmethod=expr   foldexpr=funcS#See_searcH()
                                " level为3,4或5  (其实其他数字也行,避开0,1这些经常出现的数字)
                                " 之前少加funcS#, 不报错, 但是没有效果
    normal! 'ozM
        " normal! 'ozMzv
        " zv: 需要时手动敲
endf

    func! funcS#See_searcH()
        if getline(v:lnum) =~ @/
            return 3
        else
            return funcS#Fold_around()
        endif
    endfunc

        func! funcS#Fold_around()
            if  (getline(v:lnum-1) =~ @/) || (getline(v:lnum+1) =~ @/ )
                return 4
            else
                return 5
            endif
        endfunc


fun! funcS#To_digiT()
    let ori_isk = &iskeyword
    setl iskeyword<

    mark d
        "\ d: digit
    % sub #\v<zero>#0#ge
    % sub #\v<non-\zszero>#0#ge
    % sub #\v\C<half a>#0.5#ge

    % sub #\v<at least \zsone>#1#ge
    " % sub #\v\C<one>#1#ge
            " One such example vs 1 such 后者有点奇怪
            " one is xx, another xxx
            " one is xx, the other xxx
            " one may argue
    % sub #\v<two>#2#ge
    % sub #\v<three>#3#ge
    % sub #\v<four>#4#ge
    % sub #\v<five>#5#ge
    % sub #\v<six>#6#ge
    % sub #\v<seven>#7#ge
    % sub #\v<eight>#8#ge
    % sub #\v<nine>#9#ge
    % sub #\v<ten>#10#ge
    % sub #\v<eleven>#11#ge
    % sub #\vthe \zsfirst>#1st#ge
    % sub #\vthe \zssecond>#2nd#ge
    % sub #\vthe \zsthird>#3rd#ge
    % sub #\vthe \zsfourth>#4th#ge
    % sub #\vthe \zsfifth>#5th#ge
    % sub #\vthe \zssixth>#6th#ge
    % sub #\vthe \zsseventh>#7th#ge
    % sub #\vthe \zseighth>#8th#ge
    % sub #\vthe \zeninth>#9th#ge
    % sub #\vthe \zetenth>#10th#ge
    % sub #\vthe \zeeleventh>#11th#ge
    norm! `d

    let  &iskeyword = ori_isk

endf


fun! funcS#Short_iT() abort
    mark s
    let old2new = {
                \ 'ground truth': 'GT',
                \ 'state-or-the-art': 'SOTA',
                \ 'Specifically,': '',
                \ 'Furthermore,' : '',
                \ '\<note that ' : '',
                \ 'In particular,' : '',
                \ 'particularly,' : '',
                \ 'inevitably' : '',
                \ 'we believe that ' : '',
                \ '^\s*\zs%\s*$' : '',
              \}
    for [Old,NeW] in items(old2new)
        try
            exe 'silent! % sub #' . Old . '#' . NeW . '#g'
        endtry
    endfor

    let old2new_ = {
                \ 'we believe ' : '',
                "\ 如何和'we believe that'在同一个dict, 因为dict是unordered,
                "\ 可能导致留下that在文本里
              \}
    for [Old,NeW] in items(old2new_)
        try
            exe 'silent! % sub #' . Old . '#' . NeW . '#g'
        endtry
    endfor


    call histdel("search", len(old2new) + len(old2new_) )
    normal  's
endf


