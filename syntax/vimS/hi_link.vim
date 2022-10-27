 if !exists("skip_vim_syntax_inits")
    if !exists("g:vimsyn_noerror")
        hi   def   link   vimBehaveError     vimError
        hi   def   link   vimCollClassErr    vimError
        hi   def   link   vimErrSetting      vimError
        hi   def   link   vimEmbedError      Normal
        hi   def   link   vimFTError         vimError
        hi   def   link   vimFunctionError   vimError
        hi   def   link   vimFunc            vimError
        hi   def   link   vimHiAttribList    vimError
        hi   def   link   vimHiCtermError    vimError
        hi   def   link   vimHiKeyError      vimError
        hi   def   link   vimKeyCodeError    vimError
        hi   def   link   vimMapModErr       vimError
        hi   def   link   vimSubsFlagErr    vimError
        hi   def   link   vimSynCaseError    vimError
        hi   def   link   vimBufnrWarn       vimWarn
    en

    hi   def   link   vimAbb                  vimCommand
    hi   def   link   vimAddress              vimMark
    hi   def   link   vimAugroupError         vimError
    hi   def   link   vimAugroupKey           vimCommand
    hi   def   link   vimAuHighlight          vimHighlight
    hi   def   link   vimAutoCmdOpt           vimOption
    hi   def   link   vimAutoCmd              vimCommand
    hi   def   link   vimAutoEvent            Type
    hi   def   link   vimAutoCmdMod           Special
    hi   def   link   vimAutoSet              vimCommand
    hi   def   link   vimBehaveModel          vimBehave
    hi   def   link   vimBehave               vimCommand
    hi   def   link   vimBracket              Delimiter
    hi   def   link   vimCmplxRepeat          SpecialChar
    hi   def   link   vimCommand              Statement
    hi   def   link   vimCmt_Str        vimStr
    hi   def   link   vimCmt_Title         PreProc
    hi   def   link   vimCondHL               vimCommand
    hi   def   link   vimCtrlChar             SpecialChar
    hi   def   link   vimEchoHLNone           vimGroup
    hi   def   link   vimEchoHL               vimCommand
    hi   def   link   vimElseIfErr            Error
    hi   def   link   vimElseif               vimCondHL
    hi   def   link   vimEnvvar               PreProc
    hi   def   link   vimError                Error
    hi   def   link   vimFBVar                vimVar
    hi   def   link   vimFgBgAttrib           vimHiAttrib
    hi   def   link   vimFuncEcho             vimCommand
    hi   def   link   vimHiCtermul            vimHiTerm
    hi   def   link   vimFold                 Folded
    hi   def   link   vimFTCmd                vimCommand
    hi   def   link   vimFTOption             vimSynType
    hi   def   link   vimFuncKey              vimCommand
    hi   def   link   vimFuncName             Function
    hi   def   link   vimFuncSID              Special
    hi   def   link   vimFuncVar              Identifier

    "\ hi   def   link   vimGroup                Type
        hi vimGroup gui=none guifg=#662222 guibg=none
    hi   def   link   vimGroupAdd             vimSynOption
    hi   def   link   vimGroupRm             vimSynOption
    hi   def   link   vimGROUP         Special

    hi   def   link   vimHiAttrib             PreProc
    hi   def   link   vimHiBlend              vimHiTerm
    hi   def   link   vimHiClear              vimHighlight
    hi   def   link   vimHiCtermFgBg          vimHiTerm
    hi   def   link   vimHiCTerm              vimHiTerm
    hi   def   link   vimHighlight            vimCommand
    hi   def   link   vimHiGuiFgBg            vimHiTerm
    hi   def   link   vimHiGuiFont            vimHiTerm
    hi   def   link   vimHiGuiRgb             vimNumber
    hi   def   link   vimHiGui                vimHiTerm
    hi   def   link   vimHiNmbr               Number
    hi   def   link   vimHiStartStop          vimHiTerm
    hi   def   link   vimHiTerm               Type
    hi   def   link   vimHLGroup              vimGroup
    hi   def   link   vimHLMod                PreProc
    hi   def   link   vimInsert               vimStr
    hi   def   link   vimIskSep               Delimiter
    hi   def   link   vimKeyCode              vimSpecFile
    hi   def   link   vimKeyword              Statement
    hi   def   link   vimLet                  vimCommand
    hi   def   link   vimLetHereDoc           vimStr
    hi   def   link   vimLetHereDocStart      Special
    hi   def   link   vimLetHereDocStop       Special
    hi   def   link   vimMapBang              vimCommand
    hi   def   link   vimMapModKey            vimFuncSID
    hi   def   link   vimMapMod               vimBracket
    hi   def   link   vimMap                  vimCommand
    hi   def   link   vimMark                 Number
    hi   def   link   vimMarkNumber           vimNumber
    hi   def   link   vimMenuMod              vimMapMod
    hi   def   link   vimMenuNameMore         vimMenuName
    hi   def   link   vimMenuName             PreProc
    hi   def   link   vimMatchComment          vimTailCmt
    hi   def   link   vimNorm                 vimCommand
    hi   def   link   vimNotation             Special
    hi   def   link   vimTwoBs            vimStr
    hi   def   link   vimNumber               Number
    hi   def   link   vimOperError            Error
    hi   def   link   vimOper                 Operator
    hi   def   link   vimOperStar             vimOper
    hi   def   link   vimOption               PreProc
    hi   def   link   vimRightParen            vimError
    hi   def   link   vimPatSepR              vimBar
    hi   def   link   vimBar               SpecialChar
    hi   def   link   vimInParen           vimStr
    hi   def   link   vimPatSepZ              vimBar
    hi   def   link   vimPattern              Type
    hi   def   link   vimPlainMark            vimMark
    hi   def   link   vimPlainRegister        vimRegister
    hi   def   link   vimRegister             SpecialChar
    hi   def   link   vimScriptDelim          Comment
    hi   def   link   vimSearchDelim          Statement
    hi   def   link   vimSearch               vimStr
    hi   def   link   vimSetMod               vimOption
    hi   def   link   vimSetSep               Statement
    hi   def   link   vimSetString            vimStr
    hi   def   link   vimSpecFile             Identifier
    hi   def   link   vimSpecFileMod          vimSpecFile
    hi   def   link   vimSpecial              Type
    hi   def   link   vimStatement            Statement
    hi   def   link   vimStrConti              vimStr
    hi   def   link   vimStr                  String
    hi   def   link   vimStrEnd               vimStr
    hi   def   link   vimSubs1               vimSubst
    hi   def   link   vimSubsDelim           Delimiter
    hi   def   link   vimSubsFlags           Special
    hi   def   link   vimSubs129          SpecialChar
    hi   def   link   vimSubs2BS           vimStr
    hi   def   link   vimSubs                vimCommand

    hi   def   link   vimSynCaseError         Error
    hi   def   link   vimSynCase              Type

    hi   def   link   vimSyncC                Type
    hi   def   link   vimSyncError            Error
    hi   def   link   vimSyncGroupName        vimGroupName
    hi   def   link   vimSyncGroup            vimGroupName
    hi   def   link   vimSyncKey              Type
    hi   def   link   vimSyncNone             Type

    hi   def   link   vimSyn_contain          vimSynOption
    hi   def   link   vimSyn_containedin    vimSyn_contain
    hi   def   link   vimSynError             Error

    hi   def   link   vimSynOption            Special
    hi   def   link   vimSynKeyOpt            vimSynOption


    hi   def   link   vimSynNotPatRange       vimSynRegionPat
    hi   def   link   vimSynPatRange          vimStr


    hi   def   link   vimSyntax               vimCommand
    hi   def   link   vimSynType              vimSpecial

    hi   def   link   vimTodo                 Todo
    hi   def   link   vimType                 Type
    hi   def   link   vimUnmap                vimMap
    hi   def   link   vimUserAttrbCmpltFunc   Special
    hi   def   link   vimUserAttrbCmplt       vimSpecial
    hi   def   link   vimUserAttrbKey         vimOption
    hi   def   link   vimUserAttrb            vimSpecial
    hi   def   link   vimUserAttrbError       Error
    hi   def   link   vimUserCmdError         Error
    hi   def   link   vimUserCommand          vimCommand
    hi   def   link   vimUserFunc             Normal
    hi   def   link   vimVar                  Identifier
    hi   def   link   vimWarn                 WarningMsg

    hi   def   link   nvimAutoEvent           vimAutoEvent
    hi   def   link   nvimHLGroup             vimHLGroup
    hi   def   link   nvimMap                 vimMap
    hi   def   link   nvimUnmap               vimUnmap
en


