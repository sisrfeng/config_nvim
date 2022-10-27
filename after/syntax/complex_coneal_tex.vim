" Original file is https://github.com/wjakob/wjakob.vim/blob/master/after/syntax/tex.vim


" readme.md:
    " ### For [vimtex](https://github.com/lervag/vimtex) user
    "
    " [vimtex](https://github.com/lervag/vimtex) started using its own conceal feature from v2.
    " Those changes break this plugin for now.
    " So you should choose vimtex v2 or the latest version v1.6 that tex-conceal works.
    "
    " ```vim
    " Plug 'lervag/vimtex', {'tag': 'v1.6'}
    " ```
    "
    " ## Options
    "
    " ### Super/sub-scrips
    "
    "
    " To avoid having inscrutable 费解的  utf-8 glyphs appear,
    " set `g:Super_scripts` and `g:sub_scripts`:
    " ```vim
    "     let g:Super_scripts= "[0-9a-zA-W.,:;+-<>/()=]"
    "     let g:sub_scripts= "[0-9aehijklmnoprstuvx,+-/().]"
    " ```
    "
    " See `:h tex-conceal` in more detail.
    "
    " ### Fraction
    "
    " To conceal fraction (½⅓⅔¼⅕⅖⅗⅘⅙⅚⅛⅜⅝⅞)
    "     let g:tex_conceal_frac =1
    "
    " ## Recommended settings
    "
    "
    " ```vim
    " set conceallevel=2
    " let g:tex_conceal="abdgm"
    " ```
    " ```

"\ x: teX compleX

" not defined in vim/runtime/syntax/tex.vim
    syn match xMathSymbol '\\langle\>\s*' contained conceal cchar=⟨
    syn match xMathSymbol '\s*\\rangle\>' contained conceal cchar=⟩
    syn match xMathSymbol '\\\\' contained conceal cchar= ""
    syn match xTabularChar  "&"   conceal

" logical symbols
    syn match xMathSymbol '\\lor\>' contained conceal cchar=∨
    syn match xMathSymbol '\\land\>' contained conceal cchar=∧
    syn match xMathSymbol '\\lnot\>' contained conceal cchar=¬
    syn match xMathSymbol '\\implies\>' contained conceal cchar=⇒
    syn match xMathSymbol '\\geqslant\>' contained conceal cchar=⩾
    syn match xMathSymbol '\\leqslant\>' contained conceal cchar=⩽

" \mathbb characters
    syn match xMathSymbol '\\mathbb{\s*A\s*}' contained conceal cchar=𝔸
    syn match xMathSymbol '\\mathbb{\s*B\s*}' contained conceal cchar=𝔹
    syn match xMathSymbol '\\mathbb{\s*C\s*}' contained conceal cchar=ℂ
    syn match xMathSymbol '\\mathbb{\s*D\s*}' contained conceal cchar=𝔻
    syn match xMathSymbol '\\mathbb{\s*E\s*}' contained conceal cchar=𝔼
    syn match xMathSymbol '\\mathbb{\s*F\s*}' contained conceal cchar=𝔽
    syn match xMathSymbol '\\mathbb{\s*G\s*}' contained conceal cchar=𝔾
    syn match xMathSymbol '\\mathbb{\s*H\s*}' contained conceal cchar=ℍ
    syn match xMathSymbol '\\mathbb{\s*I\s*}' contained conceal cchar=𝕀
    syn match xMathSymbol '\\mathbb{\s*J\s*}' contained conceal cchar=𝕁
    syn match xMathSymbol '\\mathbb{\s*K\s*}' contained conceal cchar=𝕂
    syn match xMathSymbol '\\mathbb{\s*L\s*}' contained conceal cchar=𝕃
    syn match xMathSymbol '\\mathbb{\s*M\s*}' contained conceal cchar=𝕄
    syn match xMathSymbol '\\mathbb{\s*N\s*}' contained conceal cchar=ℕ
    syn match xMathSymbol '\\mathbb{\s*O\s*}' contained conceal cchar=𝕆
    syn match xMathSymbol '\\mathbb{\s*P\s*}' contained conceal cchar=ℙ
    syn match xMathSymbol '\\mathbb{\s*Q\s*}' contained conceal cchar=ℚ
    syn match xMathSymbol '\\mathbb{\s*R\s*}' contained conceal cchar=ℝ
    syn match xMathSymbol '\\mathbb{\s*S\s*}' contained conceal cchar=𝕊
    syn match xMathSymbol '\\mathbb{\s*T\s*}' contained conceal cchar=𝕋
    syn match xMathSymbol '\\mathbb{\s*U\s*}' contained conceal cchar=𝕌
    syn match xMathSymbol '\\mathbb{\s*V\s*}' contained conceal cchar=𝕍
    syn match xMathSymbol '\\mathbb{\s*W\s*}' contained conceal cchar=𝕎
    syn match xMathSymbol '\\mathbb{\s*X\s*}' contained conceal cchar=𝕏
    syn match xMathSymbol '\\mathbb{\s*Y\s*}' contained conceal cchar=𝕐
    syn match xMathSymbol '\\mathbb{\s*Z\s*}' contained conceal cchar=ℤ

" \mathsf characters
    syn match xMathSymbol '\\mathsf{\s*a\s*}' contained conceal cchar=𝖺
    syn match xMathSymbol '\\mathsf{\s*b\s*}' contained conceal cchar=𝖻
    syn match xMathSymbol '\\mathsf{\s*c\s*}' contained conceal cchar=𝖼
    syn match xMathSymbol '\\mathsf{\s*d\s*}' contained conceal cchar=𝖽
    syn match xMathSymbol '\\mathsf{\s*e\s*}' contained conceal cchar=𝖾
    syn match xMathSymbol '\\mathsf{\s*f\s*}' contained conceal cchar=𝖿
    syn match xMathSymbol '\\mathsf{\s*g\s*}' contained conceal cchar=𝗀
    syn match xMathSymbol '\\mathsf{\s*h\s*}' contained conceal cchar=𝗁
    syn match xMathSymbol '\\mathsf{\s*i\s*}' contained conceal cchar=𝗂
    syn match xMathSymbol '\\mathsf{\s*j\s*}' contained conceal cchar=𝗃
    syn match xMathSymbol '\\mathsf{\s*k\s*}' contained conceal cchar=𝗄
    syn match xMathSymbol '\\mathsf{\s*l\s*}' contained conceal cchar=𝗅
    syn match xMathSymbol '\\mathsf{\s*m\s*}' contained conceal cchar=𝗆
    syn match xMathSymbol '\\mathsf{\s*n\s*}' contained conceal cchar=𝗇
    syn match xMathSymbol '\\mathsf{\s*o\s*}' contained conceal cchar=𝗈
    syn match xMathSymbol '\\mathsf{\s*p\s*}' contained conceal cchar=𝗉
    syn match xMathSymbol '\\mathsf{\s*q\s*}' contained conceal cchar=𝗊
    syn match xMathSymbol '\\mathsf{\s*r\s*}' contained conceal cchar=𝗋
    syn match xMathSymbol '\\mathsf{\s*s\s*}' contained conceal cchar=𝗌
    syn match xMathSymbol '\\mathsf{\s*t\s*}' contained conceal cchar=𝗍
    syn match xMathSymbol '\\mathsf{\s*u\s*}' contained conceal cchar=𝗎
    syn match xMathSymbol '\\mathsf{\s*v\s*}' contained conceal cchar=𝗏
    syn match xMathSymbol '\\mathsf{\s*w\s*}' contained conceal cchar=𝗐
    syn match xMathSymbol '\\mathsf{\s*x\s*}' contained conceal cchar=𝗑
    syn match xMathSymbol '\\mathsf{\s*y\s*}' contained conceal cchar=𝗒
    syn match xMathSymbol '\\mathsf{\s*z\s*}' contained conceal cchar=𝗓
    syn match xMathSymbol '\\mathsf{\s*A\s*}' contained conceal cchar=𝖠
    syn match xMathSymbol '\\mathsf{\s*B\s*}' contained conceal cchar=𝖡
    syn match xMathSymbol '\\mathsf{\s*C\s*}' contained conceal cchar=𝖢
    syn match xMathSymbol '\\mathsf{\s*D\s*}' contained conceal cchar=𝖣
    syn match xMathSymbol '\\mathsf{\s*E\s*}' contained conceal cchar=𝖤
    syn match xMathSymbol '\\mathsf{\s*F\s*}' contained conceal cchar=𝖥
    syn match xMathSymbol '\\mathsf{\s*G\s*}' contained conceal cchar=𝖦
    syn match xMathSymbol '\\mathsf{\s*H\s*}' contained conceal cchar=𝖧
    syn match xMathSymbol '\\mathsf{\s*I\s*}' contained conceal cchar=𝖨
    syn match xMathSymbol '\\mathsf{\s*J\s*}' contained conceal cchar=𝖩
    syn match xMathSymbol '\\mathsf{\s*K\s*}' contained conceal cchar=𝖪
    syn match xMathSymbol '\\mathsf{\s*L\s*}' contained conceal cchar=𝖫
    syn match xMathSymbol '\\mathsf{\s*M\s*}' contained conceal cchar=𝖬
    syn match xMathSymbol '\\mathsf{\s*N\s*}' contained conceal cchar=𝖭
    syn match xMathSymbol '\\mathsf{\s*O\s*}' contained conceal cchar=𝖮
    syn match xMathSymbol '\\mathsf{\s*P\s*}' contained conceal cchar=𝖯
    syn match xMathSymbol '\\mathsf{\s*Q\s*}' contained conceal cchar=𝖰
    syn match xMathSymbol '\\mathsf{\s*R\s*}' contained conceal cchar=𝖱
    syn match xMathSymbol '\\mathsf{\s*S\s*}' contained conceal cchar=𝖲
    syn match xMathSymbol '\\mathsf{\s*T\s*}' contained conceal cchar=𝖳
    syn match xMathSymbol '\\mathsf{\s*U\s*}' contained conceal cchar=𝖴
    syn match xMathSymbol '\\mathsf{\s*V\s*}' contained conceal cchar=𝖵
    syn match xMathSymbol '\\mathsf{\s*W\s*}' contained conceal cchar=𝖶
    syn match xMathSymbol '\\mathsf{\s*X\s*}' contained conceal cchar=𝖷
    syn match xMathSymbol '\\mathsf{\s*Y\s*}' contained conceal cchar=𝖸
    syn match xMathSymbol '\\mathsf{\s*Z\s*}' contained conceal cchar=𝖹

" \mathfrak characters
    syn match xMathSymbol '\\mathfrak{\s*a\s*}' contained conceal cchar=𝔞
    syn match xMathSymbol '\\mathfrak{\s*b\s*}' contained conceal cchar=𝔟
    syn match xMathSymbol '\\mathfrak{\s*c\s*}' contained conceal cchar=𝔠
    syn match xMathSymbol '\\mathfrak{\s*d\s*}' contained conceal cchar=𝔡
    syn match xMathSymbol '\\mathfrak{\s*e\s*}' contained conceal cchar=𝔢
    syn match xMathSymbol '\\mathfrak{\s*f\s*}' contained conceal cchar=𝔣
    syn match xMathSymbol '\\mathfrak{\s*g\s*}' contained conceal cchar=𝔤
    syn match xMathSymbol '\\mathfrak{\s*h\s*}' contained conceal cchar=𝔥
    syn match xMathSymbol '\\mathfrak{\s*i\s*}' contained conceal cchar=𝔦
    syn match xMathSymbol '\\mathfrak{\s*j\s*}' contained conceal cchar=𝔧
    syn match xMathSymbol '\\mathfrak{\s*k\s*}' contained conceal cchar=𝔨
    syn match xMathSymbol '\\mathfrak{\s*l\s*}' contained conceal cchar=𝔩
    syn match xMathSymbol '\\mathfrak{\s*m\s*}' contained conceal cchar=𝔪
    syn match xMathSymbol '\\mathfrak{\s*n\s*}' contained conceal cchar=𝔫
    syn match xMathSymbol '\\mathfrak{\s*o\s*}' contained conceal cchar=𝔬
    syn match xMathSymbol '\\mathfrak{\s*p\s*}' contained conceal cchar=𝔭
    syn match xMathSymbol '\\mathfrak{\s*q\s*}' contained conceal cchar=𝔮
    syn match xMathSymbol '\\mathfrak{\s*r\s*}' contained conceal cchar=𝔯
    syn match xMathSymbol '\\mathfrak{\s*s\s*}' contained conceal cchar=𝔰
    syn match xMathSymbol '\\mathfrak{\s*t\s*}' contained conceal cchar=𝔱
    syn match xMathSymbol '\\mathfrak{\s*u\s*}' contained conceal cchar=𝔲
    syn match xMathSymbol '\\mathfrak{\s*v\s*}' contained conceal cchar=𝔳
    syn match xMathSymbol '\\mathfrak{\s*w\s*}' contained conceal cchar=𝔴
    syn match xMathSymbol '\\mathfrak{\s*x\s*}' contained conceal cchar=𝔵
    syn match xMathSymbol '\\mathfrak{\s*y\s*}' contained conceal cchar=𝔶
    syn match xMathSymbol '\\mathfrak{\s*z\s*}' contained conceal cchar=𝔷
    syn match xMathSymbol '\\mathfrak{\s*A\s*}' contained conceal cchar=𝔄
    syn match xMathSymbol '\\mathfrak{\s*B\s*}' contained conceal cchar=𝔅
    syn match xMathSymbol '\\mathfrak{\s*C\s*}' contained conceal cchar=ℭ
    syn match xMathSymbol '\\mathfrak{\s*D\s*}' contained conceal cchar=𝔇
    syn match xMathSymbol '\\mathfrak{\s*E\s*}' contained conceal cchar=𝔈
    syn match xMathSymbol '\\mathfrak{\s*F\s*}' contained conceal cchar=𝔉
    syn match xMathSymbol '\\mathfrak{\s*G\s*}' contained conceal cchar=𝔊
    syn match xMathSymbol '\\mathfrak{\s*H\s*}' contained conceal cchar=ℌ
    syn match xMathSymbol '\\mathfrak{\s*I\s*}' contained conceal cchar=ℑ
    syn match xMathSymbol '\\mathfrak{\s*J\s*}' contained conceal cchar=𝔍
    syn match xMathSymbol '\\mathfrak{\s*K\s*}' contained conceal cchar=𝔎
    syn match xMathSymbol '\\mathfrak{\s*L\s*}' contained conceal cchar=𝔏
    syn match xMathSymbol '\\mathfrak{\s*M\s*}' contained conceal cchar=𝔐
    syn match xMathSymbol '\\mathfrak{\s*N\s*}' contained conceal cchar=𝔑
    syn match xMathSymbol '\\mathfrak{\s*O\s*}' contained conceal cchar=𝔒
    syn match xMathSymbol '\\mathfrak{\s*P\s*}' contained conceal cchar=𝔓
    syn match xMathSymbol '\\mathfrak{\s*Q\s*}' contained conceal cchar=𝔔
    syn match xMathSymbol '\\mathfrak{\s*R\s*}' contained conceal cchar=ℜ
    syn match xMathSymbol '\\mathfrak{\s*S\s*}' contained conceal cchar=𝔖
    syn match xMathSymbol '\\mathfrak{\s*T\s*}' contained conceal cchar=𝔗
    syn match xMathSymbol '\\mathfrak{\s*U\s*}' contained conceal cchar=𝔘
    syn match xMathSymbol '\\mathfrak{\s*V\s*}' contained conceal cchar=𝔙
    syn match xMathSymbol '\\mathfrak{\s*W\s*}' contained conceal cchar=𝔚
    syn match xMathSymbol '\\mathfrak{\s*X\s*}' contained conceal cchar=𝔛
    syn match xMathSymbol '\\mathfrak{\s*Y\s*}' contained conceal cchar=𝔜
    syn match xMathSymbol '\\mathfrak{\s*Z\s*}' contained conceal cchar=ℨ

" \mathcal characters
    syn match xMathSymbol '\\math\%(scr\|cal\){\s*A\s*}' contained conceal cchar=𝓐
    syn match xMathSymbol '\\math\%(scr\|cal\){\s*B\s*}' contained conceal cchar=𝓑
    syn match xMathSymbol '\\math\%(scr\|cal\){\s*C\s*}' contained conceal cchar=𝓒
    syn match xMathSymbol '\\math\%(scr\|cal\){\s*D\s*}' contained conceal cchar=𝓓
    syn match xMathSymbol '\\math\%(scr\|cal\){\s*E\s*}' contained conceal cchar=𝓔
    syn match xMathSymbol '\\math\%(scr\|cal\){\s*F\s*}' contained conceal cchar=𝓕
    syn match xMathSymbol '\\math\%(scr\|cal\){\s*G\s*}' contained conceal cchar=𝓖
    syn match xMathSymbol '\\math\%(scr\|cal\){\s*H\s*}' contained conceal cchar=𝓗
    syn match xMathSymbol '\\math\%(scr\|cal\){\s*I\s*}' contained conceal cchar=𝓘
    syn match xMathSymbol '\\math\%(scr\|cal\){\s*J\s*}' contained conceal cchar=𝓙
    syn match xMathSymbol '\\math\%(scr\|cal\){\s*K\s*}' contained conceal cchar=𝓚
    syn match xMathSymbol '\\math\%(scr\|cal\){\s*L\s*}' contained conceal cchar=𝓛
    syn match xMathSymbol '\\math\%(scr\|cal\){\s*M\s*}' contained conceal cchar=𝓜
    syn match xMathSymbol '\\math\%(scr\|cal\){\s*N\s*}' contained conceal cchar=𝓝
    syn match xMathSymbol '\\math\%(scr\|cal\){\s*O\s*}' contained conceal cchar=𝓞
    syn match xMathSymbol '\\math\%(scr\|cal\){\s*P\s*}' contained conceal cchar=𝓟
    syn match xMathSymbol '\\math\%(scr\|cal\){\s*Q\s*}' contained conceal cchar=𝓠
    syn match xMathSymbol '\\math\%(scr\|cal\){\s*R\s*}' contained conceal cchar=𝓡
    syn match xMathSymbol '\\math\%(scr\|cal\){\s*S\s*}' contained conceal cchar=𝓢
    syn match xMathSymbol '\\math\%(scr\|cal\){\s*T\s*}' contained conceal cchar=𝓣
    syn match xMathSymbol '\\math\%(scr\|cal\){\s*U\s*}' contained conceal cchar=𝓤
    syn match xMathSymbol '\\math\%(scr\|cal\){\s*V\s*}' contained conceal cchar=𝓥
    syn match xMathSymbol '\\math\%(scr\|cal\){\s*W\s*}' contained conceal cchar=𝓦
    syn match xMathSymbol '\\math\%(scr\|cal\){\s*X\s*}' contained conceal cchar=𝓧
    syn match xMathSymbol '\\math\%(scr\|cal\){\s*Y\s*}' contained conceal cchar=𝓨
    syn match xMathSymbol '\\math\%(scr\|cal\){\s*Z\s*}' contained conceal cchar=𝓩

    syn match xSpecialChar '\\#' contained conceal cchar=#

    syn match xStatement '``' contained conceal cchar=“
    syn match xStatement '\'\'' contained conceal cchar=”
    syn match xStatement '\\item\>' contained conceal cchar=•
    syn match xStatement '\\ldots' contained conceal cchar=…
    syn match xStatement '\\quad' contained conceal cchar=                 " space
    syn match xStatement '\\qquad' contained conceal cchar=                " space
    "syn match xStatement '\\\[' contained conceal cchar=⟦
    "syn match xStatement '\\\]' contained conceal cchar=⟧
    syn match xDelimiter '\\{' contained conceal cchar={
    syn match xDelimiter '\\}' contained conceal cchar=}
    syn match xMathSymbol '\\setminus\>' contained conceal cchar=\
    syn match xMathSymbol '\\coloneqq\>' contained conceal cchar=≔
    syn match xMathSymbol '\\colon\>' contained conceal cchar=:
    syn match xMathSymbol '\\:' contained conceal cchar=              " space
    syn match xMathSymbol '\\;' contained conceal cchar=              " space
    syn match xMathSymbol '\\,' contained conceal cchar=              " space
    syn match xMathSymbol '\\ ' contained conceal cchar=              " space
    syn match xMathSymbol '\\quad' contained conceal cchar=           " space
    syn match xMathSymbol '\\qquad' contained conceal cchar=          " space
    syn match xMathSymbol '\\sqrt' contained conceal cchar=√
    syn match xMathSymbol '\\sqrt\[3]' contained conceal cchar=∛
    syn match xMathSymbol '\\sqrt\[4]' contained conceal cchar=∜
    syn match xMathSymbol '\\\!' contained conceal
    syn match xMathSymbol '\\therefore' contained conceal cchar=∴
    syn match xMathSymbol '\\because' contained conceal cchar=∵

"\ if g:tex_conceal_frac == 1
if 1
    syn match xMathSymbol '\\\(\(d\|t\)\|\)frac\(1\|{1}\)\(2\|{2}\)' contained conceal cchar=½
    syn match xMathSymbol '\\\(\(d\|t\)\|\)frac\(1\|{1}\)\(3\|{3}\)' contained conceal cchar=⅓
    syn match xMathSymbol '\\\(\(d\|t\)\|\)frac\(2\|{2}\)\(3\|{3}\)' contained conceal cchar=⅔
    syn match xMathSymbol '\\\(\(d\|t\)\|\)frac\(1\|{1}\)\(4\|{4}\)' contained conceal cchar=¼
    syn match xMathSymbol '\\\(\(d\|t\)\|\)frac\(1\|{1}\)\(5\|{5}\)' contained conceal cchar=⅕
    syn match xMathSymbol '\\\(\(d\|t\)\|\)frac\(2\|{2}\)\(5\|{5}\)' contained conceal cchar=⅖
    syn match xMathSymbol '\\\(\(d\|t\)\|\)frac\(3\|{3}\)\(5\|{5}\)' contained conceal cchar=⅗
    syn match xMathSymbol '\\\(\(d\|t\)\|\)frac\(4\|{4}\)\(5\|{5}\)' contained conceal cchar=⅘
    syn match xMathSymbol '\\\(\(d\|t\)\|\)frac\(1\|{1}\)\(6\|{6}\)' contained conceal cchar=⅙
    syn match xMathSymbol '\\\(\(d\|t\)\|\)frac\(5\|{5}\)\(6\|{6}\)' contained conceal cchar=⅚
    syn match xMathSymbol '\\\(\(d\|t\)\|\)frac\(1\|{1}\)\(8\|{8}\)' contained conceal cchar=⅛
    syn match xMathSymbol '\\\(\(d\|t\)\|\)frac\(3\|{3}\)\(8\|{8}\)' contained conceal cchar=⅜
    syn match xMathSymbol '\\\(\(d\|t\)\|\)frac\(5\|{5}\)\(8\|{8}\)' contained conceal cchar=⅝
    "\ syn match xMathSymbol '\\\(\(d\|t\)\|\)frac\(7\|{7}\)\(8\|{8}\)' contained conceal cchar=⅞
    syn match xMathSymbol '\v\\[dt]?frac\s*%(7|\{7})\s*%(8|\{8})' contained conceal cchar=⅞
end

" hide \text delimiter etc inside math mode
    syn region xMathText
        \ start='\v\\%(%(inter)?mathrm)\s*\{'
        \ end='}'
        \ matchgroup=texStatement
        \ concealends
        \ keepend
        \ contains=@texFoldGroup
        \ containedin=texMathMatcher

    syn region xMathText
        \ matchgroup=texStatement
        \ start='\v\\%(%(inter)=text|mbox)\s*\{'
        \ end='}'
        \ concealends
        \ keepend
        \ contains=@texFoldGroup,@Spell
        \ containedin=texMathMatcher

syn region xBoldMathText
    \ matchgroup=texStatement
    \ start='\v\\%(mathbf|bm|symbf|pmb)\{'
    \ end='}'
    \ concealends
    \ contains=@texMathZoneGroup
    \ containedin=texMathMatcher

syn cluster xMathZoneGroup add=texBoldMathText

syn region xBoldItalStyle
    \ matchgroup=texTypeStyle
    \ start="\\emph\s*{"
    \ end="}"
    \ concealends
    \ contains=@texItalGroup

syn region xItalStyle
    \ matchgroup=texTypeStyle
    \ start="\\emph\s*{"
    \ end="}"
    \ concealends
    \ contains=@texItalGroup

syn region xMatcher
    \ matchgroup=texTypeStyle
    \ start="\v\\%(underline|uline)\{"
    \ end="}"
    \ concealends
    \ contains=@texItalGroup

hi xBoldMathText cterm=bold gui=bold
hi xUnderStyle cterm=underline gui=underline

match xUnderStyle
    \ #\\\%(underline\|uline\){\zs\(.\([^\\]}\)\@<!\)\+\ze}#
    "\ 待确认:\ #\v\\%(underline|uline)\{\zs(.([^\\]})@<!)+\ze#

" set ambiwidth=single

"\ 上下标

    " Simple number super/sub-scripts
        if !exists("g:Super_scripts")
            let s:Super_scripts= '[0-9a-zA-W.,:;+-<>/()=]'
        el
            let s:Super_scripts= g:Super_scripts
        en

        if !exists("g:sub_scripts")
            let s:sub_scripts= "[0-9aeijoruvx,+-/().]"
        el
            let s:sub_scripts= g:sub_scripts
        en

        "\ unicode里 b或某些其他字母 没有作为subscript出现的
        "\ the stance of the Unicode consortium on this is that
            " if you need arbitrary superscript or subscript, then use markup or other higher-level mechanisms.

        "\ You can add small capitals that looks like subscripts:
                "Aᴀʙᴄᴅᴇғɢʜɪᴊᴋʟᴍɴɪᴘǫʀsᴛᴜᴠᴡxʏᴢ
        " there are also some other small letters
        " that look like subscripts (except b, o and q):
                "ₐ𝒸𝒹ₑ𝒻𝓰ₕᵢⱼₖₗₘₙₚᵣₛₜᵤᵥ𝓌ₓᵧ𝓏


        "\ https://stackoverflow.com/questions/17908593/how-to-find-the-unicode-of-the-subscript-alphabet
        "\ Consolidated for cut-and-pasting purposes, the Unicode standard defines complete sub- and super-scripts for numbers and common mathematical symbols ( ⁰ ¹ ² ³ ⁴ ⁵ ⁶ ⁷ ⁸ ⁹ ⁺ ⁻ ⁼ ⁽ ⁾ ₀ ₁ ₂ ₃ ₄ ₅ ₆ ₇ ₈ ₉ ₊ ₋ ₌ ₍ ₎ ),
        " a full superscript Latin lowercase alphabet except q
            " ( ᵃ ᵇ ᶜ ᵈ ᵉ ᶠ ᵍ ʰ ⁱ ʲ ᵏ ˡ ᵐ ⁿ ᵒ ᵖ ʳ ˢ ᵗ ᵘ ᵛ ʷ ˣ ʸ ᶻ ),
            " a limited uppercase Latin alphabet  ( ᴬ ᴮ ᴰ ᴱ ᴳ ᴴ ᴵ ᴶ ᴷ ᴸ ᴹ ᴺ ᴼ ᴾ ᴿ ᵀ ᵁ ⱽ ᵂ ),
            " a few subscripted lowercase letters ( ₐ ₑ ₕ ᵢ ⱼ ₖ ₗ ₘ ₙ ₒ ₚ ᵣ ₛ ₜ ᵤ ᵥ ₓ ),
            " and some Greek letters ( ᵅ ᵝ ᵞ ᵟ ᵋ ᶿ ᶥ ᶲ ᵠ ᵡ ᵦ ᵧ ᵨ ᵩ ᵪ ).
            " Note that since these glyphs come from different ranges,
            " they may not be of the same size and position,
            " depending on the typeface.

    " s:SuperSub:

        fun! s:SuperSub(leader, pat, cchar)
            if a:pat =~# '^\\' ||
            \ (a:leader == '\^' && a:pat =~# s:Super_scripts) ||
            \ (a:leader == '_'  && a:pat =~# s:sub_scripts)
                    exe "syn match xMathSymbol '" . a:leader . '\%(' . a:pat . '\|{\s*' . a:pat . '\s*}\)'
                       \ . "' contained conceal cchar=" . a:cchar
            en
        endfun

        call s:SuperSub('\^','0','⁰')
        call s:SuperSub('\^','1','¹')
        call s:SuperSub('\^','2','²')
        call s:SuperSub('\^','3','³')
        call s:SuperSub('\^','4','⁴')
        call s:SuperSub('\^','5','⁵')
        call s:SuperSub('\^','6','⁶')
        call s:SuperSub('\^','7','⁷')
        call s:SuperSub('\^','8','⁸')
        call s:SuperSub('\^','9','⁹')
        call s:SuperSub('\^','a','ᵃ')
        call s:SuperSub('\^','b','ᵇ')
        call s:SuperSub('\^','c','ᶜ')
        call s:SuperSub('\^','d','ᵈ')
        call s:SuperSub('\^','e','ᵉ')
        call s:SuperSub('\^','f','ᶠ')
        call s:SuperSub('\^','g','ᵍ')
        call s:SuperSub('\^','h','ʰ')
        call s:SuperSub('\^','i','ⁱ')
        call s:SuperSub('\^','j','ʲ')
        call s:SuperSub('\^','k','ᵏ')
        call s:SuperSub('\^','l','ˡ')
        call s:SuperSub('\^','m','ᵐ')
        call s:SuperSub('\^','n','ⁿ')
        call s:SuperSub('\^','o','ᵒ')
        call s:SuperSub('\^','p','ᵖ')
        call s:SuperSub('\^','r','ʳ')
        call s:SuperSub('\^','s','ˢ')
        call s:SuperSub('\^','t','ᵗ')
        call s:SuperSub('\^','u','ᵘ')
        call s:SuperSub('\^','v','ᵛ')
        call s:SuperSub('\^','w','ʷ')
        call s:SuperSub('\^','x','ˣ')
        call s:SuperSub('\^','y','ʸ')
        call s:SuperSub('\^','z','ᶻ')
        call s:SuperSub('\^','A','ᴬ')
        call s:SuperSub('\^','B','ᴮ')
        call s:SuperSub('\^','D','ᴰ')
        call s:SuperSub('\^','E','ᴱ')
        call s:SuperSub('\^','G','ᴳ')
        call s:SuperSub('\^','H','ᴴ')
        call s:SuperSub('\^','I','ᴵ')
        call s:SuperSub('\^','J','ᴶ')
        call s:SuperSub('\^','K','ᴷ')
        call s:SuperSub('\^','L','ᴸ')
        call s:SuperSub('\^','M','ᴹ')
        call s:SuperSub('\^','N','ᴺ')
        call s:SuperSub('\^','O','ᴼ')
        call s:SuperSub('\^','P','ᴾ')
        call s:SuperSub('\^','R','ᴿ')
        call s:SuperSub('\^','T','ᵀ')
        call s:SuperSub('\^','U','ᵁ')
        call s:SuperSub('\^','W','ᵂ')
        call s:SuperSub('\^','+','⁺')
        call s:SuperSub('\^','-','⁻')
        call s:SuperSub('\^','<','˂')
        call s:SuperSub('\^','>','˃')
        call s:SuperSub('\^','/','ˊ')
        call s:SuperSub('\^','(','⁽')
        call s:SuperSub('\^',')','⁾')
        call s:SuperSub('\^','\.','˙')
        call s:SuperSub('\^','=','˭')
        call s:SuperSub('\^','\\alpha','ᵅ')
        call s:SuperSub('\^','\\beta','ᵝ')
        call s:SuperSub('\^','\\gamma','ᵞ')
        call s:SuperSub('\^','\\delta','ᵟ')
        call s:SuperSub('\^','\\epsilon','ᵋ')
        call s:SuperSub('\^','\\theta','ᶿ')
        call s:SuperSub('\^','\\iota','ᶥ')
        call s:SuperSub('\^','\\Phi','ᶲ')
        call s:SuperSub('\^','\\varphi','ᵠ')
        call s:SuperSub('\^','\\chi','ᵡ')

        syn match xMathSymbol '\^\%(\*\|\\ast\|\\star\|{\s*\\\%(ast\|star\)\s*}\)' contained conceal cchar=˟
        syn match xMathSymbol '\^{\s*-1\s*}' contained conceal contains=texSuperscripts
        syn match xMathSymbol '\^\%(\\math\%(rm\|sf\){\s*T\s*}\|{\s*\\math\%(rm\|sf\){\s*T\s*}\s*}\)' contained conceal contains=texSuperscripts
        syn match xMathSymbol '\^\%(\\math\%(rm\|sf\){\s*-T\s*}\|{\s*\\math\%(rm\|sf\){\s*-T\s*}\s*}\|{\s*-\s*\\math\%(rm\|sf\){\s*T\s*}\s*}\)' contained conceal contains=texSuperscripts
        syn match xSuperscripts '1' contained conceal cchar=¹
        syn match xSuperscripts '-' contained conceal cchar=⁻
        syn match xSuperscripts 'T' contained conceal cchar=ᵀ

        call s:SuperSub('_','0','₀')
        call s:SuperSub('_','1','₁')
        call s:SuperSub('_','2','₂')
        call s:SuperSub('_','3','₃')
        call s:SuperSub('_','4','₄')
        call s:SuperSub('_','5','₅')
        call s:SuperSub('_','6','₆')
        call s:SuperSub('_','7','₇')
        call s:SuperSub('_','8','₈')
        call s:SuperSub('_','9','₉')
        call s:SuperSub('_','a','ₐ')
        call s:SuperSub('_','e','ₑ')
        call s:SuperSub('_','h','ₕ')
        call s:SuperSub('_','i','ᵢ')
        call s:SuperSub('_','j','ⱼ')
        call s:SuperSub('_','k','ₖ')
        call s:SuperSub('_','l','ₗ')
        call s:SuperSub('_','m','ₘ')
        call s:SuperSub('_','n','ₙ')
        call s:SuperSub('_','o','ₒ')
        call s:SuperSub('_','p','ₚ')
        call s:SuperSub('_','r','ᵣ')
        call s:SuperSub('_','s','ₛ')
        call s:SuperSub('_','t','ₜ')
        call s:SuperSub('_','u','ᵤ')
        call s:SuperSub('_','v','ᵥ')
        call s:SuperSub('_','x','ₓ')
        call s:SuperSub('_','+','₊')
        call s:SuperSub('_','-','₋')
        call s:SuperSub('_','/','ˏ')
        call s:SuperSub('_','(','₍')
        call s:SuperSub('_',')','₎')
        call s:SuperSub('_','\\beta','ᵦ')
        call s:SuperSub('_','\\rho','ᵨ')
        call s:SuperSub('_','\\phi','ᵩ')
        call s:SuperSub('_','\\gamma','ᵧ')
        call s:SuperSub('_','\\chi','ᵪ')

    " echom '到底部: /home/wf/dotF/cfg/nvim/after/syntax/tex/tex_complex_coneal.vim'
    " 能被source
