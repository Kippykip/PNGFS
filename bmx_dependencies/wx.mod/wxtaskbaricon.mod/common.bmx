' Copyright (c) 2007-2018 Bruce A Henderson & Oliver Skawronek
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

Import wx.wx
Import wx.wxMenu
Import wx.wxIcon



' headers :-)
?linuxx86
Import "../lib/linux/wx/include/gtk3-unicode-release-static/*.h"
?linuxx64
Import "../lib/linuxx64/wx/include/gtk3-unicode-release-static/*.h"
?win32x86
Import "../lib/win32/mswu/*.h"
?win32x64
Import "../lib/win32x64/mswu/*.h"
?macosppc
Import "../lib/macosppc/wx/include/mac-unicode-release-static/*.h"
?macosx86
Import "../lib/macosx86/wx/include/mac-unicode-release-static/*.h"
?macosx64
Import "../lib/macosx64/wx/include/mac-unicode-release-static/*.h"
?raspberrypi
Import "../lib/raspberrypi/wx/include/gtk3-unicode-release-static/*.h"
?
Import "../include/*.h"

Import "glue.cpp"

Extern

	Function bmx_wxtaskbaricon_create:Byte Ptr(handle:Object, iconType:Int)
	Function bmx_wxtaskbaricon_createpopupmenu:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxtaskbaricon_isiconinstalled:Int(handle:Byte Ptr)
	Function bmx_wxtaskbaricon_isok:Int(handle:Byte Ptr)
	Function bmx_wxtaskbaricon_removeicon:Int(handle:Byte Ptr)
	Function bmx_wxtaskbaricon_seticon:Int(handle:Byte Ptr, icon:Byte Ptr, tooltip:String)
	Function bmx_wxtaskbaricon_free(handle:Byte Ptr)
	Function bmx_wxtaskbaricon_isavailable:Int()

	Function bmx_wxtaskbariconevent_geteventtype:Int(evt:Int)

End Extern

Const wxEVT_TASKBAR_MOVE:Int = 1550
Const wxEVT_TASKBAR_LEFT_DOWN:Int = 1551
Const wxEVT_TASKBAR_LEFT_UP:Int = 1552
Const wxEVT_TASKBAR_RIGHT_DOWN:Int = 1553
Const wxEVT_TASKBAR_RIGHT_UP:Int = 1554
Const wxEVT_TASKBAR_LEFT_DCLICK:Int = 1555
Const wxEVT_TASKBAR_RIGHT_DCLICK:Int = 1556
?win32
	Const wxEVT_TASKBAR_CLICK:Int = wxEVT_TASKBAR_RIGHT_UP
?Not win32
	Const wxEVT_TASKBAR_CLICK:Int = wxEVT_TASKBAR_RIGHT_DOWN
?

Const wxTBI_DOCK:Int = 0
Const wxTBI_CUSTOM_STATUSITEM:Int = 1
?macos
Const wxTBI_DEFAULT_TYPE:Int = wxTBI_CUSTOM_STATUSITEM
?Not macos
Const wxTBI_DEFAULT_TYPE:Int = wxTBI_DOCK
?
