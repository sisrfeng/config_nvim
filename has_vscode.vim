" cnoremap s/ s/\v
" vscode里，用了cmap时，必须在光标后有字符才能正常map

" some map
    " map <c-c> <c-v>
            " 不生效
            " 直接在vscode里,敲 :map <c-c> 或者<c-v>都不生效, 一直是vim本来的功能
    map j gj
    map k gk
        " set wrap 后，同物理行上线直接跳。
        " 不能noremap
            "  they are not recursively mapped themselves (I don't know why this matters) but
            "  you can still recursively map to them.

        " 不行：
            " nno   gk :<C-u>call VSCodeCall('cursorMove', { 'to': 'up', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>
            " nno   gj :<C-u>call VSCodeCall('cursorMove', { 'to': 'down', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>

    omap <silent> j gj
    omap <silent> k gk

    func! First_Non_comment()
        exe 'normal g0'
            " 还是跳到物理行的 空白开头 ? 现在是跳到非空白开头了，是vscode的设置起效了？
        if Char_at_Cursor()== Char4comment()
            exe 'normal w'
        en
    endf

        map H :call First_Non_comment()<cr>

    " nmap H g$<ESC>wk
    map 0 g0
    map L g$

    " 不好：
        " nmap dd g^dg$i<BS><Esc>
        " nmap yy g^yg$
        " nmap cc g^cg$
    " 不行：
        " nmap A g$a
        " nmap I g^i

    " nmap gm g$
    " nnoremap M

    nno   ss <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
    vno   ss <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
    nno   qq <Cmd>call VSCodeNotify('workbench.action.revertAndCloseActiveEditor')<CR>
        " noremap qq :q!<CR>  vscode里，这样搞只退出插件，文件还打开着

    " todo
        " insert mode下，neovim不管事，（但esc退回normal还是可以的），imap都用不了
        " nnoremap gd vaw<F12>

    " filetype on        " 检测文件类型  不会和vscode 打架吧


    nno   ce A<space><space><Esc>o/<Esc><Esc>:::::call nerdcommenter#Comment("n", "Comment")<space><CR>kJA<BS>
        " 如果该行本就被注释了, 再敲ce, vscode会报错
        " 有时会弄脏代码，可能是vscode-nvim弹出窗口太慢了？它不能接管inputmode？  " 提issue吧
            " vscode里，<C-_>注释，用的是vscode的"editor.action.comment"之类的,不是vim的命令,这样不行：
            " vim外也可以粘贴vim的registry了
            " nnoremap ce A<space><space><Esc>o/<Esc><Esc><Esc><Esc><Esc><Esc><C-_>kJA<BS>


        " vscode-neovim的 VSCodeCommentary is just a simple function which calls editor.action.commentLine.
        " xmap <C-_>  <Plug>VSCodeCommentary
        " nmap <C-_>  <Plug>VSCodeCommentary
        " omap <C-_>  <Plug>VSCodeCommentary
        " nmap <C-_>  <Plug>VSCodeCommentaryLine


" cnoreabbrev
    "   vscode里, 如果用edit而非split,里会把原文件的内容 粘贴到一个新文件
        cnorea <expr> zbk   getcmdtype() == ":" && getcmdline() == 'zbk'          ? 'vsplit ~/dotF/zsh/bindkey_wf.zsh'     :   'zbk'
        cnorea <expr> bd    getcmdtype() == ":" && getcmdline() == 'bd'           ? 'vsplit ~/local.zsh'                  :   'bd'
        cnorea <expr> et    getcmdtype() == ":" && getcmdline() == 'et'           ? 'vsplit ~/d/tmp.py'                :   'et'
        cnorea <expr> tc    getcmdtype() == ":" && getcmdline() == 'tc'           ? 'vsplit ~/dotF/cfg/tmux/tmux.conf' :   'tc'
        cnorea <expr> in    getcmdtype() == ":" && getcmdline() == 'in'           ? 'vsplit ~/dotF/cfg/nvim/init.vim'  :   'in'
        cnorea <expr> s     getcmdtype() == ":" && getcmdline() == 's'            ? 'vsplit ~/dotF/zsh/rc.zsh'             :   's'
        cnorea <expr> al    getcmdtype() == ":" && getcmdline() == 'al'           ? 'vsplit ~/dotF/zsh/alias.zsh'          :   'al'
    "   vscode里也能用, 但会把原文件的内容 粘贴到一个新文件
        " cnorea <expr> cm    getcmdtype() == ":" && getcmdline() == 'cm'           ? 'tab help'                          :   'cm'
        " cnorea <expr> h     getcmdtype() == ":" && getcmdline() == 'h'            ? 'tab help'                          :   'h'


" nnoremap gf :vsplit <cfile><CR>
    " 不行
" nunmap gf


" 不加连字符, peco-find 就不是一个word, viw就被连字符打断
"

" echom 'vscode-nvim里, echo $PATH, 显示wsl的路径, 而非windows系统 (vscode在windows系统)'
" echom 'vscode-neovim有bug, 会报这个暂时没什么影响的错误 : (不是我的init.vim有问题)'
                " emsg: Error detected while processing command line:
                " emsg: E344: Can't find directory "homedtorch_tracknet" in cdpath
                " emsg: E472: Command failed

" 另外:
" vscode用wsl的nvim作为bin时,pwd永远是Microsoft VS Code. (!ls显示的是wsl的文件, 而非远程linux的文件)
" 等邮件通知更新吧. 其实不影响使用?
" 我的笔记: https://github.com/vscode-neovim/vscode-neovim/issues/520#issuecomment-1013853745


if has('win32')
    " echo 'leo: 正在用win32，win32表示 32 or 64 bit的windows'
    let g:python3_host_prog = "F:\\python39\\python.exe"  " ToggleBool会用到
    " let g:python_host_prog = ""  " ToggleBool会用到   我fork了这个插件 并改了?
    " let g:loaded_python_provider = 0
en

"有空再搞
"====https://github.com/ahonn/dotfiles/tree/master/vim/vscode========

    "nnor <silent> <C-j> :<C-u>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>
    "nnor <silent> <C-k> :<C-u>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
    "nnor <silent> <C-h> :<C-u>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
    "nnor <silent> <C-l> :<C-u>call VSCodeNotify('workbench.action.focusRightGroup')<CR>

    "nnor <silent> <C-b> :<C-u>call VSCodeNotify('workbench.action.toggleSidebarVisibility')

    "nnor <silent> <C-w>H :<C-u>call VSCodeNotify('workbench.action.moveEditorToLeftGroup');<CR>
    "nnor <silent> <C-w>L :<C-u>call VSCodeNotify('workbench.action.moveEditorToRightGroup');<CR>

    "nnor <silent> <Leader>f :<C-u>call VSCodeNotify('editor.action.formatDocument')<CR>

