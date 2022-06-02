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
Import wx.wxDC
Import wx.wxDialog
Import wx.wxPrintData



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

	Function bmx_wxprintdialog_getprintdialogdata:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxprintdialog_getprintdc:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxprintdialog_showmodal:Int(handle:Byte Ptr)

	Function bmx_wxprintdialogdata_create:Byte Ptr(printData:Byte Ptr)
	Function bmx_wxprintdialogdata_delete(handle:Byte Ptr)

	Function bmx_wxprintdialogdata_enablehelp(handle:Byte Ptr, flag:Int)
	Function bmx_wxprintdialogdata_enablepagenumbers(handle:Byte Ptr, flag:Int)
	Function bmx_wxprintdialogdata_enableprinttofile(handle:Byte Ptr, flag:Int)
	Function bmx_wxprintdialogdata_enableselection(handle:Byte Ptr, flag:Int)
	Function bmx_wxprintdialogdata_getallpages:Int(handle:Byte Ptr)
	Function bmx_wxprintdialogdata_getcollate:Int(handle:Byte Ptr)
	Function bmx_wxprintdialogdata_getfrompage:Int(handle:Byte Ptr)
	Function bmx_wxprintdialogdata_getmaxpage:Int(handle:Byte Ptr)
	Function bmx_wxprintdialogdata_getminpage:Int(handle:Byte Ptr)
	Function bmx_wxprintdialogdata_getnocopies:Int(handle:Byte Ptr)
	Function bmx_wxprintdialogdata_getprintdata:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxprintdialogdata_getprinttofile:Int(handle:Byte Ptr)
	Function bmx_wxprintdialogdata_getselection:Int(handle:Byte Ptr)
	Function bmx_wxprintdialogdata_gettopage:Int(handle:Byte Ptr)
	Function bmx_wxprintdialogdata_isok:Int(handle:Byte Ptr)
	Function bmx_wxprintdialogdata_setcollate(handle:Byte Ptr, flag:Int)
	Function bmx_wxprintdialogdata_setfrompage(handle:Byte Ptr, page:Int)
	Function bmx_wxprintdialogdata_setmaxpage(handle:Byte Ptr, page:Int)
	Function bmx_wxprintdialogdata_setminpage(handle:Byte Ptr, page:Int)
	Function bmx_wxprintdialogdata_setnocopies(handle:Byte Ptr, count:Int)
	Function bmx_wxprintdialogdata_setprintdata(handle:Byte Ptr, printdata:Byte Ptr)
	Function bmx_wxprintdialogdata_setprinttofile(handle:Byte Ptr, flag:Int)
	Function bmx_wxprintdialogdata_setselection(handle:Byte Ptr, flag:Int)
	Function bmx_wxprintdialogdata_settopage(handle:Byte Ptr, page:Int)

	Function bmx_wxprintdialog_create:Byte Ptr(handle:Object, parent:Byte Ptr, data:Byte Ptr)

End Extern
