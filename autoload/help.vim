if exists('g:loaded_help')
    finish
endif

let g:loaded_help = 1

func! help#Help_leo_DIY() abort
    " echom 'Help_leo_DIY开始了'

    let my_poS = getpos('.')
        " The cursor position is restored, but
            " when the number of characters in the indent of the line is changed.
            " the cursor will be in a different  column

        " exec "Reindent 4 4"
            " 先不用了: 有些文件本就缩进过
    " 把代码块变为普通文本
        exec 'silent % sub #' .. ': >$'                .. '#:\r#ge'
        exec 'silent % sub #' .. ' >$'                .. '#\r#ge'
        exec 'silent % sub #' .. '^>$'                  .. '##ge'
        exec 'silent % sub #' .. '^<$'                  .. '##ge'
        exec 'silent % sub #' .. '^<\ze\t\+'            .. '##ge'

        exec 'silent % sub #' .. '\v^\<\ze\s{2,}'       .. '##ge'

    " 处理缩进超过40空格的"标题
        exec 'silent % sub #' .. '\v^\s{40,}\ze\*.+\*$' .. '##ge'
                                        " *包裹的标题栏变为左对齐
        exec 'silent % sub #' .. '\v^\s{40,}\ze^<| \~$' .. '#    #ge'
                                            " ~结尾的column head:  左对齐, 然后缩进4空格
        exec 'silent % sub #' .. '\v\cnote(:| that) \zs\w' .. '#\U\0#ge'
                                                " 先让后面的单词首字母变大写
                                                " 下面删掉note that
        exec 'silent % sub #' .. '\v\cnote(:| that) ' .. '##ge'
        " exec 'silent % sub #' .. '\cnote: \ze\u' .. '##ge'
        " exec 'silent % sub #' .. '\cnote: *\ze(\n|\w)' .. '##ge'


        exec 'silent % sub #' .. '\v\*[#-)!+-~]+\*\zs' .. '\s+' .. '\ze' ..  '\*[#-)!+-~]+\*(\s|$)' .. '#  #ge'
        " exec 'silent % sub #' .. '\v\*[#-)!+-~]+\*\zs' .. '\s+' .. '\ze' ..  '\*[#-)!+-~]+\*(\s|$)' .. '#\r#ge'
            " 同一行里的连续几个tags,  断开成多行,形如:
                    " *cursor-motions*
                    " *navigation*
            " todo:
                " 断开后, 缩进乱了,
                " 和我map后的K不一样,
                " 不知道为啥



        call histdel('search', -11,)
                  " 清掉本函数内的搜索历史
        call setpos('.', my_poS)
endf


fun! help#TOC_all_in_1( )
    let g:Current_Line_nuM = line(".")

    call help#Get_TOC_list()
    call docS#Toc_beautify()
endf

function! help#Get_TOC_list() abort
    let info = getloclist(0, {'winid': 1})
    " if 已经有做好的location list,没必要再制作一次:
    if !empty(info)   &&  getwinvar(info.winid, 'a_buf_namE') ==# bufname('%')
                        " getwinvar例子   :echo "myvar = " . getwinvar(1, 'myvar')
        lopen  " 记作:location list window open
        Decho '进来了!empty info'
        echom '进来了!empty info'
        return
    endif

    " 上面那各分支 没进去过
    " Decho '过了___empty info'
    " echom '过了___empty info'

    let toc_lines = []
    let lNum = 2
      " 和v:lnum无关吧
    let last_line = line('$') - 1
      " 最后一行的行号
    let last_added_lnum = 0
    let has_section = 0
    let has_sub_section = 0

    while lNum && lNum <= last_line
        let level    = 0
        let text     = getline(lNum)
           " 逐行读取
        let add_text = ''

                   "  =和==等
        if     text =~  '\v^\=+$'
        \ &&  lNum + 1 < last_line
            let has_section = 1
            let has_sub_section = 0
            let lNum = nextnonblank(lNum + 1)
                        " 跳过空行
            let add_text =  getline(lNum)
            while add_text =~ '\v\*[^*]+\*\s*$'
                let add_text = matchstr(add_text, '\v.*\ze\*[^*]+\*\s*$')
            endwhile

            " echom 'section heading: ' . text
            "
                      " 匹配标题
        elseif text =~# '\v^[A-Z0-9][-A-ZA-Z0-9 .]' .. '[-A-Z0-9 .():]*' .. '%([ \t]+\*.+\*)?$'
                          " 10. TITLE
            " A line that's yelling(大写) 视作sub_section heading
            " 想让这也算标题: Tittle
            " elseif text =~# '\v^[A-Z0-9]' .. '\s{0,4}' ..  '[-_a-zA-Z0-9 .():]*' .. '%([ \t]+\*.+\*)?$'
                " 但这会导致很多误报
            let has_sub_section = 1
            let level = has_section
            let add_text = matchstr(text, '.\{-}\ze\s*\%([ \t]\+\*.\+\*\)\?$')

        elseif text =~# '\~$'
                    \ && matchstr(text, '^\s*\zs.\{-}\ze\s*\~$') !~# '\t\|\s\{2,}'
                    \ && getline(lNum - 1) =~# '^\s*<\?$\|^\s*\*.*\*$'
                    \ && getline(lNum + 1) =~# '^\s*>\?$\|^\s*\*.*\*$'
            " These lines could be headers or code examples.
            " We only want the  ones that have subsequent lines at the same indent or more.
            let l = nextnonblank(lNum + 1)
            if getline(l) =~# '\*[^*]\+\*$'
                " Ignore tag lines
                let l = nextnonblank(l + 1)
            endif

            if indent(lNum) <= indent(l)
                let level = has_section + has_sub_section
                let add_text = matchstr(text, '\S.*')
            endif
        endif


        if !empty(add_text) &&   last_added_lnum != lNum

            let add_text = substitute(add_text, '\v\s+$', '', 'g')
                                            " 扔掉空格
            let add_text = substitute(add_text, '\v^ *\d+\.\d* ', '', 'g')
            "\ echom "add_text 是: "   add_text
            "\ let add_text = substitute(add_text, '\v^\| *\d+\|行 +\zs\d+\.\d* ', ' ', 'g')
                                            " 仍掉1.  2. 等

            let last_added_lnum = lNum

            " 往toc_lines这个list里加一个dict
            call add(  toc_lines,
                       \{
                       \'bufnr'  : bufnr('%'),
                       \'lnum'   : lNum,
                       \'text'   : '++++'->repeat(level) .. add_text,
                       "\ 单引号里的空格会被清掉,  无法缩进
                       \},
                    \)
                       " \'lnum'   : printf('%5d',lNum), 不行, 一定要传数字

        endif
        let lNum = nextnonblank(lNum + 1)
    endwhile

    " 主体: 设置location list window
        " create 或者修改a new list:
          " setloclist({nr}, {list})
        call setloclist(0, toc_lines, ' ')
                      " 0: current window
        call setloclist(0, [], 'a', {'title': 'TOC'})
                                             " qf.vim限制了, title必须为(正则):  <TOC$

            " call setloclist(0, [], 'a', {'efm': '%f#%l#%m'})
            " efm     errorformat to use when parsing text from  "lines". 其他时候无效?
        lopen
    let w:a_buf_namE = bufname('%')
endf

