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

Import wx.wx
Import wx.wxPickerBase



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

	Function bmx_wxfilepickerctrl_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, path:String, ..
		message:String, wildcard:String, x:Int, y:Int, w:Int, h:Int, style:Int)
	Function bmx_wxfilepickerctrl_getpath:String(handle:Byte Ptr)
	Function bmx_wxfilepickerctrl_setpath(handle:Byte Ptr, filename:String)

	Function bmx_wxdirpickerctrl_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, path:String, ..
		message:String, x:Int, y:Int, w:Int, h:Int, style:Int)
	Function bmx_wxdirpickerctrl_getpath:String(handle:Byte Ptr)
	Function bmx_wxdirpickerctrl_setpath(handle:Byte Ptr, dirname:String)

	Function bmx_wxfiledirpickerevent_getpath:String(handle:Byte Ptr)
	Function bmx_wxfiledirpickerevent_setpath(handle:Byte Ptr, path:String)

	Function bmx_wxfilepickerctrl_geteventtype:Int(evt:Int)
	
	Function bmx_wxfiledir_addresourcehandler()
	
End Extern


Const wxEVT_COMMAND_FILEPICKER_CHANGED:Int = 11021
Const wxEVT_COMMAND_DIRPICKER_CHANGED:Int = 11031

Const wxFLP_USE_TEXTCTRL:Int = wxPB_USE_TEXTCTRL
Const wxDIRP_USE_TEXTCTRL:Int = wxPB_USE_TEXTCTRL

Const wxFLP_OPEN:Int = $0400
Const wxFLP_SAVE:Int = $0800
Const wxFLP_OVERWRITE_PROMPT:Int = $1000
Const wxFLP_FILE_MUST_EXIST:Int = $2000
Const wxFLP_CHANGE_DIR:Int = $4000

Const wxDIRP_DIR_MUST_EXIST:Int = $0008
Const wxDIRP_CHANGE_DIR:Int = $0010

?linux
Const wxFLP_DEFAULT_STYLE:Int = wxFLP_OPEN | wxFLP_FILE_MUST_EXIST
Const wxDIRP_DEFAULT_STYLE:Int = wxDIRP_DIR_MUST_EXIST
?macos
Const wxFLP_DEFAULT_STYLE:Int = wxFLP_USE_TEXTCTRL | wxFLP_OPEN | wxFLP_FILE_MUST_EXIST
Const wxDIRP_DEFAULT_STYLE:Int = wxDIRP_USE_TEXTCTRL | wxDIRP_DIR_MUST_EXIST
?win32
Const wxFLP_DEFAULT_STYLE:Int = wxFLP_USE_TEXTCTRL | wxFLP_OPEN | wxFLP_FILE_MUST_EXIST
Const wxDIRP_DEFAULT_STYLE:Int = wxDIRP_USE_TEXTCTRL | wxDIRP_DIR_MUST_EXIST
?


