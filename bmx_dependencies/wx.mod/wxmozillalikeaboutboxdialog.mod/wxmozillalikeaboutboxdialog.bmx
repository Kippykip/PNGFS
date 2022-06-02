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
bbdoc: wxMozillaLikeAboutDialog
End Rem
Module wx.wxMozillaLikeAboutBoxDialog

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
bbdoc: 
End Rem
Type wxMozillaLikeAboutBoxDialog Extends wxDialog

	Rem
	bbdoc: 
	End Rem
	Function CreateDialog:wxMozillaLikeAboutBoxDialog(parent:wxWindow, id:Int = 10000, caption:String = "About ", x:Int = -1, y:Int = -1, ..
			w:Int = 400, h:Int = 300, style:Int = wxCAPTION | wxSYSTEM_MENU | wxCLOSE_BOX | wxTAB_TRAVERSAL)
		Return New wxMozillaLikeAboutBoxDialog.Create(parent, id, caption, x, y, w, h, style)
	End Function

	Rem
	bbdoc: 
	End Rem
	Method Create:wxMozillaLikeAboutBoxDialog(parent:wxWindow, id:Int = 10000, caption:String = "About ", x:Int = -1, y:Int = -1, ..
			w:Int = 400, h:Int = 300, style:Int = wxCAPTION | wxSYSTEM_MENU | wxCLOSE_BOX | wxTAB_TRAVERSAL)
		wxObjectPtr = bmx_wxmozillalikeaboutdialog_create(Self, parent.wxObjectPtr, id, caption, x, y, w, h, style)
		OnInit()
		Return Self
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetAppName:String()
		Return bmx_wxmozillalikeaboutdialog_getappname(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetAppName(value:String)
		bmx_wxmozillalikeaboutdialog_setappname(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetVersion:String()
		Return bmx_wxmozillalikeaboutdialog_getversion(wxObjectPtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetVersion(value:String)
		bmx_wxmozillalikeaboutdialog_setversion(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetCopyright:String()
		Return bmx_wxmozillalikeaboutdialog_getcopyright(wxObjectPtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetCopyright(value:String)
		bmx_wxmozillalikeaboutdialog_setcopyright(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetCustomBuildInfo:String()
		Return bmx_wxmozillalikeaboutdialog_getcustombuildinfo(wxObjectPtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetCustomBuildInfo(value:String)
		bmx_wxmozillalikeaboutdialog_setcustombuildinfo(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetBitmapResource:wxBitmap(name:String)
		Return wxBitmap._create(bmx_wxmozillalikeaboutdialog_getbitmapresource(wxObjectPtr, name))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetIconResource:wxIcon(name:String)
		Return wxIcon._create(bmx_wxmozillalikeaboutdialog_geticonresource(wxObjectPtr, name))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Function GetBuildInfo:String(format:Int)
		Return bmx_wxmozillalikeaboutdialog_getbuildinfo(format:Int)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method SetHeaderBitmap(value:wxBitmap)
		bmx_wxmozillalikeaboutdialog_setheaderbitmap(wxObjectPtr, value.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ApplyInfo()
		bmx_wxmozillalikeaboutdialog_applyinfo(wxObjectPtr)
	End Method


End Type


