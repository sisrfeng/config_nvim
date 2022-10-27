
" Embedded Scripts:
    "   perl,ruby     : Benoit Cerrina
    "   python,tcl    : Johannes Zellner
    "   mzscheme, lua : Charles Campbell

    " Allows users to specify the type of embedded script highlighting  they want:
    " (perl/python/ruby/tcl support)
    "   g:vimsyn_embed == 0   : don't embed any scripts
    "   g:vimsyn_embed =~# 'l' : embed lua
    "   g:vimsyn_embed =~# 'm' : embed mzscheme
    "   g:vimsyn_embed =~# 'p' : embed perl
    "   g:vimsyn_embed =~# 'P' : embed python
    "   g:vimsyn_embed =~# 'r' : embed ruby
    "   g:vimsyn_embed =~# 't' : embed tcl
    if !exists("g:vimsyn_embed")  | let g:vimsyn_embed = 'l'  | en

    " [-- lua --]
        let s:luapath= fnameescape(expand("<sfile>:p:h")."/lua.vim")
        if !filereadable(s:luapath)
            for s:luapath in split(globpath(&rtp,"syntax/lua.vim"),"\n")
                if filereadable(fnameescape(s:luapath))
                    let s:luapath= fnameescape(s:luapath)
                    break
                en
            endfor
        en
        if g:vimsyn_embed =~# 'l' && filereadable(s:luapath)
            unlet! b:current_syntax
            syn cluster vimIn_func_cluS add=vimLuaRegion
            exe "syn include @vimLuaScript ".s:luapath
            VimFoldl syn region vimLuaRegion matchgroup=vimScriptDelim start=+lua\s*<<\s*\z(.*\)$+ end=+^\z1$+  contains=@vimLuaScript
            VimFoldl syn region vimLuaRegion matchgroup=vimScriptDelim start=+lua\s*<<\s*$+ end=+\.$+   contains=@vimLuaScript
            syn cluster vimIn_func_cluS add=vimLuaRegion
        el
            syn region vimEmbedError start=+lua\s*<<\s*\z(.*\)$+ end=+^\z1$+
            syn region vimEmbedError start=+lua\s*<<\s*$+ end=+\.$+
        en
        unlet s:luapath

    " [-- perl --]
        let s:perlpath= fnameescape(expand("<sfile>:p:h")."/perl.vim")
        if !filereadable(s:perlpath)
            for s:perlpath in split(globpath(&rtp,"syntax/perl.vim"),"\n")
                if filereadable(fnameescape(s:perlpath))
                    let s:perlpath= fnameescape(s:perlpath)
                    break
                en
            endfor
        en
        if g:vimsyn_embed =~# 'p' && filereadable(s:perlpath)
            unlet! b:current_syntax
            syn cluster vimIn_func_cluS add=vimPerlRegion
            let s:foldmethod = &l:foldmethod
            exe "syn include @vimPerlScript ".s:perlpath
            let &l:foldmethod = s:foldmethod
            VimFoldp syn region vimPerlRegion  matchgroup=vimScriptDelim start=+pe\%[rl]\s*<<\s*\z(\S*\)\ze\(\s*["#].*\)\=$+ end=+^\z1\ze\(\s*[#"].*\)\=$+  contains=@vimPerlScript
            VimFoldp syn region vimPerlRegion   matchgroup=vimScriptDelim start=+pe\%[rl]\s*<<\s*$+ end=+\.$+           contains=@vimPerlScript
            syn cluster vimIn_func_cluS add=vimPerlRegion
        el
            syn region vimEmbedError start=+pe\%[rl]\s*<<\s*\z(.*\)$+ end=+^\z1$+
            syn region vimEmbedError start=+pe\%[rl]\s*<<\s*$+ end=+\.$+
        en
        unlet s:perlpath

    " [-- ruby --] {{{3
        let s:rubypath= fnameescape(expand("<sfile>:p:h")."/ruby.vim")
        if !filereadable(s:rubypath)
            for s:rubypath in split(globpath(&rtp,"syntax/ruby.vim"),"\n")
                if filereadable(fnameescape(s:rubypath))
                    let s:rubypath= fnameescape(s:rubypath)
                    break
                en
            endfor
        en
        if g:vimsyn_embed =~# 'r' && filereadable(s:rubypath)
            syn cluster vimIn_func_cluS add=vimRubyRegion
            unlet! b:current_syntax
            let s:foldmethod = &l:foldmethod
            exe "syn include @vimRubyScript ".s:rubypath
            let &l:foldmethod = s:foldmethod
            VimFoldr syn region vimRubyRegion   matchgroup=vimScriptDelim start=+rub[y]\s*<<\s*\z(\S*\)\ze\(\s*#.*\)\=$+ end=+^\z1\ze\(\s*".*\)\=$+ contains=@vimRubyScript
            syn region vimRubyRegion    matchgroup=vimScriptDelim start=+rub[y]\s*<<\s*$+ end=+\.$+         contains=@vimRubyScript
            syn cluster vimIn_func_cluS add=vimRubyRegion
        el
            syn region vimEmbedError start=+rub[y]\s*<<\s*\z(.*\)$+ end=+^\z1$+
            syn region vimEmbedError start=+rub[y]\s*<<\s*$+ end=+\.$+
        en
        unlet s:rubypath

    " [-- python --] {{{3
    let s:pythonpath= fnameescape(expand("<sfile>:p:h")."/python.vim")
    if !filereadable(s:pythonpath)
        for s:pythonpath in split(globpath(&rtp,"syntax/python.vim"),"\n")
            if filereadable(fnameescape(s:pythonpath))
                let s:pythonpath= fnameescape(s:pythonpath)
                break
            en
        endfor
    en
    if g:vimsyn_embed =~# 'P' && filereadable(s:pythonpath)
        unlet! b:current_syntax
        syn cluster vimIn_func_cluS add=vimPythonRegion
        exe "syn include @vimPythonScript ".s:pythonpath
        VimFoldP syn region vimPythonRegion matchgroup=vimScriptDelim start=+py\%[thon][3x]\=\s*<<\s*\%(trim\s*\)\=\z(\S*\)\ze\(\s*#.*\)\=$+ end=+^\z1\ze\(\s*".*\)\=$+ contains=@vimPythonScript
        VimFoldP syn region vimPythonRegion matchgroup=vimScriptDelim start=+py\%[thon][3x]\=\s*<<\s*\%(trim\s*\)\=$+ end=+\.$+             contains=@vimPythonScript
        VimFoldP syn region vimPythonRegion matchgroup=vimScriptDelim start=+Py\%[thon]2or3\s*<<\s*\%(trim\s*\)\=\z(\S*\)\ze\(\s*#.*\)\=$+ end=+^\z1\ze\(\s*".*\)\=$+   contains=@vimPythonScript
        VimFoldP syn region vimPythonRegion matchgroup=vimScriptDelim start=+Py\%[thon]2or3\=\s*<<\s*\%(trim\s*\)\=$+ end=+\.$+             contains=@vimPythonScript
        syn cluster vimIn_func_cluS add=vimPythonRegion
    el
        syn region vimEmbedError start=+py\%[thon]3\=\s*<<\s*\z(.*\)$+ end=+^\z1$+
        syn region vimEmbedError start=+py\%[thon]3\=\s*<<\s*$+ end=+\.$+
    en
    unlet s:pythonpath

    " [-- tcl --] {{{3
    if has("win32") || has("win95") || has("win64") || has("win16")
        " apparently has("tcl") has been hanging vim on some windows systems with cygwin
        let s:trytcl= (&shell !~ '\<\%(bash\>\|4[nN][tT]\|\<zsh\)\>\%(\.exe\)\=$')
    el
        let s:trytcl= 1
    en
    if s:trytcl
        let s:tclpath= fnameescape(expand("<sfile>:p:h")."/tcl.vim")
        if !filereadable(s:tclpath)
            for s:tclpath in split(globpath(&rtp,"syntax/tcl.vim"),"\n")
                if filereadable(fnameescape(s:tclpath))
                    let s:tclpath= fnameescape(s:tclpath)
                    break
                en
            endfor
        en
        if g:vimsyn_embed =~# 't' && filereadable(s:tclpath)
            unlet! b:current_syntax
            syn cluster vimIn_func_cluS add=vimTclRegion
            exe "syn include @vimTclScript ".s:tclpath
            VimFoldt syn region vimTclRegion matchgroup=vimScriptDelim start=+tc[l]\=\s*<<\s*\z(.*\)$+ end=+^\z1$+  contains=@vimTclScript
            VimFoldt syn region vimTclRegion matchgroup=vimScriptDelim start=+tc[l]\=\s*<<\s*$+ end=+\.$+   contains=@vimTclScript
            syn cluster vimIn_func_cluS add=vimTclScript
        el
            syn region vimEmbedError start=+tc[l]\=\s*<<\s*\z(.*\)$+ end=+^\z1$+
            syn region vimEmbedError start=+tc[l]\=\s*<<\s*$+ end=+\.$+
        en
        unlet s:tclpath
    el
        syn region vimEmbedError start=+tc[l]\=\s*<<\s*\z(.*\)$+ end=+^\z1$+
        syn region vimEmbedError start=+tc[l]\=\s*<<\s*$+ end=+\.$+
    en
    unlet s:trytcl

    " [-- mzscheme --] {{{3
    let s:mzschemepath= fnameescape(expand("<sfile>:p:h")."/scheme.vim")
    if !filereadable(s:mzschemepath)
        for s:mzschemepath in split(globpath(&rtp,"syntax/mzscheme.vim"),"\n")
            if filereadable(fnameescape(s:mzschemepath))
                let s:mzschemepath= fnameescape(s:mzschemepath)
                break
            en
        endfor
    en
    if g:vimsyn_embed =~# 'm' && filereadable(s:mzschemepath)
        unlet! b:current_syntax
        let s:iskKeep= &isk
        syn cluster vimIn_func_cluS add=vimMzSchemeRegion
        exe "syn include @vimMzSchemeScript ".s:mzschemepath
        let &isk= s:iskKeep
        unlet s:iskKeep
        VimFoldm syn region vimMzSchemeRegion matchgroup=vimScriptDelim start=+mz\%[scheme]\s*<<\s*\z(.*\)$+ end=+^\z1$+    contains=@vimMzSchemeScript
        VimFoldm syn region vimMzSchemeRegion matchgroup=vimScriptDelim start=+mz\%[scheme]\s*<<\s*$+ end=+\.$+     contains=@vimMzSchemeScript
        syn cluster vimIn_func_cluS add=vimMzSchemeRegion
    el
        syn region vimEmbedError start=+mz\%[scheme]\s*<<\s*\z(.*\)$+ end=+^\z1$+
        syn region vimEmbedError start=+mz\%[scheme]\s*<<\s*$+ end=+\.$+
    en
    unlet s:mzschemepath

