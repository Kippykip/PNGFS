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
'
' The core event stuff...
'
'
SuperStrict

Import "base.bmx"


Private
Global event_factories:TEventFactory
Public

Rem
bbdoc: An event is a structure holding information about an event passed to a callback or member function.
about: It is an abstract base type for other event types.
End Rem
Type wxEvent

	Field wxEventPtr:Byte Ptr
	
	Rem
	bbdoc: The user data passed into the initial Connect(), if any.
	End Rem
	Field userData:Object
	
	Rem
	bbdoc: The owning object for this event.
	about: Generally, this would be the object from which Connect() was called.
	End Rem
	Field parent:wxEvtHandler

	Rem
	bbdoc: The owning object for this event.
	about: Generally, this would be the object from which Connect() was called.
	End Rem
	Field sink:wxEvtHandler
	
	Field eventType:Int
	
	Field customEventPtr:Byte Ptr
	
	Method init(eventPtr:Byte Ptr, evt:TEventHandler)
		wxEventPtr = eventPtr
		userData = evt.userData
		parent = evt.parent
		sink = evt.eventSink
		eventType = evt.eventType
	End Method

	Rem
	bbdoc: Returns the object (usually a window) associated with the event, if any.
	End Rem
	Method GetEventObject:wxObject()
		Local objPtr:Byte Ptr = bmx_wxevent_geteventobject(wxEventPtr)
		If objPtr Then
			Local obj:wxObject = wxObject(wxfind(objPtr))
			Return obj
		End If
	End Method

	Rem
	bbdoc: 
	End Rem	
	Method SetEventObject(obj:wxObject)
		bmx_wxevent_seteventobject(wxEventPtr, obj.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the identifier of the given event type, such as wxEVT_COMMAND_BUTTON_CLICKED.
	End Rem
	Method GetEventType:Int()
		Return eventType
		'Return bmx_wxevent_geteventtype(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns the identifier associated with this event, such as a button command id.
	End Rem
	Method GetId:Int()
		Return bmx_wxevent_getid(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the event handler should be skipped, false otherwise.
	End Rem
	Method GetSkipped:Int()
		Return bmx_wxevent_getskipped(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Gets the timestamp for the event.
	about: The timestamp is the time in milliseconds since some fixed moment (not necessarily the 
	standard Unix Epoch, so only differences between the timestamps and not their absolute values
	usually make sense).
	End Rem
	Method GetTimestamp:Int()
		Return bmx_wxevent_gettimestamp(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the event is or is derived from wxCommandEvent else it returns false.
	about: Exists only for optimization purposes.
	End Rem
	Method IsCommandEvent:Int()
		Return bmx_wxevent_iscommandevent(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Sets the propagation level to the given value (for example returned from an earlier call to StopPropagation).
	End Rem
	Method ResumePropagation(propagationLevel:Int)
		bmx_wxevent_resumepropagation(wxEventPtr, propagationLevel)
	End Method
	
	Rem
	bbdoc: Test If this event should be propagated Or Not, i.e. If the propagation level is currently greater than 0.
	End Rem
	Method ShouldPropagate:Int()
		Return bmx_wxevent_shouldpropagate(wxEventPtr)
	End Method
	
	Rem
	bbdoc: This method can be used inside an event handler to control whether further event handlers bound to this event will be called after the current one returns.
	about: Without Skip() (or equivalently if Skip(false) is used), the event will not be processed any more.
	If Skip(true) is called, the event processing system continues searching for a further handler function
	for this event, even though it has been processed already in the current handler.
	<p>
	In general, it is recommended to skip all non-command events to allow the default handling to take
	place. The command events are, however, normally not skipped as usually a single command such as a
	button click or menu item selection must only be processed by one handler.
	</p>
	End Rem
	Method Skip(_skip:Int = True)
		bmx_wxevent_skip(wxEventPtr, _skip)
	End Method
	
	Rem
	bbdoc: Stop the event from propagating to its parent window.
	about: Returns the old propagation level value which may be later passed to ResumePropagation to
	allow propagating the event again.
	End Rem
	Method StopPropagation:Int()
		Return bmx_wxevent_stoppropagation(wxEventPtr)
	End Method
	
	Method NewEvent:wxEvent(evtType:Int, winId:Int = 0)
	End Method
	
	Rem
	bbdoc: Return the user data associated with a dynamically connected event handler. 
	End Rem
	Method GetEventUserData:Object()
		Return userData
	End Method
	
	Rem
	bbdoc: Returns the parent event handler for this event.
	End Rem
	Method GetParent:wxEvtHandler()
		Return parent
	End Method
	
	Method Delete()
		If customEventPtr Then
			bmx_wxevent_delete(customEventPtr)
			customEventPtr = Null
		End If
	End Method
		
End Type

Rem
bbdoc: This event type contains information about command events, which originate from a variety of simple controls.
about: More complex controls, such as wxTreeCtrl, have separate command event classes.
<p><b>Event Handling</b>
<ul>
<li><tt>wxEVT_COMMAND_BUTTON_CLICKED </tt> - Process a command event, which is generated by a wxButton control.</li>
<li><tt>wxEVT_COMMAND_CHECKBOX_CLICKED </tt> - Process a command event, which is generated by a wxCheckBox control. </li>
<li><tt>wxEVT_COMMAND_CHOICE_SELECTED </tt> - Process a command event, which is generated by a wxChoice control. </li>
<li><tt>wxEVT_COMMAND_COMBOBOX_SELECTED </tt> - Process a command event, which is generated by a wxComboBox control. </li>
<li><tt>wxEVT_COMMAND_LISTBOX_SELECTED </tt> - Process a command event, which is generated by a wxListBox control. </li>
<li><tt>wxEVT_COMMAND_LISTBOX_DOUBLECLICKED </tt> - Process a command event, which is generated by a wxListBox control. </li>
<li><tt>wxEVT_COMMAND_MENU_SELECTED </tt> - Process a command event, which is generated by a menu item. </li>
<li><tt>wxEVT_COMMAND_MENU_RANGE </tt> - Process a command event, which is generated by a range of menu items. </li>
<li><tt>wxEVT_CONTEXT_MENU</tt> - Process the event generated when the user has requested a popup menu to appear by pressing a special keyboard key (under Windows) or by right clicking the mouse. </li>
<li><tt>wxEVT_COMMAND_RADIOBOX_SELECTED</tt> - Process a command event, which is generated by a wxRadioBox control. </li>
<li><tt>wxEVT_COMMAND_RADIOBUTTON_SELECTED</tt> - Process a command event, which is generated by a wxRadioButton control. </li>
<li><tt>wxEVT_COMMAND_SCROLLBAR_UPDATED</tt> - Process a command event, which is generated by a wxScrollBar control. This is provided for compatibility only; more specific scrollbar event macros should be used instead (see wxScrollEvent). </li>
<li><tt>wxEVT_COMMAND_SLIDER_UPDATED</tt> - Process a command event, which is generated by a wxSlider control. </li>
<li><tt>wxEVT_COMMAND_TEXT_UPDATED</tt> - Process a command event, which is generated by a wxTextCtrl control. </li>
<li><tt>wxEVT_COMMAND_TEXT_ENTER</tt> - Process a command event, which is generated by a wxTextCtrl control. Note that you must use wxTE_PROCESS_ENTER flag when creating the control if you want it to generate such events. </li>
<li><tt>wxEVT_COMMAND_TEXT_MAXLEN</tt> - Process a command event, which is generated by a wxTextCtrl control when the user tries to enter more characters into it than the limit previously set with SetMaxLength. </li>
<li><tt>wxEVT_COMMAND_TOGGLEBUTTON_CLICKED</tt> - Process a command event, which is generated by a wxToggleButton control. </li>
<li><tt>wxEVT_COMMAND_TOOL_CLICKED</tt> - Process a tool clicked event (a synonym for wxEVT_COMMAND_MENU_SELECTED). Pass the id of the tool. </li>
<li><tt>wxEVT_COMMAND_TOOL_RCLICKED</tt> - Process a tool right-clicked event. Pass the id of the tool. </li>
<li><tt>wxEVT_COMMAND_TOOL_ENTER</tt> - Process a tool enter event. Pass the id of the toolbar itself. The value of wxCommandEvent::GetSelection is the tool id, or -1 if the mouse cursor has moved off a tool. </li>
<li><tt>wxEVT_COMMAND_ENTER</tt> - Process a enter command, which is generated by a control. </li>
</ul>
</p>
End Rem
Type wxCommandEvent Extends wxEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxCommandEvent = New wxCommandEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function
	
	Rem
	bbdoc: Creates a new command event.
	End Rem
	Function CreateEvent:wxCommandEvent(evtType:Int, winId:Int = 0)

		' find the "real" event id
		Local factory:TEventFactory = event_factories
		Local evt:Int

		While factory
			evt = factory.GetEventType(evtType)
			If evt Exit
			factory = factory._succ
		Wend
		
		' if we have a real id... create the event and return a valid object
		If evt Then
			Local this:wxCommandEvent = New wxCommandEvent
			this.customEventPtr = bmx_wxcommandevent_create(evt, winId)
			this.wxEventPtr = bmx_wxevent_getcustref(this.customEventPtr)
			Return this
		End If
		
	End Function

	Rem
	bbdoc: 
	End Rem
	Method NewEvent:wxCommandEvent(evtType:Int, winId:Int = 0)
		customEventPtr = bmx_wxcommandevent_create(_GetCustomEventType(evtType), winId)
		wxEventPtr = bmx_wxevent_getcustref(customEventPtr)
		Return Self
	End Method
	
	Rem
	bbdoc: Returns item index for a listbox or choice selection event (not valid for a deselection).
	End Rem
	Method GetSelection:Int()
		Return bmx_wxcommandevent_getselection(wxEventPtr)
	End Method
	
	Rem
	bbdoc: This method can be used with checkbox and menu events.
	about: For the checkboxes, the method returns true for a selection event and false for a deselection one.
	For the menu events, this method indicates if the menu item just has become checked or unchecked
	(and thus only makes sense for checkable menu items).
	End Rem
	Method IsChecked:Int()
		Return bmx_wxcommandevent_ischecked(wxEventPtr)
	End Method
	
	Rem
	bbdoc: For a listbox or similar event, returns True if it is a selection, False if it is a deselection.
	End Rem
	Method IsSelection:Int()
		Return bmx_wxcommandevent_isselection(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns item string for a listbox or choice selection event (not valid for a deselection).
	End Rem
	Method GetString:String()
		Return bmx_wxcommandevent_getstring(wxEventPtr)
	End Method

	Rem
	bbdoc: Returns extra information dependant on the event objects type.
	about: If the event comes from a listbox selection, it is a boolean determining whether the event was a
	selection (true) or a deselection (false). A listbox deselection only occurs for multiple-selection boxes,
	and in this case the index and string values are indeterminate and the listbox must be examined by the
	application.
	End Rem
	Method GetExtra:Int()
		Return bmx_wxcommandevent_getextralong(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns the integer identifier corresponding to a listbox, choice or radiobox selection (only if the event was a selection, not a deselection), or a boolean value representing the value of a checkbox.
	End Rem
	Method GetInt:Int()
		Return bmx_wxcommandevent_getint(wxEventPtr)
	End Method

	Rem
	bbdoc: Returns client data for a listbox or choice selection event (not valid for a deselection).
	End Rem
	Method GetClientData:Object()
		Return bmx_wxcommandevent_getclientdata(wxEventPtr)
	End Method

	Rem
	bbdoc: Sets the client data for this event.
	End Rem
	Method SetClientData(data:Object)
		bmx_wxcommandevent_setclientdata(wxEventPtr, data)
	End Method
	
	Rem
	bbdoc: Sets the string property.
	End Rem
	Method SetString(value:String)
		bmx_wxcommandevent_setstring(wxEventPtr, value)
	End Method
	
	Rem
	bbdoc: Sets the int property.
	End Rem
	Method SetInt(value:Int)
		bmx_wxcommandevent_setint(wxEventPtr, value)
	End Method
	
End Type

Rem
bbdoc: This event type contains information about window and session close events.
about: The handler function for wxEVT_CLOSE is called when the user has tried to close a a frame or
dialog box using the window manager (X) or system menu (Windows). It can also be invoked by the
application itself programmatically, for example by calling the wxWindow::Close function.
<p>
You should check whether the application is forcing the deletion of the window using wxCloseEvent::CanVeto.
If this is false, you <b>must</b> destroy the window using wxWindow::Destroy. If the return value is true,
it is up to you whether you respond by destroying the window.
</p>
<p>
If you don't destroy the window, you should call wxCloseEvent::Veto to let the calling code know that
you did not destroy the window. This allows the wxWindow::Close function to return true or false depending
on whether the close instruction was honoured or not.
</p>
<p><b>Events handling</b>
<ul>
<li><tt>wxEVT_CLOSE</tt> - Process a close event. This event applies to wxFrame and wxDialog types. </li>
<li><tt>wxEVT_QUERY_END_SESSION</tt> - Process a query end session event. This event applies to wxApp only. /li>
<li><tt>wxEVT_END_SESSION</tt> - Process an end session event. This event applies to wxApp only. </li>
</ul>
</p>
End Rem
Type wxCloseEvent Extends wxEvent
	
	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxCloseEvent = New wxCloseEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

	Rem
	bbdoc: Returns true if you can veto a system shutdown or a window close event.
	about: Vetoing a window close event is not possible if the calling code wishes to force the
	application to exit, and so this function must be called to check this.
	End Rem
	Method CanVeto:Int()
		Return bmx_wxcloseevent_canveto(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the user is just logging off or false if the system is shutting down.
	about: This method can only be called for end session and query end session events, it doesn't make
	sense for close window event.
	End Rem
	Method GetLoggingOff:Int()
		Return bmx_wxcloseevent_getloggingoff(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Sets the 'can veto' flag.
	End Rem
	Method SetCanVeto(canVeto:Int)
		bmx_wxcloseevent_setcanveto(wxEventPtr, canVeto)
	End Method
	
	Rem
	bbdoc: Sets the 'logging off' flag.
	End Rem
	Method SetLoggingOff(loggingOff:Int)
		bmx_wxcloseevent_setloggingoff(wxEventPtr, loggingOff)
	End Method
	
	Rem
	bbdoc: Call this from your event handler to veto a system shutdown or to signal to the calling application that a window close did not happen.
	about: You can only veto a shutdown if wxCloseEvent::CanVeto returns true.
	End Rem
	Method Veto(value:Int = True)
		bmx_wxcloseevent_veto(wxEventPtr, value)
	End Method
	
End Type

Rem
bbdoc: A move event holds information about move change events.
about:
<p><b>Event Handling</b>
<ul>
<li><tt>wxEVT_MOVE</tt> - Process a move event, which is generated when a window is moved. </li>
</ul>
</p>
End Rem
Type wxMoveEvent Extends wxEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxMoveEvent = New wxMoveEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

	Rem
	bbdoc: Returns the position of the window generating the move change event.
	End Rem
	Method GetPosition(x:Int Var, y:Int Var)
		bmx_wxmoveevent_getposition(wxEventPtr, Varptr x, Varptr y)
	End Method
	
End Type

Rem
bbdoc: An event being sent when a top level window is maximized.
about: Notice that it is not sent when the window is restored to its original size after it had been maximized, only a
normal wxSizeEvent is generated in this case.
End Rem
Type wxMaximizeEvent Extends wxEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxMaximizeEvent = New wxMaximizeEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

End Type

Rem
bbdoc: This type is not used by the event handlers by itself, but is a base class for other event classes (such as wxNotebookEvent).
about: It (or an object of a derived type) is sent when the controls state is being changed and allows
the program to Veto() this change if it wants to prevent it from happening.
End Rem
Type wxNotifyEvent Extends wxCommandEvent

	Rem
	bbdoc: This is the opposite of Veto(): it explicitly allows the event to be processed.
	about: For most events it is not necessary to call this method as the events are allowed anyhow
	but some are forbidden by default (this will be mentioned in the corresponding event description).
	End Rem
	Method Allow()
		bmx_wxnotifyevent_allow(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns True if the change is allowed (Veto() hasn't been called) or False otherwise (if it was).
	End Rem
	Method IsAllowed:Int()
		Return bmx_wxnotifyevent_isallowed(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Prevents the change announced by this event from happening.
	about: It is in general a good idea to notify the user about the reasons for vetoing the change
	because otherwise the applications behaviour (which just refuses to do what the user wants) might
	be quite surprising.
	End Rem
	Method Veto()
		bmx_wxnotifyevent_veto(wxEventPtr)
	End Method
	
End Type

Rem
bbdoc: A size event holds information about size change events.
about: You may wish to use this for frames to resize their child windows as appropriate.
<p>
Note that the size passed is of the whole window: call wxWindow::GetClientSize for the area which may be
used by the application.
</p>
<p>
When a window is resized, usually only a small part of the window is damaged and you may only need to repaint
that area. However, if your drawing depends on the size of the window, you may need to clear the DC explicitly
and repaint the whole window. In which case, you may need to call wxWindow::Refresh to invalidate the entire window.
</p>
End Rem
Type wxSizeEvent Extends wxEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxSizeEvent = New wxSizeEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

	Rem
	bbdoc: Returns the entire size of the window generating the size change event.
	End Rem
	Method GetSize(width:Int Var, height:Int Var)
		bmx_wxsizeevent_getsize(wxEventPtr, Varptr width, Varptr height)
	End Method
	
End Type

Rem
bbdoc: A paint event is sent when a window's contents needs to be repainted.
about: Please notice that in general it is impossible to change the drawing of a standard control
(such as wxButton) and so you shouldn't attempt to handle paint events for them as even if it might
work on some platforms, this is inherently not portable and won't work everywhere.
End Rem
Type wxPaintEvent Extends wxEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxPaintEvent = New wxPaintEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

End Type


Rem
bbdoc: A scroll event holds information about events sent from scrolling windows.
End Rem
Type wxScrollWinEvent Extends wxEvent
	
	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxScrollWinEvent = New wxScrollWinEvent 
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function


End Type

Rem
bbdoc: A wxInitDialogEvent is sent as a dialog or panel is being initialised.
about: Handlers for this event can transfer data to the window. The default handler calls
wxWindow::TransferDataToWindow.
End Rem
Type wxInitDialogEvent Extends wxEvent
	
	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxInitDialogEvent = New wxInitDialogEvent 
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

End Type

Rem
bbdoc: An activate event is sent when a window or application is being activated or deactivated.
about: A top-level window (a dialog or frame) receives an activate event when it is being activated or
deactivated. This is indicated visually by the title bar changing colour, and a subwindow gaining the
keyboard focus.
<p>
An application is activated or deactivated when one of its frames becomes activated, or a frame becomes
inactivated resulting in all application frames being inactive.
</p>
<p>
Please note that usually you should call event.Skip() in your handlers for these events as not doing so can
result in strange effects.
</p>
End Rem
Type wxActivateEvent Extends wxEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxActivateEvent = New wxActivateEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function
	
	Rem
	bbdoc: Returns true if the application or window is being activated, false otherwise.
	End Rem
	Method GetActive:Int()
		Return bmx_wxactivateevent_getactive(wxEventPtr)
	End Method

End Type

Rem
bbdoc: An event being sent when the frame is iconized (minimized) or restored.
about: Currently only wxMSW and wxGTK generate such events.
End Rem
Type wxIconizeEvent Extends wxEvent
	
	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxIconizeEvent = New wxIconizeEvent 
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

	Rem
	bbdoc: Returns true if the frame has been iconized, false if it has been restored.
	End Rem
	Method Iconized:Int()
		Return bmx_wxiconizeevent_iconized(wxEventPtr)
	End Method
	
End Type

Rem
bbdoc: A scroll event holds information about events sent from stand-alone scrollbars and sliders.
about: Note that unless specifying a scroll control identifier, you will need to test for scrollbar
orientation with wxScrollEvent::GetOrientation, since horizontal and vertical scroll events are
processed using the same event handler.
End Rem
Type wxScrollEvent Extends wxCommandEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxScrollEvent = New wxScrollEvent 
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function
	
	Rem
	bbdoc: Returns wxHORIZONTAL or wxVERTICAL, depending on the orientation of the scrollbar.
	End Rem
	Method GetOrientation:Int()
		Return bmx_wxscrollevent_getorientation(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns the position of the scrollbar.
	End Rem
	Method GetPosition:Int()
		Return bmx_wxscrollevent_getposition(wxEventPtr)
	End Method

End Type

Rem
bbdoc: This type is used for context menu events, sent to give the application a chance to show a context (popup) menu.
End Rem
Type wxContextMenuEvent Extends wxCommandEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxContextMenuEvent = New wxContextMenuEvent 
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function
	
	Rem
	bbdoc: Returns the position at which the menu should be shown.
	End Rem
	Method GetPosition(x:Int Var, y:Int Var)
		bmx_wxcontextmenuevent_getposition(wxEventPtr, Varptr x, Varptr y)
	End Method
	
	Rem
	bbdoc: Sets the position at which the menu should be shown.
	End Rem
	Method SetPosition(x:Int, y:Int)
		bmx_wxcontextmenuevent_setposition(wxEventPtr, x, y)
	End Method

End Type


Rem
bbdoc: This event type contains information about keypress (character) events.
about: Notice that there are three different kinds of keyboard events in wxWidgets: key down and up events and
char events. The difference between the first two is clear - the first corresponds to a key press and the second
to a key release - otherwise they are identical. Just note that if the key is maintained in a pressed state you
will typically get a lot of (automatically generated) down events but only one up so it is wrong to assume that
there is one up event corresponding to each down one.
<p>
Both key events provide untranslated key codes while the char event carries the translated one. The untranslated
code for alphanumeric keys is always an upper case value. For the other keys it is one of WXK_XXX values from the
keycodes table. The translated key is, in general, the character the user expects to appear as the result of the key
combination when typing the text into a text entry zone, for example.
</p>
<p>
A few examples to clarify this (all assume that CAPS LOCK is unpressed and the standard US keyboard): when the
'A' key is pressed, the key down event key code is equal to ASCII A = 65. But the char event key code is ASCII
a = 97. On the other hand, if you press both SHIFT and 'A' keys simultaneously , the key code in key down event
will still be just 'A' while the char event key code parameter will now be 'A' as well.
</p>
<p>
Although in this simple case it is clear that the correct key code could be found in the key down event handler by
checking the value returned by ShiftDown(), in general you should use EVT_CHAR for this as for non-alphanumeric keys
the translation is keyboard-layout dependent and can only be done properly by the system itself.
</p>
<p>
Another kind of translation is done when the control key is pressed: for example, for CTRL-A key press the key down
event still carries the same key code 'a' as usual but the char event will have key code of 1, the ASCII value of
this key combination.
</p>
<p>
You may discover how the other keys on your system behave interactively by running the text wxWidgets sample and
pressing some keys in any of the text controls shown in it.
</p>
<p>
Note: If a key down (wxEVT_KEY_DOWN) event is caught and the event handler does not call event.Skip() then the
corresponding char event (wxEVT_CHAR) will not happen. This is by design and enables the programs that handle both
types of events to be a bit simpler.
</p>
<p>
Note for Windows programmers: The key and char events in wxWidgets are similar to but slightly different from
Windows WM_KEYDOWN and WM_CHAR events. In particular, Alt-x combination will generate a char event in wxWidgets
(unless it is used as an accelerator).
</p>
<p>
Tip: be sure to call event.Skip() for events that you don't process in key event function, otherwise menu
shortcuts may cease to work under Windows.
</p>
End Rem
Type wxKeyEvent Extends wxEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxKeyEvent = New wxKeyEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

	Rem
	bbdoc: Returns true if the Alt key was down at the time of the key event.
	about: Notice that GetModifiers is easier to use correctly than this method so you should consider using
	it in new code.
	End Rem
	Method AltDown:Int()
		Return bmx_wxkeyevent_altdown(wxEventPtr)
	End Method
	
	Rem
	bbdoc: CMD is a pseudo key which is the same as Control for PC and Unix platforms but the special APPLE (a.k.a as COMMAND) key under Macs
	about: It makes often sense to use it instead of, say, ControlDown() because Cmd key is used for the same
	thing under Mac as Ctrl elsewhere (but Ctrl still exists, just not used for this purpose under Mac). So for
	non-Mac platforms this is the same as ControlDown() and under Mac this is the same as MetaDown().
	End Rem
	Method CmdDown:Int()
		Return bmx_wxkeyevent_cmddown(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the control key was down at the time of the key event.
	about: Notice that GetModifiers is easier to use correctly than this method so you should consider using it
	in new code.
	End Rem
	Method ControlDown:Int()
		Return bmx_wxkeyevent_controldown(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns the virtual key code.
	about: ASCII events return normal ASCII values, while non-ASCII events return values such as WXK_LEFT for the
	left cursor key. See Keycodes for a full list of the virtual key codes.
	<p>
	Note that in Unicode build, the returned value is meaningful only if the user entered a character that can be
	represented in current locale's default charset. You can obtain the corresponding Unicode character using
	GetUnicodeKey.
	</p>
	End Rem
	Method GetKeyCode:Int()
		Return bmx_wxkeyevent_getkeycode(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Return the bitmask of modifier keys which were pressed when this event happened.
	about: See key modifier constants for the full list of modifiers.
	<p>
	Notice that this method is easier to use correctly than, for example, ControlDown because when using the latter
	you also have to remember to test that none of the other modifiers is pressed:
	<pre>
	    If ControlDown() And Not AltDown() And Not ShiftDown() And Not MetaDown() Then
	        ... handle Ctrl-XXX ...
	</pre>
	and forgetting to do it can result in serious program bugs (e.g. program not working with European keyboard
	layout where ALTGR key which is seen by the program as combination of CTRL and ALT is used). On the other hand,
	you can simply write
	<pre>
	    If GetModifiers() & wxMOD_CONTROL Then
	        ... handle Ctrl-XXX ...
	</pre>
	with this method.
	</p>
	End Rem
	Method GetModifiers:Int()
		Return bmx_wxkeyevent_getmodifiers(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Obtains the position (in client coordinates) at which the key was pressed.
	End Rem
	Method GetPosition(x:Int Var, y:Int Var)
		bmx_wxkeyevent_getposition(wxEventPtr, Varptr x, Varptr y)
	End Method
	
	Rem
	bbdoc: Returns the raw key code for this event.
	about: This is a platform-dependent scan code which should only be used in advanced applications.
	End Rem
	Method GetRawKeyCode:Int()
		Return bmx_wxkeyevent_getrawkeycode(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns the low level key flags for this event.
	about: The flags are platform-dependent and should only be used in advanced applications.
	End Rem
	Method GetRawKeyFlags:Int()
		Return bmx_wxkeyevent_getrawkeyflags(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns the Unicode character corresponding to this key event.
	End Rem
	Method GetUnicodeKey:String()
		Return bmx_wxkeyevent_getunicodekey(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns the X position (in client coordinates) of the event.
	End Rem
	Method GetX:Int()
		Return bmx_wxkeyevent_getx(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns the Y (in client coordinates) position of the event.
	End Rem
	Method GetY:Int()
		Return bmx_wxkeyevent_gety(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns true if either CTRL or ALT keys was down at the time of the key event.
	about: Note that this function does not take into account neither SHIFT nor META key states (the reason for
	ignoring the latter is that it is common for NUMLOCK key to be configured as META under X but the key presses
	even while NUMLOCK is on should be still processed normally).
	End Rem
	Method HasModifiers:Int()
		Return bmx_wxkeyevent_hasmodifiers(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the Meta key was down at the time of the key event.
	about: Notice that GetModifiers is easier to use correctly than this method so you should consider using it in
	new code.
	End Rem
	Method MetaDown:Int()
		Return bmx_wxkeyevent_metadown(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the shift key was down at the time of the key event.
	about: Notice that GetModifiers is easier to use correctly than this function so you should consider using it
	in new code.
	End Rem
	Method ShiftDown:Int()
		Return bmx_wxkeyevent_shiftdown(wxEventPtr)
	End Method

End Type

Type wxNavigationKeyEvent Extends wxEvent

	Const IsBackward:Int = $0000
	Const IsForward:Int = $0001
	Const WinChange:Int = $0002
	Const FromTab:Int = $0004


End Type

Rem
bbdoc: The power events are generated when the system power state changes, e.g. the system is suspended, hibernated, plugged into or unplugged from the wall socket and so on.
about: Notice that currently only suspend and resume events are generated and only under MS Windows platform. 
End Rem
Type wxPowerEvent Extends wxEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxPowerEvent = New wxPowerEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

	Rem
	bbdoc: Call this to prevent suspend from taking place in wxEVT_POWER_SUSPENDING handler (it is ignored for all the others).
	End Rem
	Method Veto()
		bmx_wxpowerevent_veto(wxEventPtr)
	End Method
	
End Type

Rem
bbdoc: This is the base type for all supported gesture events.
about: Gesture events are not generated by default, you must call #wxWindow.EnableTouchEvents() with the appropriate parameter to request their generation
End Rem
Type wxGestureEvent Extends wxEvent

	Rem
	bbdoc: Returns the position where the event took effect, in client coordinates.
	about: That is, the position of Pan event, center of zoom for Zoom event, center of rotation for Rotate event,
	center of box formed by 2 fingers for Two Finger Tap event and position of the pressed finger for Press and Tap Event.
	End Rem
	Method GetPosition(x:Int Var, y:Int Var)
		bmx_wxgestureevent_getposition(wxEventPtr, Varptr x, Varptr y)
	End Method
	
	Rem
	bbdoc: Returns #True if the event was the first in a gesture sequence.
	End Rem
	Method IsGestureStart:Int()
		Return bmx_wxgestureevent_isgesturestart(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns #True if the event was the last in a gesture sequence.
	End Rem
	Method IsGestureEnd:Int()
		Return bmx_wxgestureevent_isgestureend(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Sets the position where the event took effect, in client coordinates.
	about: That is, the position of Pan event, center of zoom for Zoom event, center of rotation for Rotate event.
	End Rem
	Method SetPosition(x:Int, y:Int)
		bmx_wxgestureevent_setposition(wxEventPtr, x, y)
	End Method
	
	Rem
	bbdoc: Sets the event to be the first in a gesture sequence.
	End Rem
	Method SetGestureStart(isStart:Int = True)
		bmx_wxgestureevent_setgesturestart(wxEventPtr, isStart)
	End Method
	
	Rem
	bbdoc: Sets the event to be the last in a gesture sequence.
	End Rem
	Method SetGestureEnd(isEnd:Int = True)
		bmx_wxgestureevent_setgestureend(wxEventPtr, isEnd)
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxLongPressEvent Extends wxGestureEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxLongPressEvent = New wxLongPressEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

End Type

Rem
bbdoc: This event is generated when the user moves a finger on the surface.
about: wxGTK also generates this event during mouse dragging (mouse motion while a left mouse button is depressed).
Note that OSX requires the primary mouse button to be pressed while performing the finger movement.
End Rem
Type wxPanGestureEvent Extends wxGestureEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxPanGestureEvent = New wxPanGestureEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

	Rem
	bbdoc: Returns the distance covered since the previous panning event.
	End Rem
	Method GetDelta(x:Int Var, y:Int Var)
		bmx_wxpangestureevent_getdelta(wxEventPtr, Varptr x, Varptr y)
	End Method
	
	Rem
	bbdoc: Sets the distance covered since the previous panning event.
	End Rem
	Method SetDelta(x:Int, y:Int)
		bmx_wxpangestureevent_setdelta(wxEventPtr, x, y)
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxPressAndTapEvent Extends wxGestureEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxPressAndTapEvent = New wxPressAndTapEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

End Type

Rem
bbdoc: This event is generated when two fingers move in opposite directions on the surface.
End Rem
Type wxRotateGestureEvent Extends wxGestureEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxRotateGestureEvent = New wxRotateGestureEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

	Rem
	bbdoc: Returns the total angle of rotation in degrees in clockwise direction since the gesture was first started.
	about: i.e. when #IsGestureStart() returned true. This value is always greater than or equal to zero.
	End Rem
	Method GetRotationAngle:Double()
		Return bmx_wxrotategestureevent_getrotationangle(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Sets the total angle of rotation in degrees in clockwise direction since the gesture was first started.
	about: i.e. when #IsGestureStart() returned true. This value is always greater than or equal to zero.
	End Rem
	Method SetRotationAngle(angle:Double)
		bmx_wxrotategestureevent_setrotationangle(wxEventPtr, angle)
	End Method
	
End Type

Rem
bbdoc: This event is generated when two fingers touch the surface at the same time.
End Rem
Type wxTwoFingerTapEvent Extends wxGestureEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxTwoFingerTapEvent = New wxTwoFingerTapEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

End Type

Rem
bbdoc: This event is generated when two fingers pinch the surface to zoom in or out.
End Rem
Type wxZoomGestureEvent Extends wxGestureEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxZoomGestureEvent = New wxZoomGestureEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

	Rem
	bbdoc: Returns the zoom Factor since the gesture started.
	abour: Hence, starting of the gesture is considered as 1:1. A value greater than 1.0 means we should enlarge
	(or zoom in), a value less than 1.0 means we should shrink (or zoom out).
	End Rem
	Method GetZoomFactor:Double()
		Return bmx_wxzoomgestureevent_getzoomfactor(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Sets the zoom Factor.
	End Rem
	Method SetZoomFactor(factor:Double)
		bmx_wxzoomgestureevent_setzoomfactor(wxEventPtr, factor)
	End Method
	
End Type

' internal event handler.
Type TEventHandler

	Field parent:wxEvtHandler
	Field eventSink:wxEvtHandler
	Field key:String
	Field callback(event:wxEvent)
	Field userData:Object
	Field eventType:Int
	Field wxEventType:Int
	Field id:Int
	Field lastId:Int = -1
	Field refPtr:Byte Ptr
	Field kind:Int
	Field ownerPtr:Byte Ptr
	
	Function eventCallback(evt:Byte Ptr, data:Object) { nomangle }
		Local handler:TEventHandler = TEventHandler(data)
		
		If handler And handler.parent Then
			Local event:wxEvent
			
			Local factory:TEventFactory = event_factories

			While factory
				event = factory.CreateEvent(evt, handler)
				If event Exit
				factory = factory._succ
			Wend
			
			If event Then
				handler.callback(event)
			End If
		End If
		
	End Function
	
	Method SetRef(ref:Byte Ptr)
		refPtr = ref
		key :+ "." + Int(ref) ' generates unique(ish) key
	End Method
	
	Function _nullref(obj:TEventHandler) { nomangle }
		obj.refPtr = Null
	End Function
	
	Method Delete()
		If refPtr Then
			bmx_wxevthandler_freeref(refPtr)
			refPtr = Null
		End If
	End Method
	
End Type


Rem
bbdoc: A type that can handle events from the windowing system.
about: wxWindow (and therefore all window classes) are derived from this class.
End Rem
Type wxEvtHandler Extends wxObject

	Field clientData:Object
	
	Function _create:wxEvtHandler(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxEvtHandler = New wxEvtHandler
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _find:Object(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local handler:Object = wxfind(wxObjectPtr)
			If Not handler Then
				Return wxEvtHandler._create(wxObjectPtr)
			End If
			Return handler
		End If
	End Function

	Rem
	bbdoc: 
	End Rem
	Method CreateHandler:wxEvtHandler()
		wxObjectPtr = bmx_wxevthandler_create(Self)
		OnInit()
		Return Self
	End Method
	
	Method OnInit:Int()
	End Method

	' TODO: a map/list of event handles for this instance
	Field events:TMap = New TMap

	Rem
	bbdoc: A synonymn for ConnectAny
	End Rem
	Method ConnectNoId(eventType:Int, callback(event:wxEvent), userData:Object = Null)
		ConnectAny(eventType, callback, userData)
	End Method

	Rem
	bbdoc: Connects the given function dynamically with the event handler and event type.
	about: Use this for events that don't require an event id - like wxEVT_PAINT, or wxEVT_CLOSE.
	<p>Example,
	<pre>
	ConnectAny(wxEVT_CLOSE, func)
	</pre>
	can be used in place of the macro
	<pre>
	EVT_CLOSE(func)
	</pre>
	</p>
	End Rem
	Method ConnectAny(eventType:Int, callback(event:wxEvent), userData:Object = Null, sink:wxEvtHandler = Null)
	
		' ********** SPECIAL CASES *************
		If eventType = wxEVT_SCROLLWIN Then
			ConnectAny(wxEVT_SCROLLWIN_TOP, callback, userData, sink)
			ConnectAny(wxEVT_SCROLLWIN_BOTTOM, callback, userData, sink)
			ConnectAny(wxEVT_SCROLLWIN_LINEUP, callback, userData, sink)
			ConnectAny(wxEVT_SCROLLWIN_LINEDOWN, callback, userData, sink)
			ConnectAny(wxEVT_SCROLLWIN_PAGEUP, callback, userData, sink)
			ConnectAny(wxEVT_SCROLLWIN_PAGEDOWN, callback, userData, sink)
			ConnectAny(wxEVT_SCROLLWIN_THUMBTRACK, callback, userData, sink)
			ConnectAny(wxEVT_SCROLLWIN_THUMBRELEASE, callback, userData, sink)
			Return
		End If
		
		If eventType = wxEVT_SCROLL Then
			ConnectAny(wxEVT_SCROLL_TOP, callback, userData, sink)
			ConnectAny(wxEVT_SCROLL_BOTTOM, callback, userData, sink)
			ConnectAny(wxEVT_SCROLL_LINEUP, callback, userData, sink)
			ConnectAny(wxEVT_SCROLL_LINEDOWN, callback, userData, sink)
			ConnectAny(wxEVT_SCROLL_PAGEUP, callback, userData, sink)
			ConnectAny(wxEVT_SCROLL_PAGEDOWN, callback, userData, sink)
			ConnectAny(wxEVT_SCROLL_THUMBTRACK, callback, userData, sink)
			ConnectAny(wxEVT_SCROLL_THUMBRELEASE, callback, userData, sink)
			ConnectAny(wxEVT_SCROLL_CHANGED, callback, userData, sink)
			Return
		End If
		
		If eventType = wxEVT_MOUSE_EVENTS Then
			ConnectAny(wxEVT_ENTER_WINDOW, callback, userData, sink)
			ConnectAny(wxEVT_LEAVE_WINDOW, callback, userData, sink)
			ConnectAny(wxEVT_LEFT_DOWN, callback, userData, sink)
			ConnectAny(wxEVT_LEFT_UP, callback, userData, sink)
			ConnectAny(wxEVT_LEFT_DCLICK, callback, userData, sink)
			ConnectAny(wxEVT_MIDDLE_DOWN, callback, userData, sink)
			ConnectAny(wxEVT_MIDDLE_UP, callback, userData, sink)
			ConnectAny(wxEVT_MIDDLE_DCLICK, callback, userData, sink)
			ConnectAny(wxEVT_RIGHT_DOWN, callback, userData, sink)
			ConnectAny(wxEVT_RIGHT_UP, callback, userData, sink)
			ConnectAny(wxEVT_RIGHT_DCLICK, callback, userData, sink)
			ConnectAny(wxEVT_MOTION, callback, userData, sink)
			ConnectAny(wxEVT_MOUSEWHEEL, callback, userData, sink)
			Return
		End If
	
		Local handler:TEventHandler = New TEventHandler
		' TODO: we may need parent if we are to get back to the original object that the event was generated from?
		handler.parent = Self
		If sink Then
			handler.eventSink = sink
		Else
			handler.eventSink = Self
		End If
		handler.key = "xx.-1." + eventType
		handler.id = 0
		'handler.lastId = lastId
		handler.eventType = eventType
		handler.callback = callback
		handler.userData = userData
		handler.kind = 0
		handler.ownerPtr = wxObjectPtr
		handler.SetRef(bmx_wxevthandler_newref(handler))
		
		events.insert(handler.key, handler)

		Local factory:TEventFactory = event_factories
		Local evt:Int

		While factory
			evt = factory.GetEventType(eventType)
			If evt Exit
			factory = factory._succ
		Wend
		
		If evt Then
			eventType = evt
			handler.wxEventType = eventType
		End If
		
		
		bmx_wxevthandler_connectnoid(wxObjectPtr, eventType, handler.refPtr)
	End Method
	
	Rem
	bbdoc: Disconnects the given eventType dynamically from the event handler, returning true if a matching function has been found and removed.
	End Rem
	Method DisconnectAny:Int(eventType:Int)

		' ********** SPECIAL CASES *************
		If eventType = wxEVT_SCROLLWIN Then
			DisconnectAny(wxEVT_SCROLLWIN_TOP)
			DisconnectAny(wxEVT_SCROLLWIN_BOTTOM)
			DisconnectAny(wxEVT_SCROLLWIN_LINEUP)
			DisconnectAny(wxEVT_SCROLLWIN_LINEDOWN)
			DisconnectAny(wxEVT_SCROLLWIN_PAGEUP)
			DisconnectAny(wxEVT_SCROLLWIN_PAGEDOWN)
			DisconnectAny(wxEVT_SCROLLWIN_THUMBTRACK)
			DisconnectAny(wxEVT_SCROLLWIN_THUMBRELEASE)
			Return True
		End If
		
		If eventType = wxEVT_SCROLL Then
			DisconnectAny(wxEVT_SCROLL_TOP)
			DisconnectAny(wxEVT_SCROLL_BOTTOM)
			DisconnectAny(wxEVT_SCROLL_LINEUP)
			DisconnectAny(wxEVT_SCROLL_LINEDOWN)
			DisconnectAny(wxEVT_SCROLL_PAGEUP)
			DisconnectAny(wxEVT_SCROLL_PAGEDOWN)
			DisconnectAny(wxEVT_SCROLL_THUMBTRACK)
			DisconnectAny(wxEVT_SCROLL_THUMBRELEASE)
			DisconnectAny(wxEVT_SCROLL_CHANGED)
			Return True
		End If
		
		If eventType = wxEVT_MOUSE_EVENTS Then
			DisconnectAny(wxEVT_ENTER_WINDOW)
			DisconnectAny(wxEVT_LEAVE_WINDOW)
			DisconnectAny(wxEVT_LEFT_DOWN)
			DisconnectAny(wxEVT_LEFT_UP)
			DisconnectAny(wxEVT_LEFT_DCLICK)
			DisconnectAny(wxEVT_MIDDLE_DOWN)
			DisconnectAny(wxEVT_MIDDLE_UP)
			DisconnectAny(wxEVT_MIDDLE_DCLICK)
			DisconnectAny(wxEVT_RIGHT_DOWN)
			DisconnectAny(wxEVT_RIGHT_UP)
			DisconnectAny(wxEVT_RIGHT_DCLICK)
			DisconnectAny(wxEVT_MOTION)
			DisconnectAny(wxEVT_MOUSEWHEEL)
			Return True
		End If


		Local key:String = "xx.-1." + eventType
		Local handler:TEventHandler = TEventHandler(events.ValueForKey(key))
		
		If handler Then
			If bmx_wxevthandler_disconnectnoid(wxObjectPtr, handler.wxEventType, handler.refPtr)
				events.Remove(key)
				
				Return True
			End If
		End If
		
		Return False
	End Method

	Rem
	bbdoc: Connects the given function dynamically with the event handler, id and event type.
	about: Example :
	<pre>
	Connect(wxID_ABOUT, wxEVT_COMMAND_MENU_SELECTED, func)
	</pre>
	can be used in place of the macro
	<pre>
	EVT_MENU(wxID_ABOUT, func)
	</pre>
	End Rem
	Method Connect(id:Int = -1, eventType:Int, callback(event:wxEvent), userData:Object = Null, sink:wxEvtHandler = Null)
	
		' ********** SPECIAL CASES *************
		If eventType = wxEVT_SCROLL Then
			Connect(id, wxEVT_SCROLL_TOP, callback, userData, sink)
			Connect(id, wxEVT_SCROLL_BOTTOM, callback, userData, sink)
			Connect(id, wxEVT_SCROLL_LINEUP, callback, userData, sink)
			Connect(id, wxEVT_SCROLL_LINEDOWN, callback, userData, sink)
			Connect(id, wxEVT_SCROLL_PAGEUP, callback, userData, sink)
			Connect(id, wxEVT_SCROLL_PAGEDOWN, callback, userData, sink)
			Connect(id, wxEVT_SCROLL_THUMBTRACK, callback, userData, sink)
			Connect(id, wxEVT_SCROLL_THUMBRELEASE, callback, userData, sink)
			Connect(id, wxEVT_SCROLL_CHANGED, callback, userData, sink)
			Return
		End If

		Local handler:TEventHandler = New TEventHandler
		' TODO: we may need parent if we are to get back to the original object that the event was generated from?
		handler.parent = Self
		If sink Then
			handler.eventSink = sink
		Else
			handler.eventSink = Self
		End If
		handler.key = id + ".-1." + eventType
		handler.id = id
		'handler.lastId = lastId
		handler.eventType = eventType
		handler.callback = callback
		handler.userData = userData
		handler.kind = 1
		handler.ownerPtr = wxObjectPtr
		handler.SetRef(bmx_wxevthandler_newref(handler))
		
		events.insert(handler.key, handler)

		Local factory:TEventFactory = event_factories
		Local evt:Int

		While factory
			evt = factory.GetEventType(eventType)
			If evt Exit
			factory = factory._succ
		Wend
		
		If evt Then
			eventType = evt
			handler.wxEventType = eventType
		End If
		
		bmx_wxevthandler_connect(wxObjectPtr, id, eventType, handler.refPtr)
	End Method
	
	Rem
	bbdoc: Disconnects the given event dynamically from the event handler, using the specified parameters as search criteria and returning true if a matching function has been found and removed.
	End Rem
	Method Disconnect:Int(id:Int = -1, eventType:Int)

		' ********** SPECIAL CASES *************
		If eventType = wxEVT_SCROLL Then
			Disconnect(id, wxEVT_SCROLL_TOP)
			Disconnect(id, wxEVT_SCROLL_BOTTOM)
			Disconnect(id, wxEVT_SCROLL_LINEUP)
			Disconnect(id, wxEVT_SCROLL_LINEDOWN)
			Disconnect(id, wxEVT_SCROLL_PAGEUP)
			Disconnect(id, wxEVT_SCROLL_PAGEDOWN)
			Disconnect(id, wxEVT_SCROLL_THUMBTRACK)
			Disconnect(id, wxEVT_SCROLL_THUMBRELEASE)
			Disconnect(id, wxEVT_SCROLL_CHANGED)
			Return True
		End If

		Local key:String = id + ".-1." + eventType
		Local handler:TEventHandler = TEventHandler(events.ValueForKey(key))
		
		If handler Then
			If bmx_wxevthandler_disconnect(wxObjectPtr, id, handler.wxEventType, handler.refPtr)
				events.Remove(key)
				
				Return True
			End If
		End If
		
		Return False
	End Method

	Rem
	bbdoc: Connects the given function dynamically with the event handler, an id range and event type.
	about: Example :
	<pre>
	ConnectRange(startId, lastId, wxEVT_COMMAND_MENU_SELECTED, func)
	</pre>
	can be used in place of the macro
	<pre>
	EVT_MENU_RANGE(startId, lastId, func)
	</pre>
	End Rem
	Method ConnectRange(id:Int, lastId:Int, eventType:Int, callback(event:wxEvent), userData:Object = Null, sink:wxEvtHandler = Null)
		Local handler:TEventHandler = New TEventHandler

		handler.parent = Self
		If sink Then
			handler.eventSink = sink
		Else
			handler.eventSink = Self
		End If
		handler.key = id + "." + lastId + "." + eventType
		handler.id = id
		handler.lastId = lastId
		handler.eventType = eventType
		handler.callback = callback
		handler.userData = userData
		handler.kind = 2
		handler.ownerPtr = wxObjectPtr
		handler.SetRef(bmx_wxevthandler_newref(handler))
		
		events.insert(handler.key, handler)

		Local factory:TEventFactory = event_factories
		Local evt:Int

		While factory
			evt = factory.GetEventType(eventType)
			If evt Exit
			factory = factory._succ
		Wend
		
		If evt Then
			eventType = evt
			handler.wxEventType = eventType
		End If
		
		bmx_wxevthandler_connectrange(wxObjectPtr, id, lastId, eventType, handler.refPtr)
	End Method
	
	Rem
	bbdoc: Disconnects the given event range dynamically from the event handler, using the specified parameters as search criteria and returning true if a matching function has been found and removed.
	End Rem
	Method DisconnectRange:Int(id:Int, lastId:Int, eventType:Int)
		Local key:String = id + "." + lastId + "." + eventType
		Local handler:TEventHandler = TEventHandler(events.ValueForKey(key))
		
		If handler Then
			If bmx_wxevthandler_disconnectrange(wxObjectPtr, id, lastId, handler.wxEventType, handler.refPtr)
				events.Remove(key)
				
				Return True
			End If
		End If
		
		Return False
	End Method
	
	Rem
	bbdoc: Posts an event to be processed later.
	about: The difference between sending an event (using the ProcessEvent method) and posting it is that
	in the first case the event is processed before the function returns, while in the second case, the
	function returns immediately and the event will be processed sometime later (usually during the next
	event loop iteration).
	<p>
	A copy of event is made by the function, so the original can be deleted as soon as function returns
	(it is common that the original is created on the stack). This requires that the wxEvent::Clone method be
	implemented by event so that it can be duplicated and stored until it gets processed.
	</p>
	<p>
	This is also the method to call for inter-thread communication---it will post events safely between
	different threads which means that this method is thread-safe by using critical sections where needed. In
	a multi-threaded program, you often need to inform the main GUI thread about the status of other working
	threads and such notification should be done using this method.
	</p>
	<p>
	This method automatically wakes up idle handling if the underlying window system is currently idle and
	thus would not send any idle events. (Waking up idle handling is done calling ::wxWakeUpIdle.)
	</p>
	End Rem
	Method AddPendingEvent(event:wxEvent)
		bmx_wxevthandler_addpendingevent(wxObjectPtr, event.wxEventPtr)
	End Method
	
	Rem
	bbdoc: Gets user-supplied client data.
	End Rem
	Method GetClientData:Object()
		Return clientData
	End Method
	
	Rem
	bbdoc: Returns true if the event handler is enabled, false otherwise.
	End Rem
	Method GetEvtHandlerEnabled:Int()
	End Method
	
	Rem
	bbdoc: Gets the next handler in the chain.
	End Rem
	Method GetNextHandler:wxEvtHandler()
	End Method
	
	Rem
	bbdoc: Gets the previous handler in the chain.
	End Rem
	Method GetPreviousHandler:wxEvtHandler()
	End Method
	
	Rem
	bbdoc: Processes an event, searching event tables and calling zero or more suitable event handler function(s).
	about: Normally, your application would not call this function: it is called in the wxWidgets
	implementation to dispatch incoming user interface events to the framework (and application).
	<p>
	However, you might need to call it if implementing new functionality (such as a new control) where
	you define new event types, as opposed to allowing the user to override virtual functions.
	</p>
	<p>
	An instance where you might actually override the ProcessEvent function is where you want to direct
	event processing to event handlers not normally noticed by wxWidgets. For example, in the document/view
	architecture, documents and views are potential event handlers. When an event reaches a frame,
	ProcessEvent will need to be called on the associated document and view in case event handler
	functions are associated with these objects. The property classes library (wxProperty) also overrides
	ProcessEvent for similar reasons.
	</p>
	<p>
	The normal order of event table searching is as follows:
	<ol>
	<li>If the object is disabled (via a call to wxEvtHandler::SetEvtHandlerEnabled) the function skips to
	step (6).</li>
	<li>If the object is a wxWindow, ProcessEvent is recursively called on the window's wxValidator. If
	this returns true, the function exits. </li>
	<li>SearchEventTable is called for this event handler. If this fails, the base class table is tried,
	and so on until no more tables exist or an appropriate function was found, in which case the function
	exits. </li>
	<li>The search is applied down the entire chain of event handlers (usually the chain has a length of
	one). If this succeeds, the function exits. </li>
	<li>If the object is a wxWindow and the event is a wxCommandEvent, ProcessEvent is recursively
	applied to the parent window's event handler. If this returns true, the function exits. </li>
	<li>Finally, ProcessEvent is called on the wxApp object.</li>
	</ol>
	</p>
	End Rem
	Method ProcessEvent:Int(event:wxEvent)
		Return bmx_wxevthandler_processevent(wxObjectPtr, event.wxEventPtr)
	End Method
	
	Rem
	bbdoc: Sets user-supplied client data.
	End Rem
	Method SetClientData(data:Object)
		clientData = data
	End Method
	
	Method Delete()
		Free()
	End Method
	
	Method Free()

		clientData = Null
		' cleanup time!
		If events Then

			For Local event:TEventHandler = EachIn events.Values()
				' disconnect events
				Select event.kind
					Case 0 ' any
						bmx_wxevthandler_disconnectnoid(event.ownerPtr, event.wxEventType, event.refPtr)
					Case 1 ' id
						bmx_wxevthandler_disconnect(event.ownerPtr, event.id, event.wxEventType, event.refPtr)
					Case 2 ' range
						bmx_wxevthandler_disconnectrange(event.ownerPtr, event.id, event.lastId, event.wxEventType, event.refPtr)
				End Select
			
				event.parent = Null
				event.eventSink = Null
			Next

			events.Clear()
			events = Null
		End If
	End Method
	
End Type

Rem
bbdoc: Generates a new unique event type
End Rem
Function wxNewEventType:Int()
	Global eventTypeId:Int = wxEVT_USER_FIRST
	Local id:Int = eventTypeId
	eventTypeId:+ 1
	Return id
End Function


Type TEventFactory
	Field _succ:TEventFactory
	
	Method New()
		_succ=event_factories
		event_factories=Self
	End Method
	
	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler) Abstract
	
	Method GetEventType:Int(eventType:Int) Abstract
	
End Type

' Controls the relationship between custom user ids and wxIds.
Function _GetCustomEventType:Int(eventType:Int)

	Global eventMap:TMap = New TMap

	' created as a local, so we can simply use this if we need to create a new entry
	Local eType:EvtIntWrap = EvtIntWrap.Set(eventType)
	
	' exists already?
	Local evt:EvtIntWrap = EvtIntWrap(eventMap.ValueForKey(eType))
	
	' we found one already present!
	If evt Then
		Return evt.wxId
	End If
	
	' otherwise we need to create a new wxId, add to the map, and return the id..
	eType.wxId = bmx_wxneweventtype()
	eventMap.Insert(eType, eType)
	
	Return eType.wxId
	
End Function

Type EvtIntWrap
	Field id:Int
	Field wxId:Int
	Function Set:EvtIntWrap(id:Int)
		Local this:EvtIntWrap = New EvtIntWrap
		this.id = id
		Return this
	End Function
	
	Method Compare:Int(obj:Object)
		If id < EvtIntWrap(obj).id Then
			Return -1
		Else If id > EvtIntWrap(obj).id Then
			Return 1
		End If
		Return 0
	End Method
End Type

