" Vim-specific options 应该被nvim淘汰了
" 但阅读旧的vim插件, 放着吧
    syn keyword vimNotNvim
            \ contained
            \ biosk
            \ bioskey
            \ cp
            \ compatible
            \ consk
            \ conskey
            \ cm
            \ cryptmethod
            \ edcompatible
            \ guipty
            \ key
            \ macatsui
            \ mzq
            \ mzquantum
            \ osfiletype
            \ oft
            \ renderoptions
            \ rop
            \ st
            \ shelltype
            \ sn
            \ shortname
            \ tenc
            \ termencoding
            \ ta
            \ textauto
            \ tx
            \ textmode
            \ tf
            \ ttyfast
            \ ttym
            \ ttymouse
            \ tbi
            \ ttybuiltin
            \ wiv
            \ weirdinvert



    " Turn-off setting variants
    syn keyword vimNotNvim
        \ contained
        \ nobiosk
        \ nobioskey
        \ noconsk
        \ noconskey
        \ nocp
        \ nocompatible
        \ noguipty
        \ nomacatsui
        \ nosn
        \ noshortname
        \ nota
        \ notextauto
        \ notx
        \ notextmode
        \ notf
        \ nottyfast
        \ notbi
        \ nottybuiltin
        \ nowiv
        \ noweirdinvert


    " Invertible setting variants
    syn keyword vimNotNvim
        \ contained
        \ invbiosk
        \ invbioskey
        \ invconsk
        \ invconskey
        \ invcp
        \ invcompatible
        \ invguipty
        \ invmacatsui
        \ invsn
        \ invshortname
        \ invta
        \ invtextauto
        \ invtx
        \ invtextmode
        \ invtf
        \ invttyfast
        \ invtbi
        \ invttybuiltin
        \ invwiv
        \ invweirdinvert


" termcap codes (which can also be set)
    syn keyword vimTermOption contained
       \  t_8b
        \ t_AB
        \ t_al
        \ t_bc
        \ t_ce
        \ t_cl
        \ t_Co
        \ t_Cs
        \ t_CV
        \ t_db
        \ t_DL
        \ t_F1
        \ t_F2
        \ t_F3
        \ t_F4
        \ t_F5
        \ t_F6
        \ t_F7
        \ t_F8
        \ t_F9
        \ t_fs
        \ t_IE
        \ t_IS
        \ t_k1
        \ t_K1
        \ t_k2
        \ t_k3
        \ t_K3
        \ t_k4
        \ t_K4
        \ t_k5
        \ t_K5
        \ t_k6
        \ t_K6
        \ t_k7
        \ t_K7
        \ t_k8
        \ t_K8
        \ t_k9
        \ t_K9
        \ t_KA
        \ t_kb
        \ t_kB
        \ t_KB
        \ t_KC
        \ t_kd
        \ t_kD
        \ t_KD
        \ t_ke
        \ t_KE
        \ t_KF
        \ t_KG
        \ t_kh
        \ t_KH
        \ t_kI
        \ t_KI
        \ t_KJ
        \ t_KK
        \ t_kl
        \ t_KL
        \ t_kN
        \ t_kP
        \ t_kr
        \ t_ks
        \ t_ku
        \ t_le
        \ t_mb
        \ t_md
        \ t_me
        \ t_mr
        \ t_ms
        \ t_nd
        \ t_op
        \ t_RB
        \ t_RI
        \ t_RV
        \ t_Sb
        \ t_se
        \ t_Sf
        \ t_SI
        \ t_so
        \ t_sr
        \ t_SR
        \ t_te
        \ t_ti
        \ t_ts
        \ t_u7
        \ t_ue
        \ t_us
        \ t_ut
        \ t_vb
        \ t_ve
        \ t_vi
        \ t_vs
        \ t_WP
        \ t_WS
        \ t_xn
        \ t_xs
        \ t_ZH
        \ t_ZR

    syn keyword vimTermOption
                \ contained
                \ t_8f
                \ t_AF
                \ t_AL
                \ t_cd
                \ t_Ce
                \ t_cm
                \ t_cs
                \ t_CS
                \ t_da
                \ t_dl
                \ t_EI

    syn match   vimTermOption contained    "t_%1"
    syn match   vimTermOption contained    "t_#2"
    syn match   vimTermOption contained    "t_#4"
    syn match   vimTermOption contained    "t_@7"
    syn match   vimTermOption contained    "t_*7"
    syn match   vimTermOption contained    "t_&8"
    syn match   vimTermOption contained    "t_%i"
    syn match   vimTermOption contained    "t_k;"


" these are supported by vi but don't do anything in vim
    syn keyword vimErrSetting
                        \ contained
                        \ hardtabs
                        \ ht
                        \ w1200
                        \ w300
                        \ w9600
