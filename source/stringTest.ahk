;~ num1 := 123
;~ str1 := "" num1

;~ if (num1=str1) { 
	;~ MsgBox, %str1%
;~ }

lastCaretX := A_CaretX
lastCaretY := A_CaretY

	MsgBox, %A_CaretX% %lastCaretX%

if (lastCaretX = A_CaretX and lastCaretY = A_CaretY) {
	MsgBox, %A_CaretX% %lastCaretX%
}