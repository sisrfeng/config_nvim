"\ interactive shell?
"\ 参考:
    "\ https://github.com/Shougo/deol.nvim

"\ set shellcmdflag=-i  "用zshrc, 危险?

"\ todo
"\ 做成类似zsh的alias
    com!  -nargs=*  ComB
                  \ call Cmd_with_banG(<f-args>)
                    fun! Cmd_with_banG(...)
                        com!  -bang a:1
                    endf

    "\ if s:sh_fold_functions
    "\     com! -nargs=* ShFoldFunctions <args> fold
    "\ el
    "\     com! -nargs=* ShFoldFunctions <args>
    "\ en


"\ make相关
    au AG WinEnter * if &buftype == 'quickfix' | setl modifiable | endif
    "\ au AG WinEnter * if &buftype == 'quickfix' | setl modifiable | echom 'WinEnter了quickfix' | endif
          "\ WinEnter:
            "\ After entering another window.
            " (switch from another buffer/window?)

          "\ When you just open quickfix buffer/window (not switching to, e.g., by <c-w>w)
          " &buftype variable isn't set yet
    "\ 所以要加上:
    au AG BufWinEnter  quickfix    setl modifiable
    "\ 不行:
        "\ au BufReadPost quickfix  setl  modifiable
        "\ au BufReadPre  quickfix  setl  modifiable

    "\ BufWinEnter在什么时候  可以代替BufReadPost?

    let g:asyncrun_exit = "silent doautocmd BufWinEnter quickfix"



    "\ 直接敲 ¿AsyncRun make¿ , 不行, 相当于!make, zsh的make



set cmdheight=1
" To reduce the number of hit-enter prompts:   Set 'cmdheight' to 2 or higher.

               " path
com! -nargs=0  Pwd
            \ let @" = systemlist( 'git rev-parse --show-toplevel' )[0]
            \ | echo '此git的root:  '   @"


" files
    com!  -nargs=? -complete=file T    call funcS#TrasH(<f-args>)
                " 0 or 1 arguments are allowed

    au AG BufWritePre  *  call funcS#md( expand('<amatch>:p:h')  )
        com!  -nargs=* -complete=dir Md    call funcS#md( <q-args> )


"\ If you want <Left> and <Right> to move the cursor instead of selecting
"\ a different match, use this:
    :cno <Left>     <Space><BS><Left>
    :cno <Right>    <Space><BS><Right>


" cnorea/cmap. 它们 对vscode也有效
" 别用cnoremap m messages等  (任意位置敲m都会成了messages)

com! -nargs=? -complete=file   S      call Save_aS(<f-args>)

    fun! Save_aS(...) abort
        let f_name = fnameescape (expand("%:p:t") )
        if a:0 > 0
            let @n = 'save '..a:1..''
        el
            let @n = 'save $nV/'
                " https://stackoverflow.com/a/16510089/14972148
        en

        exe @n..f_name
    endf


    nno <c-space>sn  :Save $nV/
    "\ nno <c-space>sl  :Save ~/d/final/arxivs/
    "\ nno <c-space>sw  :Save ~/d/write/

    nno <space>sn    :Save $nV/
    "\ nno <space>sl    :Save ~/d/final/arxivs/
    "\ nno <space>sw    :save ~/d/write/

    nno <space>sn    <cmd>call Runtime2mine()<cr>
        fun! Runtime2mine()
            let l:path = expand('%:p')
            echom "l:path 是: "   l:path
            if l:path =~ "share/nvim/runtime"
                let tail_ = split(l:path, 'runtime/')[-1]
                exe 'write $nV/' . tail_
                write | bdelete
                exe '-tab drop    $nV/' . tail_
            el
                echom '不是runtime文件, 现在啥也没干'
            en
        endf


    au AG FileType w3m  nno <buffer>  <space>sw   <Cmd>set modifiable<cr>:save ~/d/write/tex


" cabbrev
" 1. 只在该string is exactly the string in thhe cmdline时, 才abbr
    func! g:Exactly_abbR(_in, _out)
            " global, 让no_vscode.vim和has_vscode.vim都能用
            exe ' cnorea <expr> '
                    \.. a:_in
                    \..' getcmdtype()==":"  && getcmdline()==  '''  ..a:_in..  ''' ? ''' .. a:_out..''' : '''..a:_in..''' '
            "                                                         " 'str_in'       ?      'str_out'     :    'str_in'
            "                                                   "  ¿''¿在string里表示一个单引号
            "                                                     "  单引号套单引号, 看着很晕 (可以用match() 隐藏单引号)
            "                                                     " (试过双引号, 不行?)
    endf


    let Day_tmp = "~/.t/" . strftime("%-d日_%-m月_")


    let exactly_abb_dict = #{
                            \ cfg   :  'cd ~/dotF/cfg',
                            "\ ma   :  'tab Man!',
                                "\ 不必了, look外观.vim里加了: au AG BufNewFile,BufRead *.man   lua require("man").highlight_man_page()
                            \ ma    :  'tab Man'                                     ,
                            \ mai    :  '-tab drop /home/wf/d/t-pool/src/main.py'                                     ,
                            \
                            \ ckh   :  'checkhealth'                                 ,
                            \ st    :  'write \| source %'                           ,
                                                "\ source this
                            "\ \ r     :  'register'                                    ,
                            \ r     :  'Denite register'                                    ,
                            \ m     :  '20Messages'                                    ,
                            \ es    :  'EditScript'                                    ,
                            "\ \ m     :  'Messages'                                    ,
                            \ mm    :  'CocDiagnostic'                               ,
                            \ di    :  'CocDiagnostic'                               ,
                            \ me    :  'Messages'                                    ,
                            \ cs    :  'Denite change'                               ,
                            \ ch    :  'Denite change'                               ,
                            \ cmd   :  'Commands'                                    ,
                            \ em    :  'Verbose echo v:errmsg'                       ,
                            \ mc    :  'messages clear'                              ,
                            \ bu    :  'Denite buffer'                               ,
                            \ buf   :  'Denite buffer'                               ,
                            \ gcp   :  'getcmdpos()'                                 ,
                            \ imap  :  'Verbose imap'                                ,
                            \ cmap  :  'Verbose cmap'                                ,
                            \ tmap  :  'Verbose tmap'                                ,
                            \ nmap  :  'Verbose nmap'                                ,
                            \ map   :  'Verbose call KeymaP( input("请输入:") )<cr>' ,
                            \ oh    :  'echo "buftype:" &buftype ", bufname():" bufname() ", filetype:" &filetype ", syntax:" &syntax',
                            "\ options here
                            \
                            \ bm    : '-tab drop $nV/b_map.vim'                                  ,
                            \ gm    : '-tab drop $nV/map.vim'                                    ,
                            \ j     : 'Denite jump'                                              ,
                            \ de     : 'Denite'                                              ,
                            \ ju    : 'Denite jump'                                              ,
                            \ jum   : 'Denite jump'                                              ,
                            \ jump  : 'Denite jump'                                              ,
                            \ jumps : 'Denite jump'                                              ,
                            \ o     : 'call Smart_out_linE()'                                              ,
                            \ hs    : 'call vim_current_word#vim_current_word_toggle()'          ,
                            "\ Highlight Same word
                            \ cls   : 'CocList sources'                                          ,
                            \ q1    : 'q!'                                                       ,
                            \ vt    : 'Vimtex'                                                   ,
                            \ n     : 'Scriptnames'                                              ,
                            \ rn    : 'Rg $nV'                                                   ,
                            \ ro    : 'Rg ~/dotF'                                                ,
                            \ ed    : 'vertical diffsplit ./'                                    ,
                            \ hc    : '-tab help coc-'                                           ,
                            \ li    : 'BLines'                                                   ,
                            \ sa    : 'save'                                                     ,
                            \ hil   : 'so $VIMRUNTIME/syntax/hitest.vim'                         ,
                            \ t     : "noswap -tab drop " . Day_tmp . "/v.vim"                     ,
                            \ et    : "noswap -tab drop " . Day_tmp . "/p.py"                      ,
                            \ P     : 'Pwd'                                                 ,
                            \ p     : 'Pwd'                                                 ,
                            \ sn    : 'S ~/dotF/cfg/nvim/'                                       ,
                            \ Sn    : 'S ~/dotF/cfg/nvim/'                                       ,
                            \ dt    : 'diffthis'                                                 ,
                            \ ww    : '-tab TW3m'                                                ,
                            \ clm : 'call clearmatches()'                                      ,
                            \ cc  : '-tab drop $nV/coc-settings.json \| filetype detect'       ,
                            \ hw  : '-tab WW3m https://learnvimscriptthehardway.stevelosh.com' ,
                            \ ts  : 'TSEnable highlight'                                       ,
                            \ tse : 'TSEnable highlight'                                       ,
                            \ tsd : 'TSDisable highlight'                                      ,
                            \ bt  : 'Breakadd here'                                            ,
                            \ wf  : '-tab drop ~/d/s_kaggle/working/wf-test.py',
                            "\ \ pdf   :
                            "\ \ pd    :
                            "\ \ wo    :
                            \}
                            " hw: hard way
                            " hh: help of hard way
                            " hc: help of coc-
                            "\ bd:   '-tab drop ~/local.zsh', 很少用了, 留给本来的bdelete

                            let exactly_abb_dict['..']  =  ' cd .. <Bar> pwd'
                            " ¿.¿会expand
                            let exactly_abb_dict['.']   =  ' cd .. <Bar> pwd'
                            let exactly_abb_dict['_']   =  ' cd .. <Bar> pwd'
                            let exactly_abb_dict['__']  =  ' cd ../.. <Bar> pwd'
                            let exactly_abb_dict['___'] =  ' cd ../../.. <Bar> pwd'
                            let exactly_abb_dict["~"]   =  "cd ~/"

                            " 逗号如何escape?
                                " let exactly_abb_dict["'<,'>d"] =  "''<,''>D2F"
                                " let exactly_abb_dict["'<,'>d"] =  "'<,'>D2F"
                                " exe 'cnoreabbrev'  '<,'>d  '<,'>D2F
                            vno <Leader>d   :'<,'>D2F<cr>:echom 'spaces: double to four'<cr>gv





    for [k,v] in items(exactly_abb_dict)
    " for [k,v] in items(abb_dict):  有冒号 但报错没弹出来 要敲message
        call g:Exactly_abbR(k, v)
    endfor

    cnorea <expr> ctr getcmdtype() == ":" && getcmdline() == '-tab help ctr' ? 'CTRL' : 'ctr'

  " 1.5  打开dotF下的文件
      func! Abbr_F(_in, _out)
          exe 'cnorea <expr> '
                      \. a:_in
                      \. ' getcmdtype() == ":" && getcmdline() == '''
                      \. a:_in
                      \  . '''  ?  ''-tab drop ~/dotF/'
                      "\ . '''  ?  ''edit ~/dotF/'
                      \. a:_out
                      \. '''   :   '''
                      \. a:_in
                      \. ''''
      endf

      let file_dict = #{
                      \ pl :   'cfg/nvim/PL.vim'                                             ,
                      \ sv :   'cfg/nvim/syntax/vim/main.vim'                                             ,
                      \ cl :   'cfg/nvim/clipboard_regis.vim'                                ,
                      \ cr :   '../PL/TeX/autoload/vimtex/syntax/core.vim' ,
                      \ fu :   'cfg/nvim/fuzzy.vim'                                          ,
                      \ lo :   'cfg/nvim/look外观.vim'                                       ,
                      \ fm :   'cfg/nvim/fmt.vim'                                            ,
                      \ sp :   'cfg/nvim/split.vim'                                          ,
                      \ tx :   'cfg/nvim/after/syntax/tex.vim'                               ,
                      \ te :   'cfg/nvim/after/syntax/tex.vim'                               ,
                      \ in :   'cfg/nvim/init.vim'                                           ,
                      \ co :   'cfg/nvim/conceal_fast.vim'                                   ,
                      \ cm :   'cfg/nvim/cmdline.vim'                                        ,
                      \ tg :   'cfg/nvim/tex插件cfg.vim'                                        ,
                      \ id :   'cfg/nvim/indenT.vim'                                         ,
                      \ mE :   'cfg/nvim/comE.vim'                                           ,
                      \ c  :   'cfg/nvim/colors/leo_light.vim'                               ,
                      \ lc :   'cfg/nvim/lua/my_cfg.lua'                                     ,
                      \ no :   'cfg/nvim/no_vscode.vim'                                      ,
                      \ av :   'cfg/nvim/after/syntax/vim.vim'                               ,
                      \ has:   'cfg/nvim/has_vscode.vim'                                     ,
                      \
                      \ se :   'cfg/git/setting.yml'                                         ,
                      \ tc :   'cfg/tmux/tmux.conf'                                          ,
                      \
                      \ s  :   'zsh/rc.zsh'                                                  ,
                      \ al :   'zsh/alias.zsh'                                               ,
                      \ a  :   'zsh/alias.zsh'                                               ,
                      \ hp :   'zsh/help.zsh'                                                ,
                      \ rh :   'zsh/_zfunc/run_help_leo'                                     ,
                      \ zb :   'zsh/bind.zsh'                                                 ,
                      \ ahk:   '../../../mnt/f/MS_dotF/key.ahk'                                 ,
                      \
                      \ az :   'auto_install/auto_install.sh'                                ,
                      \
                      \ pa :   '../d/tT/wf_tex/PasS.tex'                                     ,
                      \ mk :   'cfg/latexmk/latexmkrc'                         ,
                      \ fr :   '../d/tT/wf_tex/data/frog.tex'                                ,
                      \ su :   '../d/tT/wf_tex/pre.tex'                                 ,
                      \ rf :   '../d/tT/wf_tex/refs.bib'                                 ,
                      \ ic :   '../PL/icons/plugin/icon_wf.vim'   ,
                      \ ba :   '../d/s_kaggle/working/base24.py'   ,
                      \}

      for [k,v] in items(file_dict) |  call Abbr_F(k, v) |  endfor

    "\ cnorea :help
        "\         \ <c-r>=( getcmdtype() == ":" && getcmdpos()==1
        "\                    \ ? "-tab help"
        "\                    \ : ":help"
        "\                \ )<CR>'
        "\


    "\ 本想让复制来的`help 某某某` 自动变为`-tab help 某某某`:
        "\ 没用, 一定要光标在所敲字符后, 才能变为想要的
            "\ func! g:Aliases(_in, _out)
            "\     " 封装成了global函数,  让no_vscode.vim和has_vscode.vim都能用
            "\     exe ' cnorea'
            "\             \ a:_in
            "\             \ '<c-r>=( getcmdtype() == ":"
            "\                        \ ? '''.. a:_out.. '''
            "\                        \ : '''..a:_in..'''
            "\                    \ )<CR>'
            "\ endf
            "\ call Aliases('help', 'echo')
            "\ call Aliases('help', '-tab help')

" 2. 现在搞成 有点shell的alias, 但光标必须要位于开头, 且前面不能有空格
    func! g:Abbr_like_aliaS(_in, _out)
        " 封装成了global函数,  让no_vscode.vim和has_vscode.vim都能用
        exe ' cnorea'
                \ a:_in
                \ '<c-r>=( getcmdtype() == ":" && getcmdpos()==1
                           \ ? '''.. a:_out.. '''
                           \ : '''..a:_in..'''
                       \ )<CR>'
    endf




    " the #{} form can be used  to avoid having to put quotes around every key
        " 但不能key里不能有特殊符号
                "之前有这行, 导致出错:
                    " \ ~/   : 'cd ~/',
                    " escape后也不行
                    " \ \~\/   : 'cd ~/',

    "\ remember to escape bar \|
    let abbr_as_alias_dict = #{
        \ ec   : 'echom'                                                             ,
        \ C    : 'copen'                                                             ,
        \ L    : 'lopen'                                                             ,
        \ v    : 'Verbose'                                                           ,
        \ ss   : 'source $cache_X/nvim/sess_leo.vim'                                 ,
        \ e    : '-tab drop'                                                         ,
        \ sc   : 'Save $cache_X/saveas/'                                             ,
        \ l    : 'lopen'                                                             ,
        \ ui   : 'Denite'                                                            ,
        \ d    : '%retab! \| D2F \| if &ft == "vim" \| call vim#Short_iT() \| endif' ,
        \ rg   : 'Rg'                                   ,
        \ h    : '-tab help'    ,
        "\ \ h    : 'set hf=~/PL/help_me/doc/help.txt \| sil! helptags ALL \| -tab help'    ,
    \ }


    for [s_in, s_out] in items(abbr_as_alias_dict)
        call Abbr_like_aliaS(s_in, s_out)
    endfor
            " 没啥用, 参考它 define command
                    " command! WritE :silent update
                    "     cnorea wr <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'WritE' : 'w')<CR>


    let abbr_path_dict = #{
                        \ jt   : '~/.local/share/nvim/PL/TeX',
                        \ zp   : '~/.local/share/nvim/PL',
                        \ zm   : '~/Man ',
                        \ zt   : '~/d/tT/wf_tex',
                        \ zn   : '~/dotF/cfg/nvim',
                        \ zo   : '~/dotF',
                        \ za   : '~/d/final/arxivs',
                        \ zr   : $VIMRUNTIME,
                        \}
                        " \ zm   : '~/dotF/',
                        " "\ m: modify very often, 和alt+m对应
                            "

    for [s_in, s_out] in items(abbr_path_dict)
       " exe 'cnorea <expr>'   s_in   '<c-r>=
       exe 'cnorea '   s_in   '<c-r>=
                                  \(getcmdtype() == ":"
                                  \ ?  (  getcmdpos() == 1
                                           \ ? ''cd ' . s_out . '''
                                           \ : ''' . s_out . '''
                                        \)
                                  \ : ''' . s_in . '''
                                  \)<cr>'
   endfor

    " 失败:
        " 可能是因为单引号套单引号 导致的
        " 这个版本: /XXX 会 expand
            " for [s_in, s_out] in items(abbr_path_dict)
            "     exe ' cnorea'  s_in
            "             \ '<c-r>=
            "             \(getcmdtype() == ":" && getcmdpos()==1 ? ''cd' s_out.. ''' : '''..s_out..''')<CR>'
            " endfor

        " cmdline的getcmdtype()等函数不好处理
            " func! g:Cmd_abbr_patH(_in, _out)
            "     "封装成了global函数,  让no_vscode.vim和has_vscode.vim都能用
            "     if getcmdtype() == ":"
            "         if getcmdpos()==1
            "             return  'cd'..a:_out
            "         el
            "             return  a:_out
            "         en
            "     el
            "         return a:_in
            "     en
            " endf
            "
            " for [s_in, s_out] in items(abbr_path_dict)
            "     exe 'cnorea <expr>'   s_in   '\<c-\>eCmd_abbr_patH(s_in, s_out)<cr>'
            " endfor


" files/ buffers
    " 用法  ¿ :E  **/*.py         */*.txt¿
                " 任意级子目录   一级子目录
    com!     -complete=file -nargs=*
                        \   E
                        \   call EdiT(<f-args>)
    fun! EdiT(...)
        for f_ in a:000
            echom            f_
            exe "argedit " . f_
          endfor
        endf



        " " let t = tabpagenr()
        " let _id = 0
        " for f_ in a:000
        "     " for g in glob(f_, 0, 1)
        "         echom            f_
        "         exe "argedit " . f_
        "         " exe "edit " . fnameescape(g)
        "         let _id = _id + 1
        "     endfor
        " endfor
        " " if _id
        " "     exe "tabn " . (t + 1)
        " " en
