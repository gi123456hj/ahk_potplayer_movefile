#Persistent
SetTitleMatchMode, 2
Return

#IfWinActive, ahk_class PotPlayer64
Ins::
    SendInput ^{F1}         ; Pull up info dialog
    WinWaitActive, 재생 정보,,2
    If ErrorLevel {
        Tooltip, Couldn't find dialog... exiting...
        Sleep 2000
        ToolTip
        Return          ; couldn't find dialog
    }
    lastClipboard := ClipboardAll       ; Save existing clipboard contents

    SendInput ^{Tab 2}      ; Focus tab control at top
    Sleep 100
    SendInput {Right}       ; Focus FileInfo tab
    Sleep 100
    SendInput {Space}       ; Select FileInfo
    Sleep 100

    SendInput !p            ; Select copy to clipboard
    Sleep 100
    SendInput {Space}       ; Execute
    Sleep 100

    SendInput !c            ; Select close
    Sleep 100

    FileName := ""
    Loop, Parse, % FileInfo:=Clipboard, `n
    {
        If InStr(A_LoopField, "Complete name") {
            FileName := Trim(Substr(A_LoopField, InStr(A_LoopField, ":")+1), " `t`r") ; get path and file after colon and trim spaces
            Break
        }
    }

    Clipboard := lastClipboard ; restore previous clipboard

    If (FileName = "") {
        Tooltip, Couldn't find filename... exiting...
        Sleep 2000
        ToolTip
        Return
    }

    SplitPath, FileName,, dir
    dir = %dir%\보존
    If !FileExist(dir) {
        FileCreateDir, %dir%
    }

    FileMove, % FileName, %dir%
    Sleep 100

    If ErrorLevel {
        Tooltip, FileMove error..
        Sleep 2000
        ToolTip
	MsgBox % "FileMove error"
        Return
    }

    SendInput {PgDn}
    Sleep 100
    SendInput ^{Tab}
    Sleep 100
    SendInput {Del}
    Sleep 100
    SendInput ^{Tab}

Return


#IfWinActive, ahk_class PotPlayer64
Del::
    SendInput ^{F1}         ; Pull up info dialog
    WinWaitActive, 재생 정보,,2
    If ErrorLevel {
        Tooltip, Couldn't find dialog... exiting...
        Sleep 2000
        ToolTip
        Return          ; couldn't find dialog
    }
    lastClipboard := ClipboardAll       ; Save existing clipboard contents

    SendInput ^{Tab 2}      ; Focus tab control at top
    Sleep 100
    SendInput {Right}       ; Focus FileInfo tab
    Sleep 100
    SendInput {Space}       ; Select FileInfo
    Sleep 100

    SendInput !p            ; Select copy to clipboard
    Sleep 100
    SendInput {Space}       ; Execute
    Sleep 100

    SendInput !c            ; Select close
    Sleep 100

    FileName := ""
    Loop, Parse, % FileInfo:=Clipboard, `n
    {
        If InStr(A_LoopField, "Complete name") {
            FileName := Trim(Substr(A_LoopField, InStr(A_LoopField, ":")+1), " `t`r") ; get path and file after colon and trim spaces
            Break
        }
    }

    Clipboard := lastClipboard ; restore previous clipboard

    If (FileName = "") {
        Tooltip, Couldn't find filename... exiting...
        Sleep 2000
        ToolTip
        Return
    }

    SplitPath, FileName,, dir
    dir = %dir%\삭제
    If !FileExist(dir) {
        FileCreateDir, %dir%
    }

    FileMove, % FileName, %dir%
    Sleep 100

    If ErrorLevel {
        Tooltip, FileMove error..
        Sleep 2000
        ToolTip
	MsgBox % "FileMove error"
        Return
    }

    SendInput {PgDn}
    Sleep 100
    SendInput ^{Tab}
    Sleep 100
    SendInput {Del}
    Sleep 100
    SendInput ^{Tab}

Return