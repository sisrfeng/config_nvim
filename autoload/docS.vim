
" help nroff man 等buffer公用
if exists("loaded_docS")
    finish
endif
let loaded_docS = 1


func! docS#Toc_beautify()
    wincmd L
    vertical resize -20

    setl textwidth=40
    set modifiable
    setl concealcursor=n
    "\ setl conceallevel=2
    silent % subs #\*##ge
    silent %retab | set expandtab
    " silent % subs #\*\zs\w\+\ze\*#=submatch(0)#ge
        " 扔掉vim的Toc的星号

    silent % sub #\v^.*\ze\|\d##ge
                " 删掉竖线前的文件名
    silent % sub #\~$##ge
                " 有些section header有行末~
                " 删掉波浪线
    " 删掉fzf的help里的分割线
        silent % sub #\v_{3,}$##ge
        silent % sub #\v-{3,}\+-{3,}$##ge

        silent % sub #\v\+{4}#    #ge
                " 处理这个:
                   " \'text'   : '++++'->repeat(level) .. add_text,


    exec 'normal! ggVGgu'
                    " 全部小写

    " exec 'silent % subs #\.\s*\a#\=toupper(submatch(0))#ge'
    "   "\=toupper(submatch(0)) 等价于它?        \U&#g
    " exec 'silent % subs #\v(^|\s\s*)\a#\=toupper(submatch(0))#ge'
                                    "                           所有单词的首字都大写
    " exec 'silent % subs #\v(^|\s+)\a#\=toupper(submatch(0))#ge'
         " 更多subs的例子
         " : s/^/\=  line(".") .  ". "                 /g
         "       \=后的作为一个expr, 大部分空格是多余的
         "     submatch(0): 匹配到的所有对象

    exec 'silent % subs #\a#\=toupper(submatch(0))#e'
                                          " 不加g,只匹配第一个
                                          " 标题首字母大写
endf

"\ echom '来啦, /home/wf/dotF/cfg/nvim/autoload/docS.vim'
    "\ 没有调用本文件的函数时, 不会跑到这行
