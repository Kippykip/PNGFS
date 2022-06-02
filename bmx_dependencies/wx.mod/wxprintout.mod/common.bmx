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
Import wx.wxPageSetupDialogData



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
	Function bmx_wxprintout_create:Byte Ptr(handle:Object, title:String)
	Function bmx_printout_delete(handle:Byte Ptr)

	Function bmx_wxprintout_getdc:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxprintout_getpagesizemm(handle:Byte Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxprintout_getpagesizepixels(handle:Byte Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxprintout_getpaperrectpixels(handle:Byte Ptr, x:Int Ptr, y:Int Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxprintout_getpaperrectpixelsrect:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxprintout_getppiprinter(handle:Byte Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxprintout_getppiscreen(handle:Byte Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxprintout_gettitle:String(handle:Byte Ptr)
	Function bmx_wxprintout_ispreview:Int(handle:Byte Ptr)
	Function bmx_wxprintout_fitthissizetopaper(handle:Byte Ptr, w:Int, h:Int)
	Function bmx_wxprintout_fitthissizetopage(handle:Byte Ptr, w:Int, h:Int)
	Function bmx_wxprintout_fitthissizetopagemargins(handle:Byte Ptr, w:Int, h:Int, pageSetupData:Byte Ptr)
	Function bmx_wxprintout_mapscreensizetopaper(handle:Byte Ptr)
	Function bmx_wxprintout_mapscreensizetopage(handle:Byte Ptr)
	Function bmx_wxprintout_mapscreensizetopagemargins(handle:Byte Ptr, pageSetupData:Byte Ptr)
	Function bmx_wxprintout_mapscreensizetodevice(handle:Byte Ptr)
	Function bmx_wxprintout_getlogicalpaperrect(handle:Byte Ptr, x:Int Ptr, y:Int Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxprintout_getlogicalpaperrectrect:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxprintout_getlogicalpagerect(handle:Byte Ptr, x:Int Ptr, y:Int Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxprintout_getlogicalpagerectrect:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxprintout_getlogicalpagemarginsrect(handle:Byte Ptr, x:Int Ptr, y:Int Ptr, w:Int Ptr, h:Int Ptr, pageSetupData:Byte Ptr)
	Function bmx_wxprintout_getlogicalpagemarginsrectrect:Byte Ptr(handle:Byte Ptr, pageSetupData:Byte Ptr)
	Function bmx_wxprintout_setlogicalorigin(handle:Byte Ptr, x:Int, y:Int)
	Function bmx_wxprintout_offsetlogicalorigin(handle:Byte Ptr, xOff:Int, yOff:Int)

End Extern
