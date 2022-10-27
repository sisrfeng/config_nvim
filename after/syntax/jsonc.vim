" Define syntax matching comments and their contents


syn match jsoncCmt_delI '\/\/ '   contained   conceal

hi link jsoncLineComment Comment
syn keyword jsoncCommentTodo  FIXME NOTE TBD TODO XXX
syn region  jsoncLineComment  start=+\/\/+ end=+$+   keepend contains=@Spell,jsoncCommentTodo,jsoncCmt_delI,@In_fancY
syn region  jsoncComment      start='/\*'  end='\*/' fold    contains=@Spell,jsoncCommentTodo,@In_fancY
                                " /*
                                " 多行注释
                                " aaaa
                                " 不要封印/*和*/ 毕竟看着不乱, 封印后反倒容易分不清是注释
                                " */
