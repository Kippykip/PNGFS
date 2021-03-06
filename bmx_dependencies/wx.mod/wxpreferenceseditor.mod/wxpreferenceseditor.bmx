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

Module wx.wxPreferencesEditor

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
bbdoc: Manage preferences dialog.
about: This type encapsulates the differences – both in appearance and behaviour – between preferences dialogs on different
platforms. In particular, OS X preferences look very different from the typical notebook control used on other platforms,
and both OS X and GTK+ preferences windows are modeless unlike Windows options dialogs that are typically modal.

#wxPreferencesEditor is able to hide the differences by hiding the creation of preferences window from the API.
Instead, you create an instance of #wxPreferencesEditor and add page descriptions in the form of #wxPreferencesPage
using its AddPage() method. After setting up the editor object, you must call Show() to present preferences to the user.
End Rem
Type wxPreferencesEditor

	Field editorPtr:Byte Ptr

	Rem
	bbdoc: Creates an empty editor, use #AddPage() to add controls to it.
	End Rem
	Method Create:wxPreferencesEditor(title:String = "")
		editorPtr = bmx_wxpreferenceseditor_create(Self, title)
		Return Self
	End Method
	
	Rem
	bbdoc: Adds a New page To the editor.
	about: The editor takes ownership of the page and will delete it from its destructor (but not sooner).
	End Rem
	Method AddPage(page:wxPreferencesPage)
		bmx_wxpreferenceseditor_addpage(editorPtr, page.pagePtr)
	End Method
	
	Rem
	bbdoc: Hides the currently shown dialog, if any.
	about: This is typically called to dismiss the dialog if the object whose preferences it is editing was closed.
	End Rem
	Method Dismiss()
		bmx_wxpreferenceseditor_dismiss(editorPtr)
	End Method
	
	Rem
	bbdoc: Shows the preferences dialog or bring it to the top if it's already shown.
	about: Notice that this method may or may not block depending on the platform, i.e. depending on whether the dialog is modal or not.
	End Rem
	Method Show(parent:wxWindow)
		bmx_wxpreferenceseditor_show(editorPtr, parent.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns whether changes to values in preferences pages should be applied immediately or only when the user clicks the OK button.
	about: Currently, changes are applied immediately on OS X and GTK+.

	The preprocessor macro wxHAS_PREF_EDITOR_APPLY_IMMEDIATELY is defined in this case as well. Returns whether the preferences dialog is shown modally.

	If this method returns false, as it currently does in wxGTK and wxOSX, Show() simply makes the dialog visible and returns immediately.
	If it returns true, as it does in wxMSW and under the other platforms, then the dialog is shown modally, i.e. Show() blocks until the user dismisses it.

	Notice that it isn't necessary to test the return value of this method to use this class normally, its interface is
	designed to work in both cases. However it can sometimes be necessary to call it if the program needs to handle modal
	dialogs specially, e.g. perhaps to block some periodic background update operation while a modal dialog is shown.
	End Rem
	Function ShouldApplyChangesImmediately:Int()
		Return bmx_wxpreferenceseditor_shouldapplychangesimmediately()
	End Function

End Type

