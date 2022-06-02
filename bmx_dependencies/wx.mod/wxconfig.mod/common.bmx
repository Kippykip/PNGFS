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

	Function bmx_wxconfigbase_set:Byte Ptr(config:Byte Ptr)
	Function bmx_wxconfigbase_get:Byte Ptr(onDemand:Int)

	Function bmx_wxconfigbase_dontcreateondemand(handle:Byte Ptr)

	Function bmx_wxconfigbase_deleteall:Int(handle:Byte Ptr)
	Function bmx_wxconfigbase_deleteentry:Int(handle:Byte Ptr, key:String, deleteGroupIfEmpty:Int)
	Function bmx_wxconfigbase_deletegroup:Int(handle:Byte Ptr, key:String)
	Function bmx_wxconfigbase_exists:Int(handle:Byte Ptr, name:String)
	Function bmx_wxconfigbase_flush:Int(handle:Byte Ptr, currentOnly:Int)
	Function bmx_wxconfigbase_getappname:String(handle:Byte Ptr)
	Function bmx_wxconfigbase_getentrytype:Int(handle:Byte Ptr, name:String)
	Function bmx_wxconfigbase_getfirstgroup:String(handle:Byte Ptr, index:Int Ptr, cont:Int Ptr)
	Function bmx_wxconfigbase_getfirstentry:Int(handle:Byte Ptr, name:String, index:Int Ptr)
	Function bmx_wxconfigbase_getnextgroup:String(handle:Byte Ptr, index:Int Ptr, cont:Int Ptr)
	Function bmx_wxconfigbase_getnextentry:Int(handle:Byte Ptr, name:String, index:Int Ptr)
	Function bmx_wxconfigbase_getnumberofentries:Int(handle:Byte Ptr, recursive:Int)
	Function bmx_wxconfigbase_getnumberofgroups:Int(handle:Byte Ptr, recursive:Int)
	Function bmx_wxconfigbase_getpath:String(handle:Byte Ptr)
	Function bmx_wxconfigbase_getvendorname:String(handle:Byte Ptr)
	Function bmx_wxconfigbase_hasentry:Int(handle:Byte Ptr, name:String)
	Function bmx_wxconfigbase_hasgroup:Int(handle:Byte Ptr, name:String)
	Function bmx_wxconfigbase_isexpandingenvvars:Int(handle:Byte Ptr)
	Function bmx_wxconfigbase_isrecordingdefaults:Int(handle:Byte Ptr)
	Function bmx_wxconfigbase_readstring:String(handle:Byte Ptr, key:String, defaultValue:String)
	Function bmx_wxconfigbase_readint:Int(handle:Byte Ptr, key:String, defaultValue:Int)
	Function bmx_wxconfigbase_readbool:Int(handle:Byte Ptr, key:String, defaultValue:Int)
	Function bmx_wxconfigbase_readdouble:Double(handle:Byte Ptr, key:String, defaultValue:Double)
	Function bmx_wxconfigbase_renameentry:Int(handle:Byte Ptr, oldName:String, newName:String)
	Function bmx_wxconfigbase_renamegroup:Int(handle:Byte Ptr, oldName:String, newName:String)
	Function bmx_wxconfigbase_setexpandenvvars(handle:Byte Ptr, doIt:Int)
	Function bmx_wxconfigbase_setpath(handle:Byte Ptr, path:String)
	Function bmx_wxconfigbase_setrecorddefaults(handle:Byte Ptr, doIt:Int)
	Function bmx_wxconfigbase_writestring:Int(handle:Byte Ptr, key:String, value:String)
	Function bmx_wxconfigbase_writeint:Int(handle:Byte Ptr, key:String, value:Int)
	Function bmx_wxconfigbase_writebool:Int(handle:Byte Ptr, key:String, value:Int)
	Function bmx_wxconfigbase_writedouble:Int(handle:Byte Ptr, key:String, value:Double)

	Function bmx_wxconfigbase_free(handle:Byte Ptr)

End Extern

Const wxCONFIG_USE_LOCAL_FILE:Int = 1
Const wxCONFIG_USE_GLOBAL_FILE:Int = 2
Const wxCONFIG_USE_RELATIVE_PATH:Int = 4
Const wxCONFIG_USE_NO_ESCAPE_CHARACTERS:Int = 8
Const wxCONFIG_USE_SUBDIR:Int = 16
