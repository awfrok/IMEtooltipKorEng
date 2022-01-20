#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases

; Official repo:
; https://github.com/selfiens/KorTooltip

; References:
; IME state reader: https://iamaman.tistory.com/1805
; Persistent tooltip https://stackoverflow.com/questions/41598616/toggling-a-persistent-tooltip

; commands https://www.autohotkey.com/docs/commands/
; hotkeys https://www.autohotkey.com/docs/Hotkeys.

; # win
; ! alt
; ^ ctrl
; + shift

; ----------------------------------------------------------------
; Initializer >>>


#SingleInstance force
#NoTrayIcon

global mouseX, mouseY, lastX, lastY, lastmouseX, lastmouseY, lastImeState, imeState, idlePollingCurrentSkip

#MaxThreadsPerHotkey 30


isActive := True
lastX := 0
lastY := 0
lastmouseX := 0
lastmouseY := 0
lastImeState := 99

idlePollingCurrentSkip := 0
idlePollingSkipMax := 60 ; 1000ms / 16.7ms = 60

korToolTipLabel := "KO"
engToolTipLabel := "EN"


;InitTrayMenu()
SetTimer, WatchActiveWindow, 16  ; 16 ; 1000ms/60fps =~ 16.7ms
return

;~ ^F10::
	;~ Suspend
;~ return

^F12::
    ExitApp
return


ToolTipColorBlackOnWhite(){
    global colorScheme
    colorScheme := "blackOnWhite"
    
;	StopToolTipFlash()
	ToolTipColor("White","Black") ; background / foreground
}

ToolTipColorWhiteOnBlack(){
    global colorScheme
    colorScheme := "whiteOnBlack"

;    StopToolTipFlash()
	ToolTipColor("Black","White")
}

; ----------------------------------------------------------------
; main poller
; ----------------------------------------------------------------

;WatchCursor:
;MouseGetPos, mouseX, mouseY, mouse_winId, controlId

WatchActiveWindow:
MouseGetPos, mouseX, mouseY, mouse_winId, controlId

; hide tooltip when cursor is near the upper edge of the underlaying window
;~ if(y < 50){
	;~ ToolTip
	;~ return
;~ }

;ToolTipPositions()

;imeState := ReadImeState(mouse_winId) ; read ime state of window under mouse pointer
WinGet, active_winid, ID, A
imeState := ReadImeState(active_winid) ; read ime state of active window


; slows down IME state check frequency when the cursor is idle

if (A_CaretX = lastX and A_CaretY = lastY and mouseX = lastmouseX and mouseY = lastmouseY and imeState = lastImeState){ ; and toolTipFlashIdx = 0){
    ;~ idlePollingCurrentSkip += 1
    ;~ ToolTip %idlePollingCurrentSkip%,mouseX+40,mouseY+20,10

    ;~ if(idlePollingCurrentSkip < idlePollingSkipMax) {
        Sleep idlePollingCurrentSkip
        OutputDebug, idle %idlePollingCurrentSkip%
        ;~ return
    ;~ }
    ;~ else{
        ;~ ; reset idle polling skip
        ;~ idlePollingCurrentSkip := 0
        ;~ return
    ;~ }
    ;~ ;OutputDebug, idle %idlePollingCurrentSkip%
    return
}
;~ else{
    ;~ ToolTip,,,,3
    ;~ ToolTip,,,,4
    ;~ ToolTip,,,,5
    ;~ ToolTip,,,,6
    ;~ ToolTip,,,,7
    ;~ ToolTip,,,,8
    ;~ ToolTip,,,,9
    ;~ ToolTip,,,,10
;~ }

; reset idle polling skip
idlePollingCurrentSkip := 0

lastmouseX := mouseX
lastmouseY := mouseY
lastX := A_CaretX
lastY := A_CaretY

lastImeState := imeState

;~ ToolTipPositions()


; show ENG label
if(imeState = 0 ) { ; and isEngTooltipDisplayed){
	;~ lastmouseX := mouseX
	;~ lastmouseY := mouseY
    ;~ lastX := A_CaretX
    ;~ lastY := A_CaretY
        
	;~ lastImeState := imeState
    
    ToolTipByMouse(engToolTipLabel)
    if (A_CaretX = "") {
        ToolTip,,,,2
        return
    }
    else{
        TooltipByInput(engToolTipLabel)
    }
	return
}
else { ;if(imeState <> 0) {
    ;~ lastmouseX := mouseX
    ;~ lastmouseY := mouseY
    ;~ lastX := A_CaretX
    ;~ lastY := A_CaretY
    
    ;~ lastImeState := imeState

    ToolTipByMouse(korToolTipLabel)
    if (A_CaretX = "") {
        ToolTip,,,,2
        return
    }
    else{
        TooltipByInput(korToolTipLabel)
    }
    return
}

;~ if(mouseX = lastmouseX and mouseY = lastmouseY and imeState = lastImeState ){ ; and toolTipFlashIdx = 0){
    ;~ return
;~ }
;~ if(A_CaretX = lastX and A_CaretY = lastY and imeState = lastImeState ){ ; and toolTipFlashIdx = 0){
    ;~ return
;~ }

return


ToolTipByMouse(toolTipLabel)
{
    ToolTipColorWhiteOnBlack()
    ToolTip, %toolTipLabel%, mouseX+20, mouseY+20,1
;    return
}
TooltipByInput(toolTipLabel)
{
    ToolTipColorBlackOnWhite()
    ToolTip, %toolTipLabel%, A_CaretX+20, A_CaretY+20,2 ; x+toolTipOffsetX, y+toolTipOffsetY
;    return
}
ToolTipPositions()
{
    ToolTipColorBlackOnWhite()
    ToolTip Caret %A_CaretX% `, %A_CaretY% `(%lastX%`,%lastY%`) ,mouseX+40,mouseY-40,7
;    ToolTip, y %A_CaretY%,mouseX+80,mouseY-40,6
    ToolTip Mouse %mouseX% `, %mouseY% `(%lastmouseX%`,%lastmouseY%`) ,mouseX+40,mouseY-20,8
;    ToolTip, y %mouseY%,mouseX+80,mouseY-20,8
    ToolTip LastIMEstate: %lastImeState% `, IMEstate: %imeState%, mouseX+40, mouseY,9
;    ToolTip %idlePollingCurrentSkip%,mouseX+40,mouseY+20,10
;    return
}


; ----------------------------------------------------------------
; @returns int 0:inactive 1:active
; ----------------------------------------------------------------

ReadImeState(hWnd)
{
    ; WinGet,hWnd,ID,%WinTitle%
    Return Send_ImeControl(ImmGetDefaultIMEWnd(hWnd),0x005,"")
}

Send_ImeControl(DefaultIMEWnd, wParam, lParam)
{
    DetectSave := A_DetectHiddenWindows
    DetectHiddenWindows,ON
    SendMessage 0x283, wParam,lParam,,ahk_id %DefaultIMEWnd%
    if (DetectSave <> A_DetectHiddenWindows)
        DetectHiddenWindows,%DetectSave%
    return ErrorLevel
}

ImmGetDefaultIMEWnd(hWnd)
{
    return DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hWnd, Uint)
}


; ------------------------------------------------------------------
; ToolTip font & color customizer
; from https://www.autohotkey.com/boards/viewtopic.php?t=4777
; ------------------------------------------------------------------

ToolTipFont(Options := "", Name := "", hwnd := "") {
    static hfont := 0
    if (hwnd = "")
        hfont := Options="Default" ? 0 : _TTG("Font", Options, Name), _TTHook()
    else
        DllCall("SendMessage", "ptr", hwnd, "uint", 0x30, "ptr", hfont, "ptr", 0)
}
 
ToolTipColor(Background := "", Text := "", hwnd := "") {
    static bc := "", tc := ""
    if (hwnd = "") {
        if (Background != "")
            bc := Background="Default" ? "" : _TTG("Color", Background)
        if (Text != "")
            tc := Text="Default" ? "" : _TTG("Color", Text)
        _TTHook()
    }
    else {
        VarSetCapacity(empty, 2, 0)
        DllCall("UxTheme.dll\SetWindowTheme", "ptr", hwnd, "ptr", 0
            , "ptr", (bc != "" && tc != "") ? &empty : 0)
        if (bc != "")
            DllCall("SendMessage", "ptr", hwnd, "uint", 1043, "ptr", bc, "ptr", 0)
        if (tc != "")
            DllCall("SendMessage", "ptr", hwnd, "uint", 1044, "ptr", tc, "ptr", 0)
    }
}
 
_TTHook() {
    static hook := 0
    if !hook
        hook := DllCall("SetWindowsHookExW", "int", 4
            , "ptr", RegisterCallback("_TTWndProc"), "ptr", 0
            , "uint", DllCall("GetCurrentThreadId"), "ptr")
}
 
_TTWndProc(nCode, _wp, _lp) {
    Critical 999
   ;lParam  := NumGet(_lp+0*A_PtrSize)
   ;wParam  := NumGet(_lp+1*A_PtrSize)
    uMsg    := NumGet(_lp+2*A_PtrSize, "uint")
    hwnd    := NumGet(_lp+3*A_PtrSize)
    if (nCode >= 0 && (uMsg = 1081 || uMsg = 1036)) {
        _hack_ = ahk_id %hwnd%
        WinGetClass wclass, %_hack_%
        if (wclass = "tooltips_class32") {
            ToolTipColor(,, hwnd)
            ToolTipFont(,, hwnd)
        }
    }
    return DllCall("CallNextHookEx", "ptr", 0, "int", nCode, "ptr", _wp, "ptr", _lp, "ptr")
}
 
_TTG(Cmd, Arg1, Arg2 := "") {
    static htext := 0, hgui := 0
    if !htext {
        Gui _TTG: Add, Text, +hwndhtext
        Gui _TTG: +hwndhgui +0x40000000
    }
    Gui _TTG: %Cmd%, %Arg1%, %Arg2%
    if (Cmd = "Font") {
        GuiControl _TTG: Font, %htext%
        SendMessage 0x31, 0, 0,, ahk_id %htext%
        return ErrorLevel
    }
    if (Cmd = "Color") {
        hdc := DllCall("GetDC", "ptr", htext, "ptr")
        SendMessage 0x138, hdc, htext,, ahk_id %hgui%
        clr := DllCall("GetBkColor", "ptr", hdc, "uint")
        DllCall("ReleaseDC", "ptr", htext, "ptr", hdc)
        return clr
    }
}