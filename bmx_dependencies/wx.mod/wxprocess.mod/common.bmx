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

	Function bmx_wxprocess_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int)
	Function bmx_wxprocess_createwithflags:Byte Ptr(handle:Object, flags:Int)
	Function bmx_wxprocess_closeoutput(handle:Byte Ptr)
	Function bmx_wxprocess_detach(handle:Byte Ptr)
	Function bmx_wxprocess_geterrorstream:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxprocess_getintputstream:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxprocess_getoutputstream:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxprocess_iserroravailable:Int(handle:Byte Ptr)
	Function bmx_wxprocess_isinputavailable:Int(handle:Byte Ptr)
	Function bmx_wxprocess_isinputopened:Int(handle:Byte Ptr)
	Function bmx_wxprocess_kill:Int(pid:Int, signal:Int, flags:Int)
	Function bmx_wxprocess_exists:Int(pid:Int)
	Function bmx_wxprocess_open:Byte Ptr(cmd:String, flags:Int)
	Function bmx_wxprocess_getpid:Int(handle:Byte Ptr)
	Function bmx_wxprocess_redirect(handle:Byte Ptr)
	Function bmx_wxprocess_free(handle:Byte Ptr)
	Function bmx_wxprocess_onterminate(handle:Byte Ptr, pid:Int, status:Int)

	Function bmx_wxshell:Int(command:String)
	Function bmx_wxshutdown:Int(flags:Int)
	Function bmx_wxgetprocessid:Int()
	Function 	bmx_wxexit()
	Function bmx_wxkill:Int(pid:Int, signal:Int, rc:Int Ptr, flags:Int)
	Function bmx_wxexecute:Int(command:String, sync:Int, callback:Byte Ptr)

	Function bmx_wxprocess_geteventtype:Int(evt:Int)
	Function bmx_wxprocessevent_getpid:Int(handle:Byte Ptr)
	Function bmx_wxprocessevent_getexitcode:Int(handle:Byte Ptr)

End Extern

Const wxEVT_END_PROCESS:Int = -440

Const wxSIGNONE:Int = 0
Const wxSIGHUP:Int = 1
Const wxSIGINT:Int = 2
Const wxSIGQUIT:Int = 3
Const wxSIGILL:Int = 4
Const wxSIGTRAP:Int = 5
Const wxSIGABRT:Int = 6
Const wxSIGIOT:Int = wxSIGABRT
Const wxSIGEMT:Int = 7
Const wxSIGFPE:Int = 8
Const wxSIGKILL:Int = 9
Const wxSIGBUS:Int = 10
Const wxSIGSEGV:Int = 11
Const wxSIGSYS:Int = 12
Const wxSIGPIPE:Int = 13
Const wxSIGALRM:Int = 14
Const wxSIGTERM:Int = 15

Rem
bbdoc: No error.
End Rem
Const wxKILL_OK:Int = 0
Rem
bbdoc: No such signal.
End Rem
Const wxKILL_BAD_SIGNAL:Int = 1
Rem
bbdoc: Permission denied.
End Rem
Const wxKILL_ACCESS_DENIED:Int = 2
Rem
bbdoc: No such process.
End Rem
Const wxKILL_NO_PROCESS:Int = 3
Rem
bbdoc: Another, unspecified error.
End Rem
Const wxKILL_ERROR:Int = 4

Rem
bbdoc: Don't kill children
End Rem
Const wxKILL_NOCHILDREN:Int = 0
Rem
bbdoc: Kill children
End Rem
Const wxKILL_CHILDREN:Int = 1

Rem
bbdoc: Force shutdown.
about: Can be combined with other flags (MSW-only)
End Rem
Const wxSHUTDOWN_FORCE:Int = 1
Rem
bbdoc: Power off the computer.
End Rem
Const wxSHUTDOWN_POWEROFF:Int = 2
Rem
bbdoc: Shutdown and reboot.
End Rem
Const wxSHUTDOWN_REBOOT:Int = 4
Rem
bbdoc: Close session (currently MSW-only)
End Rem
Const wxSHUTDOWN_LOGOFF:Int = 8

Const wxPROCESS_DEFAULT:Int = 0
Const wxPROCESS_REDIRECT:Int = 1

Const wxEXEC_ASYNC:Int = 0
Const wxEXEC_SYNC:Int = 1
Const wxEXEC_NOHIDE:Int = 2
Const wxEXEC_MAKE_GROUP_LEADER:Int = 4
Const wxEXEC_NODISABLE:Int = 8