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
bbdoc: wxSpinButton
End Rem
Module wx.wxSpinButton

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
bbdoc: A wxSpinButton has two small up and down (or left and right) arrow buttons.
about: It is often used next to a text control for increment and decrementing a value. Portable programs
should try to use wxSpinCtrl instead as wxSpinButton is not implemented for all platforms but wxSpinCtrl is
as it degenerates to a simple wxTextCtrl on such platforms.
<p>
NB: the range supported by this control (and wxSpinCtrl) depends on the platform but is at least -0x8000
to 0x7fff. Under GTK and Win32 with sufficiently new version of comctrl32.dll (at least 4.71 is required,
5.80 is recommended) the full 32 bit range is supported.
</p>
End Rem
Type wxSpinButton Extends wxControl

	Function _create:wxSpinButton(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxSpinButton = New wxSpinButton
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Function _xrcNew:wxSpinButton(wxObjectPtr:Byte Ptr) { nomangle }
		Return wxSpinButton._create(wxObjectPtr)
	End Function

	Rem
	bbdoc: Constructor, creating and showing a spin button.
	End Rem
	Function CreateSpinButton:wxSpinButton(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, w:Int = -1,  ..
			h:Int = -1, style:Int = wxSP_HORIZONTAL)
		Return New wxSpinButton.Create(parent, id, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: Creates a new spin button.
	End Rem
	Method Create:wxSpinButton(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, w:Int = -1,  ..
			h:Int = -1, style:Int = wxSP_HORIZONTAL)
		wxObjectPtr = bmx_wxspinbutton_create(Self, parent.wxObjectPtr, id, x, y, w, h, style)
		
		OnInit()
		
		Return Self
	End Method
	
	Rem
	bbdoc: Returns the maximum permissible value.
	End Rem
	Method GetMax:Int()
		Return bmx_wxspinbutton_getmax(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the minimum permissible value.
	End Rem
	Method GetMin:Int()
		Return bmx_wxspinbutton_getmin(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the current spin button value.
	End Rem
	Method GetValue:Int()
		Return bmx_wxspinbutton_getvalue(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the range of the spin button.
	End Rem
	Method SetRange(minValue:Int, maxValue:Int)
		bmx_wxspinbutton_setrange(wxObjectPtr, minValue, maxValue)
	End Method
	
	Rem
	bbdoc: Sets the value of the spin button.
	End Rem
	Method SetValue(value:Int)
		bmx_wxspinbutton_setvalue(wxObjectPtr, value)
	End Method
	
End Type



Rem
bbdoc: This event class is used for the events generated by wxSpinButton and wxSpinCtrl.
End Rem
Type wxSpinEvent Extends wxNotifyEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxSpinEvent = New wxSpinEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

	Rem
	bbdoc: Retrieve the current spin button or control value.
	End Rem
	Method GetPosition:Int()
		Return bmx_wxspinevent_getposition(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Set the value associated with the event.
	End Rem
	Method SetPosition(pos:Int)
		bmx_wxspinevent_setposition(wxEventPtr, pos)
	End Method
	
End Type


Type TSpinEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		Select evt.eventType
			Case wxEVT_SPIN_UP, ..
					wxEVT_SPIN_DOWN, ..
					wxEVT_SPIN
				Return wxSpinEvent.Create(wxEventPtr, evt)
		End Select
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		Select eventType
			Case wxEVT_SPIN_UP, ..
					wxEVT_SPIN_DOWN, ..
					wxEVT_SPIN
				Return bmx_wxspinbutton_geteventtype(eventType)
		End Select
	End Method
		
End Type

New TSpinEventFactory


Type TSpinButtonResourceFactory Extends TXMLResourceFactory

	Method AddHandler()
		bmx_wxspinbutton_addresourcehandler()
	End Method
		
End Type

New TSpinButtonResourceFactory
