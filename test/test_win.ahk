#Persistent
SetTimer, WatchActiveWindow, 16
return

WatchActiveWindow:
; WinGet, ControlList, ControlList, A
; ToolTip, %ControlList%

; WinGet, active_id, ID, A
; ToolTip, %active_id%

WinGet,hWnd,ID,A
ToolTip, %hWnd%
return