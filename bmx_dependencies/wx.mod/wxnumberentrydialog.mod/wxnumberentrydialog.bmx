' Copyright (c) 2007-2018 Bruce A Henderson
' 
' Permission is hereby granted, free of charge, to any person obtaining a copy
' of this software and associated documentation files (the "Software"), to deal
' in the Software without restriction, including without limitation the rights
' to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
' copies of the Software, and to permit persons to whom the Software is
' furnished to do so, subject to the following conditions:
' 
' The above copyright notice and this permission notice shall be included in
' all copies or substantial portions of the Software.
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
' THE SOFTWARE.
' 
SuperStrict

Rem
bbdoc: wxNumberEntryDialog
End Rem
Module wx.wxNumberEntryDialog

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2018 Bruce A Henderson"


?linux
ModuleInfo "CC_OPTS: -D__WXGTK__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?win32
ModuleInfo "CC_OPTS: -DHAVE_W32API_H"
ModuleInfo "CC_OPTS: -D__WXMSW__"
ModuleInfo "CC_OPTS: -D_UNICODE"
ModuleInfo "CC_OPTS: -DUNICODE"
?macos
ModuleInfo "CC_OPTS: -D__WXOSX_COCOA__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?

Import "common.bmx"

Rem
bbdoc: A dialog with spin control, [ok] and [cancel] buttons
End Rem
Type wxNumberEntryDialog Extends wxDialog

	Rem
	bbdoc: Creates a new dialog object.
	End Rem
	Function CreateNumberEntryDialog:wxNumberEntryDialog(parent:wxWindow, message:String, prompt:String, ..
			caption:String, value:Int, minimum:Int, maximum:Int, x:Int = -1, y:Int = -1)
		Return New wxNumberEntryDialog.Create(parent, message, prompt, caption, value, minimum, maximum, x, y)
	End Function
	
	Rem
	bbdoc: Creates a new dialog object.
	End Rem
	Method Create:wxNumberEntryDialog(parent:wxWindow, message:String, prompt:String, ..
			caption:String, value:Int, minimum:Int, maximum:Int, x:Int = -1, y:Int = -1)
		If parent Then
			wxObjectPtr = bmx_wxnumberentrydialog_create(Self, parent.wxObjectPtr, message, prompt, caption, ..
				value, minimum, maximum, x, y)
		Else
			wxObjectPtr = bmx_wxnumberentrydialog_create(Self, Null, message, prompt, caption, ..
				value, minimum, maximum, x, y)
		End If
		Return Self
	End Method
	
	Rem
	bbdoc: Returns the number from the dialog.
	End Rem
	Method GetValue:Int()
		Return bmx_wxnumberentrydialog_getvalue(wxObjectPtr)
	End Method	

End Type

Rem
bbdoc: Shows a dialog asking the user for numeric input.
about: The dialogs title is set to caption, it contains a (possibly) multiline message above the single
line prompt and the zone for entering the number.
<p>
The number entered must be in the range minVal..maxVal (both of which should be positive) and value is the
initial value of it. If the user enters an invalid value or cancels the dialog, the function will return -1.
</p>
<p>
Dialog is centered on its parent unless an explicit position is given in pos.
</p>
End Rem
Function wxGetNumberFromUser:Int(message:String, prompt:String, caption:String, value:Int = 0, ..
		minVal:Int = 0, maxVal:Int = 100, parent:wxWindow = Null, x:Int = -1, y:Int = -1)
		
	If parent Then
		Return bmx_wxgetnumberfromuser(message, prompt, caption, value, minVal, maxVal, parent.wxObjectPtr, x, y)
	Else
		Return bmx_wxgetnumberfromuser(message, prompt, caption, value, minVal, maxVal, Null, x, y)
	End If
	
End Function
