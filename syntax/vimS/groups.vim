
" Highlight commonly used Groupnames
    syn case ignore
    syn keyword    vimGroup contained
        \ Comment
        \ Constant
        \ String
        \ Character
        \ Number
        \ Boolean
        \ Float
        \ Identifier
        \ Function
        \ Statement
        \ Conditional
        \ Repeat
        \ Label
        \ Operator
        \ Keyword
        \ Exception
        \ PreProc
        \ Include
        \ Define
        \ Macro
        \ PreCondit
        \ Type
        \ StorageClass
        \ Structure
        \ Typedef
        \ Special
        \ SpecialChar
        \ Tag
        \ Delimiter
        \ SpecialComment
        \ Debug
        \ Underlined
        \ Ignore
        \ Error
        \ Todo

" Default highlighting groups
    syn keyword vimHLGroup contained
        \ ColorColumn
        \ Cursor
        \ CursorColumn
        \ CursorIM
        \ CursorLine
        \ CursorLineFold
        \ CursorLineNr
        \ CursorLineSign
        \ DiffAdd
        \ DiffChange
        \ DiffDelete
        \ DiffText
        \ Directory
        \ EndOfBuffer
        \ ErrorMsg
        \ FoldColumn
        \ Folded
        \ IncSearch
        \ LineNr
        \ MatchParen
        \ Menu
        \ ModeMsg
        \ MoreMsg
        \ NonText
        \ Normal
        \ Pmenu
        \ PmenuSbar
        \ PmenuSel
        \ PmenuThumb
        \ Question
        \ QuickFixLine
        \ Scrollbar
        \ Search
        \ SignColumn
        \ SpecialKey
        \ SpellBad
        \ SpellCap
        \ SpellLocal
        \ SpellRare
        \ StatusLine
        \ StatusLineNC
        \ TabLine
        \ TabLineFill
        \ TabLineSel
        \ Title
        \ Tooltip
        \ VertSplit
        \ Visual
        \ WarningMsg
        \ WildMenu

    syn match vimHLGroup contained  "Conceal"

    syn keyword vimOnlyHLGroup
                        \ contained
                        \ LineNrAbove
                        \ LineNrBelow
                        \ StatusLineTerm
                        \ Terminal
                        \ VisualNOS

    syn keyword nvimHLGroup
                        \ contained
                        \ Substitute
                        \ TermCursor
                        \ TermCursorNC

    syn case match


