" Vim syntax file
    " Language:         AutoHotkey script file
    " Maintainer:       Michael Wong
    "                   https://github.com/mmikeww/autohotkey.vim
    " Latest Revision:  2017-04-03
    " Previous Maintainers:       SungHyun Nam <goweol@gmail.com>
    "                             Nikolai Weibull <now@bitwi.se>

if exists("b:current_syntax")
    finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn case ignore


" only these chars are valid as escape sequences:   ,%`;nrbtvaf
" https://autohotkey.com/docs/commands/_EscapeChar.htm
syn match   ahkEscape
            \ display
            \ '`[,%`;nrbtvaf]'

syn region ahkString
            \ display
            \ oneline
            \ matchgroup=ahkStringDelimiter
            \ start=+"+
            \ end=+"+
            \ contains=ahkEscape

syn match ahkVariable
            \ display
            \ oneline
            \ contains=ahkBuiltinVariable
            \ keepend
            \ '%\S\{-}%'

syn keyword ahkBuiltinVariable
            \ A_Space A_Tab
            \ A_WorkingDir A_ScriptDir A_ScriptName A_ScriptFullPath A_ScriptHwnd A_LineNumber
            \ A_LineFile A_ThisFunc A_ThisLabel A_AhkVersion A_AhkPath A_IsUnicode A_IsCompiled A_ExitReason
            \ A_YYYY A_MM A_DD A_MMMM A_MMM A_DDDD A_DDD A_WDay A_YDay A_YWeek A_Hour A_Min
            \ A_Mon A_Year A_MDay A_NumBatchLines
            \ A_Sec A_MSec A_Now A_NowUTC A_TickCount
            \ A_IsSuspended A_IsPaused A_IsCritical A_BatchLines A_TitleMatchMode A_TitleMatchModeSpeed
            \ A_DetectHiddenWindows A_DetectHiddenText A_AutoTrim A_StringCaseSense
            \ A_FileEncoding A_FormatInteger A_FormatFloat A_KeyDelay A_WinDelay A_ControlDelay
            \ A_SendMode A_SendLevel A_StoreCapsLockMode A_KeyDelay A_KeyDelayDuration
            \ A_KeyDelayPlay A_KeyDelayPlayDuration A_MouseDelayPlay
            \ A_MouseDelay A_DefaultMouseSpeed A_RegView A_IconHidden A_IconTip A_IconFile
            \ A_CoordModeToolTip A_CoordModePixel A_CoordModeMouse A_CoordModeCaret A_CoordModeMenu
            \ A_IconNumber
            \ A_TimeIdle A_TimeIdlePhysical A_DefaultGui A_DefaultListView A_DefaultTreeView
            \ A_Gui A_GuiControl A_GuiWidth A_GuiHeight A_GuiX A_GuiY A_GuiEvent
            \ A_GuiControlEvent A_EventInfo
            \ A_ThisMenuItem A_ThisMenu A_ThisMenuItemPos A_ThisHotkey A_PriorHotkey
            \ A_PriorKey A_TimeSinceThisHotkey A_TimeSincePriorHotkey A_EndChar
            \ ComSpec A_Temp A_OSType A_OSVersion A_Language A_ComputerName A_UserName
            \ A_Is64BitOS A_PtrSize
            \ A_WinDir A_ProgramFiles ProgramFiles A_AppData A_AppDataCommon A_Desktop
            \ A_DesktopCommon A_StartMenu A_StartMenuCommon A_Programs
            \ A_ProgramsCommon A_Startup A_StartupCommon A_MyDocuments A_IsAdmin
            \ A_ScreenWidth A_ScreenHeight A_ScreenDPI A_IPAddress1 A_IPAddress2 A_IPAddress3
            \ A_IPAddress4
            \ A_Cursor A_CaretX A_CaretY Clipboard ClipboardAll ErrorLevel A_LastError
            \ A_Index A_LoopFileName A_LoopRegName A_LoopReadLine A_LoopField
            \ A_LoopFileExt A_LoopFileFullPath A_LoopFileLongPath A_LoopFileShortPath
            \ A_LoopFileShortName A_LoopFileDir A_LoopFileTimeModified A_LoopFileTimeCreated
            \ A_LoopFileTimeAccessed A_LoopFileAttrib A_LoopFileSize A_LoopFileSizeKB A_LoopFileSizeMB
            \ A_LoopRegType A_LoopRegKey A_LoopRegSubKey A_LoopRegTimeModified

syn match   ahkBuiltinVariable
            \ contained
            \ display
            \ '%\d\+%'

syn keyword ahkCommand
            \ ClipWait EnvGet EnvSet EnvUpdate
            \ Drive DriveGet DriveSpaceFree FileAppend FileCopy FileCopyDir
            \ FileCreateDir FileCreateShortcut FileDelete FileGetAttrib FileEncoding
            \ FileGetShortcut FileGetSize FileGetTime FileGetVersion FileInstall
            \ FileMove FileMoveDir FileReadLine FileRead FileRecycle FileRecycleEmpty
            \ FileRemoveDir FileSelectFolder FileSelectFile FileSetAttrib FileSetTime
            \ IniDelete IniRead IniWrite SetWorkingDir
            \ SplitPath
            \ Gui GuiControl GuiControlGet IfMsgBox InputBox MsgBox Progress
            \ SplashImage SplashTextOn SplashTextOff ToolTip TrayTip
            \ Hotkey ListHotkeys BlockInput ControlSend ControlSendRaw GetKeyState
            \ KeyHistory KeyWait Input Send SendRaw SendInput SendPlay SendEvent
            \ SendMode SetKeyDelay SetNumScrollCapsLockState SetStoreCapslockMode
            \ EnvAdd EnvDiv EnvMult EnvSub Random SetFormat Transform
            \ AutoTrim BlockInput CoordMode Critical Edit ImageSearch
            \ ListLines ListVars Menu OutputDebug PixelGetColor PixelSearch
            \ SetBatchLines SetEnv SetTimer SysGet Thread Transform URLDownloadToFile
            \ Click ControlClick MouseClick MouseClickDrag MouseGetPos MouseMove
            \ SetDefaultMouseSpeed SetMouseDelay
            \ Process Run RunWait RunAs Shutdown Sleep
            \ RegDelete RegRead RegWrite
            \ SoundBeep SoundGet SoundGetWaveVolume SoundPlay SoundSet
            \ SoundSetWaveVolume
            \ FormatTime IfInString IfNotInString Sort StringCaseSense StringGetPos
            \ StringLeft StringRight StringLower StringUpper StringMid StringReplace
            \ StringSplit StringTrimLeft StringTrimRight StringLen
            \ StrSplit StrReplace Throw
            \ Control ControlClick ControlFocus ControlGet ControlGetFocus
            \ ControlGetPos ControlGetText ControlMove ControlSend ControlSendRaw
            \ ControlSetText Menu PostMessage SendMessage SetControlDelay
            \ WinMenuSelectItem GroupActivate GroupAdd GroupClose GroupDeactivate
            \ DetectHiddenText DetectHiddenWindows SetTitleMatchMode SetWinDelay
            \ StatusBarGetText StatusBarWait WinActivate WinActivateBottom WinClose
            \ WinGet WinGetActiveStats WinGetActiveTitle WinGetClass WinGetPos
            \ WinGetText WinGetTitle WinHide WinKill WinMaximize WinMinimize
            \ WinMinimizeAll WinMinimizeAllUndo WinMove WinRestore WinSet
            \ WinSetTitle WinShow WinWait WinWaitActive WinWaitNotActive WinWaitClose
            \ SetCapsLockState SetNumLockState SetScrollLockState

syn keyword ahkFunction
            \ InStr RegExMatch RegExReplace StrLen SubStr Asc Chr Func
            \ DllCall VarSetCapacity WinActive WinExist IsLabel OnMessage
            \ Abs Ceil Exp Floor Log Ln Mod Round Sqrt Sin Cos Tan ASin ACos ATan
            \ FileExist GetKeyState NumGet NumPut StrGet StrPut RegisterCallback
            \ IsFunc Trim LTrim RTrim IsObject Object Array FileOpen
            \ ComObjActive ComObjArray ComObjConnect ComObjCreate ComObjGet
            \ ComObjError ComObjFlags ComObjQuery ComObjType ComObjValue ComObject
            \ Format Exception

syn keyword ahkStatement
            \ Break Continue Exit ExitApp Gosub Goto OnExit Pause Return
            \ Suspend Reload new class extends

syn keyword ahkRepeat
            \ Loop

syn keyword ahkConditional
            \ IfExist IfNotExist If IfEqual IfLess IfGreater Else
            \ IfWinExist IfWinNotExist IfWinActive IfWinNotActive
            \ IfNotEqual IfLessOrEqual IfGreaterOrEqual
            \ while until for in try catch finally

syn match   ahkPreProcStart
            \ nextgroup=
            \   ahkInclude,
            \   ahkPreProc
            \ skipwhite
            \ display
            \ '^\s*\zs#'

syn keyword ahkInclude
            \ contained
            \ Include
            \ IncludeAgain

syn keyword ahkPreProc
            \ contained
            \ HotkeyInterval HotKeyModifierTimeout
            \ Hotstring
            \ IfWinActive IfWinNotActive IfWinExist IfWinNotExist
            \ If IfTimeout
            \ MaxHotkeysPerInterval MaxThreads MaxThreadsBuffer MaxThreadsPerHotkey
            \ UseHook InstallKeybdHook InstallMouseHook
            \ KeyHistory
            \ NoTrayIcon SingleInstance
            \ WinActivateForce
            \ AllowSameLineComments
            \ ClipboardTimeout
            \ CommentFlag
            \ ErrorStdOut
            \ EscapeChar
            \ MaxMem
            \ NoEnv
            \ Persistent
            \ LTrim
            \ InputLevel
            \ MenuMaskKey
            \ Warn

syn keyword ahkMatchClass
            \ ahk_group ahk_class ahk_id ahk_pid ahk_exe

syn match   ahkNumbers
            \ display
            \ transparent
            \ contains=
            \   ahkInteger,
            \   ahkFloat
            \ '\<\d\|\.\d'

syn match   ahkInteger
            \ contained
            \ display
            \ '\d\+\>'

syn match   ahkInteger
            \ contained
            \ display
            \ '0x\x\+\>'

syn match   ahkFloat
            \ contained
            \ display
            \ '\d\+\.\d*\|\.\d\+\>'

syn keyword ahkType
            \ local
            \ global
            \ static
            \ byref

syn keyword ahkBoolean
            \ true
            \ false

syn match   ahkHotkey
            \ contains=ahkKey,
            \   ahkHotkeyDelimiter
            \ display
            \ '^\s*\S*\%( Up\)\?::'

syn match   ahkKey
            \ contained
            \ display
            \ '^.\{-}'

syn match   ahkDelimiter
            \ contained
            \ display
            \ '::'

" allowable hotstring options:
" https://autohotkey.com/docs/Hotstrings.htm
syn match   ahkHotstringDefinition
            \ contains=ahkHotstring,
            \   ahkHotstringDelimiter
            \ display
            \ '^\s*:\%([*?]\|[BORZ]0\?\|C[01]\?\|K\d\+\|P\d\+\|S[IPE]\)*:.\{-}::'

syn match   ahkHotstring
            \ contained
            \ display
            \ '.\{-}'

syn match   ahkHotstringDelimiter
            \ contained
            \ display
            \ '::'

syn match   ahkHotstringDelimiter
            \ contains=ahkHotstringOptions
            \ contained
            \ display
            \ ':\%([*?]\|[BORZ]0\?\|C[01]\?\|K\d\+\|P\d\+\|S[IPE]\)*:'

syn match   ahkHotstringOptions
            \ contained
            \ display
            \ '\%([*?]\|[BORZ]0\?\|C[01]\?\|K\d\+\|P\d\+\|S[IPE]\)*'


" Comment
    hi def link ahkTodo                Todo
    hi def link ahkComment             Comment
    hi def link ahkComment_staR        ahkComment

    syn keyword ahkTodo
                \ contained
                \ TODO FIXME XXX NOTE

    syn cluster ahkCommentGroup
                \ contains=
                        \ ahkTodo,
                        \ @Spell

    syn match   ahkComment
                \ display
                \ contains=@ahkCommentGroup
                \ '\v%(^;|\s+;).*$'


    syn region  ahkComment
                \ contains=@ahkCommentGroup
                \ matchgroup=ahkComment_staR
                \ start='^\s*/\*'
                \ end='^\s*\*/'

" TODO: Shouldn't we look for g:, b:,  variables before defaulting to
" something?
if exists("g:autohotkey_syntax_sync_minlines")
    let b:autohotkey_syntax_sync_minlines = g:autohotkey_syntax_sync_minlines
else
    let b:autohotkey_syntax_sync_minlines = 50
endif
exec "syn sync ccomment ahkComment minlines=" . b:autohotkey_syntax_sync_minlines


hi def link ahkEscape              Special
hi def link ahkHotkey              Type
hi def link ahkKey                 Type
hi def link ahkDelimiter           Delimiter
hi def link ahkHotstringDefinition Type
hi def link ahkHotstring           Type
hi def link ahkHotstringDelimiter  ahkDelimiter
hi def link ahkHotstringOptions    Special
hi def link ahkString              String
hi def link ahkStringDelimiter     ahkString
hi def link ahkVariable            Identifier
hi def link ahkVariableDelimiter   ahkVariable
hi def link ahkBuiltinVariable     Macro
hi def link ahkCommand             Keyword
hi def link ahkFunction            Function
hi def link ahkStatement           ahkCommand
hi def link ahkRepeat              Repeat
hi def link ahkConditional         Conditional
hi def link ahkPreProcStart        PreProc
hi def link ahkInclude             Include
hi def link ahkPreProc             PreProc
hi def link ahkMatchClass          Typedef
hi def link ahkNumber              Number
hi def link ahkInteger             ahkNumber
hi def link ahkFloat               ahkNumber
hi def link ahkType                Type
hi def link ahkBoolean             Boolean

let b:current_syntax = "autohotkey"

let &cpo = s:cpo_save
unlet s:cpo_save
