Loop, 5
{
    ToolTip, Testing! %A_Index%, 200, 200, 2
    hwnd := WinExist("ahk_class tooltips_class32")
    WinSet, Transparent, 33, % "ahk_id" hwnd
    Sleep 2000
}
ToolTip,,,,2
ExitApp
return


;~ #singleinstance force
;~ #NoEnv

;~ ;Gui Parent: +OwnDialogs
;~ Gui Parent: Font, s35
;~ Gui Parent: +AlwaysOnTop +LastFound HWNDParent ;+ToolWindow -Caption -Border
;~ Gui Parent: Color, 000000
;~ Gui Parent: Show, x0 y0 w1600 h250, Parent
;~ GetGuiPosition()

;~ Gui 1: +OwnerParent +OwnDialogs
;~ Gui 1: Font, s35
;~ Gui 1: Add, Text, x10 y10 cWhite, 1
;~ Gui 1: Color, Red
;~ Gui 1: +AlwaysOnTop +LastFound +ToolWindow -Caption -Border HWNDhGui1
;~ WinSet, Trans, 55
;~ Gui 1: Show, x200 y20 w200 h200, hGui1
;~ GetGuiPosition()

;~ Gui 2: +OwnerParent +OwnDialogs
;~ Gui 2: Font, s35
;~ Gui 2: Add, Text, x10 y10 cWhite, 2
;~ Gui 2: Color, Blue
;~ Gui 2: +AlwaysOnTop +LastFound +ToolWindow -Caption -Border HWNDhGui2
;~ WinSet, Trans, 55
;~ Gui 2: Show, x700 y20 w200 h200, hGui2
;~ GetGuiPosition()

;~ Gui 3: +OwnerParent +OwnDialogs
;~ Gui 3: Font, s35
;~ Gui 3: Add, Text, x10 y10 cWhite, 3
;~ Gui 3: Color, Green
;~ Gui 3: +AlwaysOnTop +LastFound +ToolWindow -Caption -Border HWNDhGui3
;~ WinSet, Trans, 55
;~ Gui 3: Show, x1200 y20 w200 h200, hGui3
;~ GetGuiPosition()

;~ OnMessage(0x03, "MoveParent")
;~ OnMessage(0x0201, "WM_LBUTTONDOWN")
;~ return

;~ GetGuiPosition()
;~ {
	;~ global
	;~ i++
	;~ WinGet, HWNDn, ID
	;~ WinGetPos, x%HWNDn%, y%HWNDn%, w%HWNDn%, h%HWNDn%
	;~ return
;~ }

;~ MoveParent()
;~ {
	;~ global
	;~ IfWinActive, ahk_id %Parent%
	;~ {
		;~ WinGet, HWNDn, ID, A
		;~ WinGetPos, x%HWNDn%, y%HWNDn%, w%HWNDn%, h%HWNDn%
		;~ Loop, % i - 1
		;~ {
			;~ ChHWNDn := hGui%A_Index%
			;~ WinMove, ahk_id %ChHWNDn%,, % x%Parent% + x%ChHWNDn%, % y%Parent% + y%ChHWNDn%
		;~ }
	;~ }
	;~ return
;~ }

;~ WM_LBUTTONDOWN()
;~ {
	;~ global
	;~ loop, 3
	;~ {
		;~ WinGet, HWNDn, ID, A
		;~ WinSet, Trans, % (HWNDn = hGui%A_Index% ? "OFF" : 55), hGui%A_Index%
	;~ }
	;~ return
;~ }

;~ ParentGuiClose:
;~ ExitApp

