" vim-conceal里的
    " math related
        syn    match pyMath_conceal "<=" conceal cchar=≤
        syn    match pyMath_conceal ">=" conceal cchar=≥

        syn    match pyMath_conceal " \zs/\ze " conceal cchar=÷
        syn    match pyMath_conceal ' \zs\*\ze ' conceal cchar=x
        syn    match pyMath_conceal ' \zs\*\ze= ' conceal cchar=x
        syn    match pyMath_conceal '\v[^-=+*/]\zs\=\ze[^=]' conceal cchar=←
        syn    match pyMath_conceal "\<\%(math\.\)\?sqrt\>" conceal cchar=√
        syn    match pyMath_conceal '!=' conceal cchar=≠

        " syn    match Normal '\v<self>' conceal cchar=𐍃
        " syn    match Normal '\v<self>\.' conceal cchar=⊥
        " syn    match Normal '\v<self>\.' conceal cchar=⥽
        "\ syn    match Self_doT '\v<self>\.' conceal cchar=⥁
        syn    match Self_doT '\v<self>\.' conceal cchar=°
        "\ syn    match Self_doT '\v<self>\.' conceal cchar=♢  double width




        " syn    match pyMath_conceal "\<\%(math\.\)\?prod\>" conceal cchar=∏
        " syn    match pyMath_conceal "\( \|\)\*\*\( \|\)2\>" conceal cchar=²
        " syn    match pyMath_conceal "\( \|\)\*\*\( \|\)3\>" conceal cchar=³
        syn    match pyKeyword "\v<%(math\.|np\.)?pi>" conceal cchar=π


    " keywords
        " syn    keyword pyMath_conceal product conceal cchar=∏
        " syn    keyword pyMath_conceal sum conceal cchar=∑
        " syn    keyword pyStatement lambda conceal cchar=λ

    hi link pyMath_conceal Operator
    hi link pyStatement Statement
    hi link pyKeyword Keyword
    hi! link Conceal Operator


" " https://github.com/alok/python-conceal/blob/master/after/syntax/python.vim
    " " Remove the keywords.
    " " We'll re-add them below. Use silent in case the group  doesn't exist.
    "
    "     silent! syntax clear pythonOperator
    "
    "     " TODO highlight comments correctly
    "     " syntax match pyComment "#" conceal cchar=⍝
    "
    "     " XXX least specific cases at the top,
    "     " since the match rules seem to be  cumulative.
    "
    "
    "     " Include the space after “not” – if present – so that “not a” becomes “¬a”.
    "     " if it is after  “is ”.
    "       " don't hide “not” behind  ‘¬’
    "     " syntax match pyMath_conceal "\%(is \)\@<!\<not\%( \|\>\)" conceal cchar=¬
    "
    "     " Subscripts
    "
    "
    "     " Matches x0 -> x₀ A2 -> A₂ word2 -> word₂
    "         " Use ms=s+1 to avoid concealing the letter before the number
    "         syn    match Normal '\v<[[:alpha:]_]+0>'ms=e conceal cchar=₀
    "         syn    match Normal '\v<[[:alpha:]_]+1>'ms=e conceal cchar=₁
    "         syn    match Normal '\v<[[:alpha:]_]+2>'ms=e conceal cchar=₂
    "         syn    match Normal '\v<[[:alpha:]_]+3>'ms=e conceal cchar=₃
    "         syn    match Normal '\v<[[:alpha:]_]+4>'ms=e conceal cchar=₄
    "         syn    match Normal '\v<[[:alpha:]_]+5>'ms=e conceal cchar=₅
    "         syn    match Normal '\v<[[:alpha:]_]+6>'ms=e conceal cchar=₆
    "         syn    match Normal '\v<[[:alpha:]_]+7>'ms=e conceal cchar=₇
    "         syn    match Normal '\v<[[:alpha:]_]+8>'ms=e conceal cchar=₈
    "         syn    match Normal '\v<[[:alpha:]_]+9>'ms=e conceal cchar=₉
    "
    "     " Numbers
    "         syn    match Normal '\v[^_]\zs_0\ze>' conceal cchar=₀
    "         syn    match Normal '\v[^_]\zs_1\ze>' conceal cchar=₁
    "         syn    match Normal '\v[^_]\zs_2\ze>' conceal cchar=₂
    "         syn    match Normal '\v[^_]\zs_3\ze>' conceal cchar=₃
    "         syn    match Normal '\v[^_]\zs_4\ze>' conceal cchar=₄
    "         syn    match Normal '\v[^_]\zs_5\ze>' conceal cchar=₅
    "         syn    match Normal '\v[^_]\zs_6\ze>' conceal cchar=₆
    "         syn    match Normal '\v[^_]\zs_7\ze>' conceal cchar=₇
    "         syn    match Normal '\v[^_]\zs_8\ze>' conceal cchar=₈
    "         syn    match Normal '\v[^_]\zs_9\ze>' conceal cchar=₉
    "
    "     " Letters
    "         " syn    match Normal '\v[^_]\zs_[aA]\ze>' conceal cchar=ₐ
    "         " syn    match Normal '\v[^_]\zs_[lL]\ze>' conceal cchar=ₗ
    "         " syn    match Normal '\v[^_]\zs_[pP]\ze>' conceal cchar=ₚ
    "         " syn    match Normal '\v[^_]\zs_[rR]\ze>' conceal cchar=ᵣ
    "         " syn    match Normal '\v[^_]\zs_[sS]\ze>' conceal cchar=ₛ
    "         " syn    match Normal '\v[^_]\zs_[uU]\ze>' conceal cchar=ᵤ
    "         " syn    match Normal '\v[^_]\zs_[vV]\ze>' conceal cchar=ᵥ
    "         " syn    match Normal '\v[^_]\zs_[xX]\ze>' conceal cchar=ₓ
    "         " syn    match Normal '\v[^_]\zs_[hH]\ze>' conceal cchar=ₕ
    "         " syn    match Normal '\v[^_]\zs_[iI]\ze>' conceal cchar=ᵢ
    "         " syn    match Normal '\v[^_]\zs_[jJ]\ze>' conceal cchar=ⱼ
    "         " syn    match Normal '\v[^_]\zs_[kK]\ze>' conceal cchar=ₖ
    "         " syn    match Normal '\v[^_]\zs_[nN]\ze>' conceal cchar=ₙ
    "         " syn    match Normal '\v[^_]\zs_[mM]\ze>' conceal cchar=ₘ
    "         " syn    match Normal '\v[^_]\zs_[tT]\ze>' conceal cchar=ₜ
    "
    "     " syntax match Constant '\v<\d+\zs_\ze\d+>' conceal cchar=,
    "         " " Conceal underscores in numeric literals with commas
    "
    "     " Conceal things like a_ -> a'
    "         syn    match Normal '\v[^_]\zs_\ze>' conceal cchar=′
    "         " Underscore by itself is not concealed
    "         syn    match Normal '\v<\zs_\ze>' conceal cchar=_
    "
    "
    "     " Need to be handled specially for `not in` to work. Order doesn't matter.
    "         syn    match Normal '\v<not in>' conceal cchar=∉
    "         syn    match Normal '\v<in>' conceal cchar=∈
    "
    "
    "
    "
    "     syn    match Normal '->' conceal cchar=→
    "     syn    match Normal '<=' conceal cchar=≤
    "     syn    match Normal '>=' conceal cchar=≥
    "
    "     " syn    match Normal '\s@\s'ms=s+1,me=e-1 conceal cchar=⊗
    "     " syn    match Normal '\v(\+|-|*|/|\%)@!\=' conceal cchar=←
    "     " syn    match Normal '\v\=@<!\=\=\=@!' conceal cchar=≝
    "                       " 排除出现在==前面的=
    "                                     " 排除出现在==后的=
                           " only conceal `==` if alone, to avoid concealing merge conflict markers
    "
    "
    "
    "
    "     syn    match Normal '\v<((math|torch|np|tf|scipy|sp)\.)?ceil>' conceal cchar=⌈
    "     syn    match Normal '\v<((math|torch|np|tf|scipy|sp)\.)?floor>' conceal cchar=⌊
    "     syn    match Normal '\v<((torch|np|tf|scipy|sp)\.)?(eye|identity)>' conceal cchar=𝕀
    "
    "     syn    match Normal '\v<((math|np|scipy|sp)\.)e>' conceal cchar=ℯ
    "     syn    match Normal '\v<((math|np|scipy|sp)\.)?inf>' conceal cchar=∞
    "     syn    match Normal "\v<float('inf')>" conceal cchar=∞
    "     syn    match Normal '\v<float("inf")>' conceal cchar=∞
    "
    "     syn    match Normal '\v<((math|torch|np|tf|scipy|sp)\.)?pi>' conceal cchar=π
    "     syn    match Normal '\v<((torch|np|scipy|sp)\.mean)|(tf\.reduce_mean)>' conceal cchar=𝔼
    "
    "     " 2**4
            syn    match Normal '\v\zs ?\*\* ?2\ze>([^.]|$)' conceal cchar=²
            syn    match Normal '\v\zs ?\*\* ?n\ze>([^.]|$)' conceal cchar=ⁿ
            syn    match Normal '\v\zs ?\*\* ?i\ze>([^.]|$)' conceal cchar=ⁱ
            syn    match Normal '\v\zs ?\*\* ?j\ze>([^.]|$)' conceal cchar=ʲ
            syn    match Normal '\v\zs ?\*\* ?k\ze>([^.]|$)' conceal cchar=ᵏ
            syn    match Normal '\v\zs ?\*\* ?t\ze>([^.]|$)' conceal cchar=ᵗ
            syn    match Normal '\v\zs ?\*\* ?x\ze>([^.]|$)' conceal cchar=ˣ
            syn    match Normal '\v\zs ?\*\* ?y\ze>([^.]|$)' conceal cchar=ʸ
            syn    match Normal '\v\zs ?\*\* ?z\ze>([^.]|$)' conceal cchar=ᶻ
            syn    match Normal '\v\zs ?\*\* ?a\ze>([^.]|$)' conceal cchar=ᵃ
            syn    match Normal '\v\zs ?\*\* ?b\ze>([^.]|$)' conceal cchar=ᵇ
            syn    match Normal '\v\zs ?\*\* ?c\ze>([^.]|$)' conceal cchar=ᶜ
            syn    match Normal '\v\zs ?\*\* ?d\ze>([^.]|$)' conceal cchar=ᵈ
            syn    match Normal '\v\zs ?\*\* ?e\ze>([^.]|$)' conceal cchar=ᵉ
            syn    match Normal '\v\zs ?\*\* ?p\ze>([^.]|$)' conceal cchar=ᵖ
            syn    match Normal '\v\zs ?\*\* ?l\ze>([^.]|$)' conceal cchar=ˡ
            syn    match Normal '\v\zs ?\*\* ?m\ze>([^.]|$)' conceal cchar=ᵐ
    "
    "     " no ending word boundary on parens
    "     " 矩阵Transpose?
    "         syn    match Normal '\v\.t\(\)' conceal cchar=ᵀ
    "         syn    match Normal '\v\.T>' conceal cchar=ᵀ
    "         syn    match Normal '\v\.inverse\(\)' conceal cchar=⁻
    "
    "         syn    match Normal '\v\.reshape>'ms=s conceal cchar=♚
    "
    "         syn    match Normal '<<' conceal cchar=≺
    "         syn    match Normal '>>' conceal cchar=≻
    "     " 希腊
    "         syn    keyword Normal alpha ALPHA conceal cchar=α
    "         syn    keyword Normal beta BETA conceal cchar=β
    "         syn    keyword Normal Gamma conceal cchar=Γ
    "         syn    keyword Normal gamma GAMMA conceal cchar=γ
    "         syn    keyword Normal Delta conceal cchar=Δ
    "         syn    keyword Normal delta DELTA conceal cchar=δ
    "         syn    keyword Normal epsilon EPSILON conceal cchar=ε
    "         syn    keyword Normal zeta ZETA conceal cchar=ζ
    "         syn    keyword Normal eta ETA conceal cchar=η
    "         syn    keyword Normal Theta conceal cchar=ϴ
    "         syn    keyword Normal theta THETA conceal cchar=θ
    "         syn    keyword Normal kappa KAPPA conceal cchar=κ
    "         syn    keyword Normal lambda LAMBDA lambda_ _lambda conceal cchar=λ
    "         syn    keyword Normal mu MU conceal cchar=μ
    "         syn    keyword Normal nu NU conceal cchar=ν
    "         syn    keyword Normal Xi conceal cchar=Ξ
    "         syn    keyword Normal xi XI conceal cchar=ξ
    "         syn    keyword Normal Pi conceal cchar=Π
    "         syn    keyword Normal rho RHO conceal cchar=ρ
    "         syn    keyword Normal sigma SIGMA conceal cchar=σ
    "         syn    keyword Normal tau TAU conceal cchar=τ
    "         syn    keyword Normal upsilon UPSILON conceal cchar=υ
    "         syn    keyword Normal Phi conceal cchar=Φ
    "         syn    keyword Normal phi PHI conceal cchar=φ
    "         syn    keyword Normal chi CHI conceal cchar=χ
    "         syn    keyword Normal Psi conceal cchar=Ψ
    "         syn    keyword Normal psi PSI conceal cchar=ψ
    "         syn    keyword Normal Omega conceal cchar=Ω
    "         syn    keyword Normal omega OMEGA conceal cchar=ω
    "         syn    keyword Normal nabla NABLA conceal cchar=∇
    "
    "     " like APL
    "     " Need to use `syntax match` instead of `syntax keyword` or else keyword takes
    "     " priority and `range(len...` isn't matched.
    "     syn    match Normal '\v<range>' conceal cchar=⍳
    "     syn    match Normal '\v<\zsrange\(len\ze\(' conceal cchar=⍳
    "     " syn    keyword Normal enumerate conceal cchar=↑
    "
    "
    "     syn    keyword Constant None conceal cchar=∅
    "     syn    keyword Constant True conceal cchar=✓
    "     syn    keyword Constant False conceal cchar=✗
    "
    "     " http://www.fileformat.info/info/unicode/block/geometric_shapes/images.htm
    "         " syn    keyword Keyword break conceal cchar=◁
    "         syn    keyword Keyword continue conceal cchar=↻
    "         " syn    keyword Keyword return conceal cchar=◀
    "         " syn    keyword Keyword if conceal cchar=▸
    "         " syn    keyword Keyword elif conceal cchar=▹
    "         " syn    keyword Keyword else conceal cchar=▪
    "
    "     syn    keyword Normal for conceal cchar=∀
    "     " syn    keyword Normal while conceal cchar=⥁
    "
    "     " syn    keyword Normal def conceal cchar=λ
    "     syn    keyword Normal class conceal cchar=ℭ
    "     " syntax keyword Keyword assert conceal cchar=‽
    "     syn    match Keyword 'yield from' conceal cchar=⇄
    "     syn    keyword Keyword yield conceal cchar=⇇
    "
    "     syn    keyword Type Vector conceal cchar=V
    "     syn    match Type '(np|scipy|sp)\.ndarray' conceal cchar=V
    "     syn    match Type '\vtf\.Tensor' conceal cchar=𝕋
    "     syn    match Type '\vtorch\.[tT]ensor' conceal cchar=𝕋
    "     syn    keyword Type tensor Tensor conceal cchar=𝕋
    "     syn    match Type '\v(torch|np|tf|scipy|sp)\.float(32|64)?' conceal cchar=ℝ
    "     syn    match Type '\v(torch|np|tf|scipy|sp)\.int(32|64)?' conceal cchar=ℤ
    "
    "     " XXX These have to be after all the float{16,32} stuff to avoid accidental
    "     " capture.
    "     " Use @! to ensure that type casts are not concealed,
    "     " since that's  hard to read._
    "     "
    "     " [^\s)] is to avoid the edge case of (x: int)
    "     " where the right paren would  override the int conceal.
    "     syn    match Type '\v<int(\(|[^\s)\],:])@!' conceal cchar=ℤ
    "     syn    match Type '\v<float(\(|[^\s)\],:])@!' conceal cchar=ℝ
    "     syn    match Type '\v<complex(\(|[^\s)\],:])@!' conceal cchar=ℂ
    "     syn    match Type '\v<str(\(|[^\s)\],:])@!' conceal cchar=𝐒
    "     syn    match Type '\v<bool(\(|[^\s)\],:])@!' conceal cchar=𝔹
    "
    "     " syn    match Normal '\v((np|scipy|sp|torch)\.)?arange' conceal cchar=⍳
    "
    "     syn    keyword Builtin all
    "     syn    keyword Builtin any conceal cchar=∃
    "
    "     hi! link pyBuiltin pyMath_conceal
    "     hi! link pyMath_conceal Operator
    "     hi! link pyStatement Statement
    "     hi! link pyKeyword Keyword
    "     hi! link pyComment Comment
    "     hi! link pyConstant Constant
    "     hi! link pySpecial Special
    "     hi! link pyIdentifier Identifier
    "     hi! link pyType Type
    "
