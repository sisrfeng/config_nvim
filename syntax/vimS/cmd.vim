syn cluster vimUserCmdList  contains=vimAddress,
                                    \vimSyntax,
                                    \vimHighlight,
                                    \vimAutoCmd,
                                    \vimCmplxRepeat,
                                    \vimTailCmt,
                                    \vimCtrlChar,
                                    \vimEscapeBrace,
                                    \vimFunc,
                                    \vimFuncName,
                                    \vimFuncDef,
                                    \vimFunctionError,
                                    \vimIsCommand,
                                    \vimMark,
                                    \vimNotation,
                                    \vimNumber,
                                    \vimOper,
                                    \vimRegion,
                                    \vimRegister,
                                    \vimLet,
                                    \vimSet,
                                    \vimSetEqual,
                                    \vimSetString,
                                    \vimSpecFile,
                                    \vimStr,
                                    \vimSubst,
                                    \vimSubsRep,
                                    \vimSubsRange,
                                    \vimSynLine

syn keyword vimUserCommand  contained   com[mand]
syn match   vimUserCmd  "\<com\%[mand]!\=\>.*$" contains=vimUserAttrb,
                                    \vimUserAttrbError,
                                    \vimUserCommand,
                                    \@vimUserCmdList,
                                    \vimComFilter
syn match   vimUserAttrbError   contained   "-\a\+\ze\s"
syn match   vimUserAttrb    contained   "-nargs=[01*?+]"    contains=vimUserAttrbKey,vimOper
syn match   vimUserAttrb    contained   "-complete="        contains=vimUserAttrbKey,vimOper nextgroup=vimUserAttrbCmplt,vimUserCmdError
syn match   vimUserAttrb    contained   "-range\(=%\|=\d\+\)\=" contains=vimNumber,vimOper,vimUserAttrbKey
syn match   vimUserAttrb    contained   "-count\(=\d\+\)\=" contains=vimNumber,vimOper,vimUserAttrbKey
syn match   vimUserAttrb    contained   "-bang\>"       contains=vimOper,vimUserAttrbKey
syn match   vimUserAttrb    contained   "-bar\>"        contains=vimOper,vimUserAttrbKey
syn match   vimUserAttrb    contained   "-buffer\>"     contains=vimOper,vimUserAttrbKey
syn match   vimUserAttrb    contained   "-register\>"       contains=vimOper,vimUserAttrbKey
if !exists("g:vimsyn_noerror") && !exists("g:vimsyn_nousercmderror")
    syn match   vimUserCmdError contained   "\S\+\>"
en
syn case ignore
syn keyword vimUserAttrbKey   contained bar ban[g]  cou[nt] ra[nge] com[plete]  n[args] re[gister]
syn keyword vimUserAttrbCmplt contained augroup buffer behave color command compiler cscope dir environment event expression file file_in_path filetype function help highlight history locale mapping menu option packadd shellcmd sign syntax syntime tag tag_listfiles user var
syn keyword vimUserAttrbCmplt contained custom customlist nextgroup=vimUserAttrbCmpltFunc,vimUserCmdError
syn match   vimUserAttrbCmpltFunc contained ",\%([sS]:\|<[sS][iI][dD]>\)\=\%(\h\w*\%(#\h\w*\)\+\|\h\w*\)"hs=s+1 nextgroup=vimUserCmdError

syn case match
syn match   vimUserAttrbCmplt contained "custom,\u\w*"


