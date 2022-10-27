" comE:  complete and Extend

set completeopt=menuone,noinsert
"\ set completeopt+=preview  \ 导致底部弹窗?
    "\ for coc
    "\   'completeopt' is not used and
        "\ APIs of builtin popupmenu not work.




" 参考这个, 光标hover时 show definition?
    " " au! CursorHold *.[ch] ++nested    exe "silent! psearch " . expand("<cword>")

au AG Syntax *   if &omnifunc == ""  | setl  omnifunc=syntaxcomplete#Complete  | endif
ino  <c-o>   <c-x><c-o>

"\ PL 'https://github.com/sisrfeng/omnifunc4text' , { 'do': 'make' }
"\ 很少编辑纯text的filetype, 仅用于omni function?

"\ PL 'https://github.com/sisrfeng/copilot'
    "\     "\ let g:copilot_config_root = expand('~/.copilot_private')
    "\         "\ 把原有的host.json等文件, 挪到上述路径后, copilot无法登陆
    "\         "\ 作者说 别改这个

    "\     " 不用tab来accept
    "\         let g:copilot_no_tab_map = v:true
    "\         imap <silent> <script> <expr>   <c-j> copilot#Accept("\<c-j>")

    "\     let g:copilot_filetypes = {
    "\           \ 'help': v:true,
    "\           \ }

    "\     imap  <C-]>    <Plug>(copilot-dismiss)
    "\     imap  <M-]>    <Plug>(copilot-next)
    "\     imap  <M-[>    <Plug>(copilot-previous)

    "\     imap  <M-.>    <Plug>(copilot-next)
    "\     imap  <M-,>    <Plug>(copilot-previous)




" 很多提示和实践冲突
" ale负责linting, coc负责LSP feature
    " let g:ale_disable_lsp = 1
    " let g:ale_disable     = 1
        " add this line   before ale loaded
          " so ALE doesn't try to provide LSP features already provided by coc.nvim,
          " such as auto-completion.
    " PL 'https://github.com/sisrfeng/ale'
        " let g:ale_sign_column_always = 0

"\ ~/dotF/cfg/coc 链到了  /data2/wf2/leo_tools/coc, 避免search时 内容太多
"\ 代码的 自动补全/auto-complete (微软的智能感应/intellisense)的原理是？ - nvim丝滑py优雅的回答 - 知乎
"\ https://www.zhihu.com/question/19718750/answer/2432232526
PL 'https://github.com/sisrfeng/coc-wiki'
"\ PL 'https://github.com/sisrfeng/lsp' "\    还是忠于coc吧
    "\ https://github.com/neovim/nvim-lspconfig/wiki/Comparison-to-other-LSP-ecosystems-(CoC,-vim-lsp,-etc.)#should-i-use-cocnvim-vim-lsc-vim-lsp-or-neovims-built-in-language-server-client
PL 'https://github.com/sisrfeng/coc',  {'branch': 'release'}

    " 从官方的换到了我的fork版, 有些extension没卸干净 如果有bug 彻底把它卸了再装

    " 它在runtimepath里很靠后:
        " /home/wf/d/leo_tools/coc/extensions/node_modules/coc-snippets,
        "\ /home/wf/d/leo_tools/coc  是~/dotF/cfg/coc 的link
    let g:coc_filetype_map = {'tex': 'latex'}

    au  User       CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

    au  CursorHold *                  silent call CocActionAsync('highlight')
            " Highlight the symbol and its references when holding the cursor.

    " let g:coc_disabled_sources = ['around', 'buffer', 'file']
    let g:coc_disabled_sources = []

    " todo
    " au AG FileType lua let b:coc_suggest_blacklist = ["end"]
        " Disable completion for 'end' in lua files



    "\ 关于json, 仅供查阅:
       "\   'coc-json' 没提供conceal功能, elzr/vim-json有
                " 没有coc-jsonc, 但有这个:
                " PL 'https://github.com/sisrfeng/jsonc'
                "  下面这个不再需要了,并到官方nvim里面了 (装了上述jsonc, 官方的就被覆盖了吧. 二者大同小异)
                    " PL 'https://github.com/kevinoid/vim-jsonc'
                        " 里面有:autocmd   BufNewFile,BufRead   coc-settings.json setl     filetype=jsonc
                        " 一旦reload, coc-settings.json的ft就变回json

                    "不支持jsonc, 但被fork成了上述vim-jsonc
                    " PL 'https://github.com/sisrfeng/json'
                            " 可以conceal双引号, 高亮更好
                            " todo: 支持jsonc



    "\ complete source:
        "\ 'coc-sh', 这个lsp对zsh的支持不好,有个issue没close
        "\ 'coc-git', 暂时用不到
    "\ buggy  debug:
        " 这些node写的插件的readme被我稍微改过, 如果有extension在update时遇到问题,  就改回去
    let g:coc_global_extensions = [
        \ '@yaegassy/coc-pylsp',
        \ 'coc-vimlsp',
        \ 'coc-highlight',
        "\ 装了貌似没变化
        \ 'coc-lua',
        "\ https://github.com/josa42/coc-lua
        \ 'coc-vimtex',
        "\ \ 'coc-ltex',  \ 只在常用机器上装这个 (要手动下载一个东西)
        \
        "\ \ 'coc-pyright',
        \ 'coc-jedi',
            "\ coc-jedi和coc-pyright二选一
            "\ \ https://github.com/neoclide/coc-python ,
              "\ it's recommended to use coc-pyright if you're using python3
              "\ or use coc-jedi if you're using jedi, the code of coc-python is too hard to maintain!
        \
        \ 'coc-snippets',
        \ 'coc-tabnine',
        \ 'coc-diagnostic',
        "\ \ 'coc-translator',
        \ 'coc-yank',
        "\ \ 'coc-emoji',
        \ 'coc-tsserver',
          "\ coc-sources:
            \ 'coc-dictionary',
                    "\ Words from files in &dictionary.
            \ 'coc-tag',
                    "\ Words from tagfiles()
            \ 'coc-word',
                    "\ Words from google 10000 english repo.
            "\ \ 'coc-omni',
            "\ \ 官方不推荐 'coc-omni'
        \]




    " au AG BufEnter
    "     \ *Coc\ List\ Preview*,list:*yank
    "     \ setl stl=%#Hi_status_light#%{bufname()}
          " 貌似被插件覆盖了

        "\ \ nno  <silent><nowait><buffer> <esc> <esc>
        "\ help里说esc不能自定义map

    nno <silent> co  <Cmd>CocList --normal     yank<cr>
                                    " open list on normal mode

        "  coc-yank代替了: https://github.com/bfredl/nvim-miniyank
                        "  https://github.com/svermeulen/vim-yoink
                        " PL 'https://github.com/sisrfeng/yank-history'
                        "     :YankHistoryRgPaste
                                        " 为啥粘贴整个文件?

                                " If you also want to monitor your X11 system clipboard,
                                " you can use the yank-history rust binary.
                                " Just do cargo install yank-history.      " 报错了

        " coc-vimlsp:
            let g:markdown_fenced_languages = [
                  \ 'vim',
                  \ 'help'
                  \]

        " coc-dictionary会接管'dict'的使用, 不需要自己敲ctrl-x ctrl-k?
            set dict+=~/dotF/cfg/nvim/writing/wf_dict.txt
                " for keyword completion commands

        let g:coc_channel_timeout = 30
            "\ Channel timeout in seconds for request to node client.
            "\ Default: 30

        "\ translate
            " coc, 说连不上网
            "\ nmap <Leader>]] <Plug>(coc-translator-e)
            "\ vmap <Leader>]] <Plug>(coc-translator-ev)
            "\     "\ 等popup, 有点慢:
            "\     nmap <Leader>ee <Plug>(coc-translator-p)
            "\     vmap <Leader>ee <Plug>(coc-translator-pv)
            "\
            "\     "\ replace
            "\     nmap <Leader>r <Plug>(coc-translator-r)
            "\     vmap <Leader>r <Plug>(coc-translator-rv)

            " 这个提供了一系列Translate命令
            "\ 356个star
                "\ PL 'https://github.com/sisrfeng/translate-vim'
                "\ let g:translator_proxy_url = 'socks5://' . $WF_ip
                "\
                "\
                "\     " Echo translation in the cmdline
                "\     nmap <silent> <Leader>]] <Plug>Translate
                "\     vmap <silent> <Leader>]] <Plug>TranslateV
                "\
                "\     " Display translation in a window
                "\     nmap <silent> <Leader>]w <Plug>TranslateW
                "\     vmap <silent> <Leader>]w <Plug>TranslateWV
                "\
                "\     " Replace the text with translation
                "\     nmap <silent> <Leader>]r <Plug>TranslateR
                "\     vmap <silent> <Leader>]r <Plug>TranslateRV
                "\
                "\     " Translate the text in clipboard
                "\     nmap <silent> <Leader>]x <Plug>TranslateX
                "\

            "\ 50个star
            "\ 不是async的,经常卡死
            PL 'https://github.com/sisrfeng/trans-shell'
                let g:trans_join_lines = 1
                let g:trans_bin        = '/home/linuxbrew/.linuxbrew/bin'

                PL 'echuraev/translate-shell.vim'
                nnor <silent> <leader>]  <Cmd>Trans<CR>
            "\     " nnor <silent> <leader>]  <Cmd>AsyncRun Trans<CR>
                "\ nnor <silent> <leader>]] <Cmd>!trans<CR>
                nnor <silent> <leader>]] <Cmd>Trans<CR>
                "\ nnor <silent> <leader>]]  yiw:!trans <c-r>"<CR>
            "\ "                         " 只敲一个], 要等time out
                nnor <silent> <leader>]d <Cmd>Trans<CR>
            "\                           " detail
            "\ "     " 可以查多个单词
                vnor <silent> <leader>]  :Trans<CR>
                "         " visual模式按一个]就行
                "         vnor <silent> <leader>]] :Trans<CR>
            "
                let g:trans_advanced_options = "-ipv4"
                "\ let g:trans_advanced_options = "-ipv6"
                let g:trans_default_direction = ":zh-CN+en"
            "
            "\ nnor <silent> <leader>]i   :TransInteractive<CR>

            " 试过能用, 但大多时候报错, 抛弃了:
                " PL 'voldikss/vim-translator'
                "     nmap  gdd <Plug>Translate
                "         " 翻译光标下的文本，在命令行回显
                "     vmap <silent> <Leader>a <Plug>TranslateV
                "     "译光标下的文本，在窗口中显示   h：here
                "     " Leader h被 set hlsearch！占用了
                "     "
                "     let g:translator_target_lang=['youdao']
                "     let g:translator_window_type='preview'


    " " coc-git:  需要再搞:
        " 还是vscdoe好?
        "     " navigate chunks of current buffer
        "         nmap [g <Plug>(coc-git-prevchunk)
        "         nmap ]g <Plug>(coc-git-nextchunk)
        "     " navigate conflicts of current buffer
        "     "        tc: the conflict
        "         nmap [tc <Plug>(coc-git-prevconflict)
        "         nmap ]tc <Plug>(coc-git-nextconflict)
        "     " show chunk diff at current position
        "         nmap gs <Plug>(coc-git-chunkinfo)
        "     " show commit contains current position
        "         nmap g_c <Plug>(coc-git-commit)
        "                                     " 输出很丑, 还是vscode好看
        "     " create text object for git chunks
        "         omap ig <Plug>(coc-git-chunk-inner)
        "         xmap ig <Plug>(coc-git-chunk-inner)
        "
        "         omap ag <Plug>(coc-git-chunk-outer)
        "         xmap ag <Plug>(coc-git-chunk-outer)

                " signcolumn是否显示:  CocCommand git.toggleGutters



    au AG FileType python let b:coc_root_patterns = ['.git', 'pyrightconfig.json']
        " 没有这行 可能导致coc-pyright无法使用  (加了这行, 还是各种问题...pyright还不成熟?)
        " 另外, user's home directory would never considered as workspace folder.

    au AG VimLeavePre *   :call coc#rpc#kill()
                                " coc#rpc#kill will  call kill -9.
                                " it is no harm to do it again:
    au AG VimLeave    *   if get(g:, 'coc_process_pid', 0) | call system('kill -9 -' . g:coc_process_pid) | endif


    " coc-snippets
    " 包含了Ultisnips和snipMate的大部分功能
    " (这2个是engine,   vim-snippets is just a snippet collection)
            " https://github.com/garbas/vim-snipmate
            " 不用装Ultisnips, but you can still do that ,
            " but this extension would not run any code or read configuration from it.

            " snippet搜罗
                " PL 'https://github.com/sisrfeng/snippets-ref'  " PL 'honza/vim-snippets'
                " 挪到了~/d/coolS/snippets-ref

                vmap     <leader>s   <Plug>(coc-convert-snippet)
                vmap     <leader>ss  <Plug>(coc-convert-snippet)
                snore    <c-g>   <C-R>"


                " Make <tab> used for
                                   " trigger  completion,
                            "        completion confirm,
                            "         snippet expand and   jump
                    ino  <silent><expr> <TAB>
                       \ coc#pum#visible()
                           \ ? coc#_select_confirm()
                           \ : coc#expandableOrJumpable()
                               \ ?  "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>"
                               \ :   Check_BS()
                                         \ ? "\<TAB>"
                                         \ :  coc#refresh()

                    fun! Check_BS() abort
                        let col = col('.') - 1
                        return    !col
                        \ || getline('.')[col - 1]  =~# '\s'
                    endf

            " Only works when   (coc-statusline显示snippet在生效时)
            " applied in insert and select mode.
                    let g:coc_snippet_next = '<M-i>'  "  next placeholder
                    let g:coc_snippet_prev = '<M-o>'

                    " g:coc_selectmode_mapping				*g:coc_selectmode_mapping*
                    "     Default: 1
                    "
                "     Add key mappings for making snippet select mode easier.
                    snore    <silent> <BS>    <c-g>c
                    snore    <silent> <DEL>   <c-g>c
                    snore    <silent> <c-h>   <c-g>c
                    snore             <c-r>   <c-g>"_c<c-r>


                    " 暂时用不到?
                    " imap <M-l> <Plug>(coc-snippets-expand)
                    " vmap XXXXX <Plug>(coc-snippets-select)
                        "  select text for visual placeholder of snippet
                        "
                        "
                        "  所有跟coc-snippet有关的说明都在这里

                        " - Snippet expand and additional edit feature of LSP requires
                        "     confirm  completion to work.
                        "       - Snippet complete item would only be expanded after confirm completion. (敲tab?)
                        " *CocSnippetVisual* for highlight snippet placeholders.
                        "     coc#expandable()					*coc#expandable()*
                        "
                        "         Check if a snippet is expandable at the current position.
                        "
                        "     coc#jumpable()						*coc#jumpable()*
                        "
                        "         Check if a snippet is jumpable at the current position.
                        "
                        "     coc#expandableOrJumpable()				*coc#expandableOrJumpable()*
                        "
                        "         Check if a snippet is expandable or jumpable at the current position.
                        "         Requires `coc-snippets` extension installed.
                        "         *suggest.snippetIndicator*
                        "
                        "             The character used in completion item abbreviation to indicate it
                        "             expands as code snippet, default: `"~"`
                        "
                        "         *suggest.snippetsSupport*
                        "             Enable snippets  on ¿confirm completion¿.
                        "             When set to  `false`
                        "                 coc.nvim would set language client option:
                        "                     `CompletionClientCapabilities.completionItem.snippetSupport` to  `false`
                        "
                        "             the language server may still send completion items with snippets when falsy.
                        "         *suggest.removeDuplicateItems*
                        "
                        "             Remove completion items with duplicated word for all sources,
                        "             snippet items are excluded,
                        "             default:
                        "                 `false`
                        "
                        "     Snippet jump key-mappings when snippet is activated:
                        "     |g:coc_snippet_prev| and |g:coc_snippet_next|.

" vim有spellcheck(想到语法检查就想到coc,所以放这里),
" 但很多计算机术语缩写成了误报,  别开
" English Writing
set spell
set spelllang=en_us,en_gb,cjk
                    " great british

    "\ 纠错:


        "\ PL 'https://github.com/sisrfeng/angry-review'  \ 写作时再用
            "\ let g:AngryReviewerEnglish = 'american'
            "\

    "\ latex里误报太多
        PL 'https://github.com/sisrfeng/gramma'
        "\     " https://github.com/rhysd/vim-grammarous
        "\     " 用了LanguageTool as backend

            "\ nno          <Leader>gb      <Plug>(grammarous-disable-category)
            "\                     " grammar blacklisted category
            "\ nno          <Leader>fi      <Plug>(grammarous-fixit)
            "\ nno          <Leader>fn      <Plug>(grammarous-move-to-next-error)


               let g:grammarous#use_vim_spelllang = 0  " 设为1导致用不了
               let g:grammarous#show_first_error = 1

               let g:grammarous#disabled_rules = {
                   \ '*' : ['WHITESPACE_RULE', 'EN_QUOTES'],
                   \ 'help' : ['WHITESPACE_RULE', 'EN_QUOTES', 'SENTENCE_WHITESPACE', 'UPPERCASE_SENTENCE_START'],
               \ }

               let g:grammarous#disabled_categories = {
                           \ '*' : ['PUNCTUATION'],
                           \ 'help' : ['PUNCTUATION', 'TYPOGRAPHY'],
                           \ }



               let g:grammarous#default_comments_only_filetypes = {
                   \ '*' : 1,
                   \ 'help' : 0,
                   \ 'markdown' : 0,
                   \ 'tex' : 0,
                   \ 'latex' : 0,
                  \ }




        "\ PL 'https://github.com/sisrfeng/language_tool'
        "\     " https://github.com/dpelle/vim-LanguageTool
        "\

    "\  写作 / 丰富词汇
        " PL 'https://github.com/sisrfeng/online-alter-words'   " PL 'vim-online-thesaurus' 好慢, 老是查不到
        " PL 'https://github.com/preservim/vim-wordy'

        "\ PL 'https://github.com/sisrfeng/lexical'
            "\     "\ let g:lexical#spellfile = ['',]
            "\     "\ au FileType tex call lexical#init({ 'spell': 0 })
            "\     au AG FileType markdown,mkd call lexical#init()
            "\     au AG FileType tex,latex call lexical#init()
            "\     au AG FileType text call lexical#init({ 'spell': 0 })
            "\
            "\ "
            "\ "     let g:lexical#thesaurus_key = '<leader>T'
            "\ "     let g:lexical#thesaurus = [ '$nV/writing/words2.txt']
            "\ "     " let g:lexical#thesaurus = ['$nV/writing/words1.txt', '$nV/writing/words2.txt']
            "\ "                 " help 'thesaurus'
            "\ "                     " https://www.gutenberg.org/files/3202/files/roget13a.txt
            "\ "                     " https://www.gutenberg.org/files/3202/files/mthesaur.txt
            "\     let g:lexical#dictionary = ['/usr/share/dict/words', '$nV/writing/dict.txt']

        "\ PL 'https://github.com/sisrfeng/dict-skywind'

        "\ __ use it when needed
            "\ PL 'https://github.com/sisrfeng/thesaurus'
            "\     let g:tq_openoffice_en_file = '/home/wf/dotF/cfg/nvim/writing/MyThes-1.0/th_en_US_new'
            "\     let g:tq_map_keys           = 0
            "\     let g:tq_python_version     = 3  " default is 3 or 2?
            "\     "\
            "\     nno      <Leader>e :ThesaurusQueryReplaceCurrentWord<CR>
            "\     vno      <Leader>e "ky:ThesaurusQueryReplace <C-r>k<CR>
            "\     "\
            "\     "\
            "\     let g:tq_enabled_backends = [
            "\         \ "datamuse_com",
            "\         \ "openoffice_en",
            "\         \]
            "\     "\
            "\     "\     " \ "mthesaur_txt",
            "\     "\     " \ "cilin_txt",
            "\     "\
