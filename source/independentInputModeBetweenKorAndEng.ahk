; LAlt + Shift: select English language mode
; LShift + Space: select Korean language mode and then select Korean keyboard
; LCtrl + Space: select Korean language mode and then select Korean keyboard
;
; # Win
; ! Alt
; ^ Ctrl
; + Shift

#SingleInstance force
#NoTrayIcon

^F11::
    ExitApp
return


;~ LCtrl + Space를 입력하여 영어 입력
;~ <^Alt::                    
; LCtrl + Space를 입력하여 영어 입력
<^Space::
;    ret := IME_CHECK("A")
;    if %ret% = 0              
    {
        Send, {Insert}{Insert}
        Send, {LCtrl Down}{LShift Down}1{LShift Up}{LCtrl Up} ; 언어 설정에서 ctrl+shift+1 을 언어-영어로 변경하게 설정
    }
return


;~ ; LCtrl + Space를 입력하여 한글 입력
;~ <^Space::                      
; LShift + Space를 입력하여 한글 입력
<+Space::                 
;    ret := IME_CHECK("A")
;    if %ret% <> 0             
    {
        Send, {Insert}{Insert}
        Send, {LCtrl Down}{LShift Down}2{LShift Up}{LCtrl Up} ; 언어 설정에서 ctrl+shift+2 을 언어-한국어로 변경하게 설정
        Send, {vk15} ; {LShift Down}{Space}{LShift Up}
    }
return

;~ ; LAlt + Shift를 입력하여 영어 입력 ; Alt+Shift+Tab에 문제가 생겨서 사용할 수 없음.
;~ <!Shift::                   
;~ ;    ret := IME_CHECK("A")
;~ ;	MsgBox, % "Left Alt Shift " ret
;~ ;    if %ret% = 0              
    ;~ {
        ;~ Send {Esc}
        ;~ Send {LCtrl Down}{LShift Down}1{LCtrl Up}{LShift Up}
    ;~ }
;~ return


;~ IME_CHECK(WinTitle) 
;~ {
    ;~ WinGet,hWnd,ID,%WinTitle%
    ;~ Return Send_ImeControl(ImmGetDefaultIMEWnd(hWnd),0x005,"")
;~ }
;~ Send_ImeControl(DefaultIMEWnd, wParam, lParam)
;~ {
    ;~ DetectSave := A_DetectHiddenWindows
    ;~ DetectHiddenWindows,ON
     ;~ SendMessage 0x283, wParam,lParam,,ahk_id %DefaultIMEWnd%
    ;~ if (DetectSave <> A_DetectHiddenWindows)
        ;~ DetectHiddenWindows,%DetectSave%
    ;~ return ErrorLevel
;~ }
;~ ImmGetDefaultIMEWnd(hWnd)
;~ {
    ;~ return DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hWnd, Uint)
;~ }

