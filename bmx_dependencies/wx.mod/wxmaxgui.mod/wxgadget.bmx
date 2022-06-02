' Copyright (c) 2013-2018 Bruce A Henderson
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
Strict

Import "wxfont.bmx"

Type TwxGadget Extends TGadget

	Field widget:wxWindow
	Field icons:TwxIconStrip
	
	Field initing:Int = True

	Method CreateGadget:TwxGadget(Text:String, x:Int, y:Int, w:Int, h:Int, group:TwxGadget, style:Int)
		
		Self.style = style
		SetRect(x, y, w, h)
		parent = group
		InitGadget()
		
		LockLayout()
		
		If (LocalizationMode() & LOCALIZATION_OVERRIDE) Then
			LocalizeGadget(Self, Text)
		Else
			SetText(Text)
		EndIf

		If parent Then
			parent.kids.Remove(Self)
			parent.kids.AddLast(Self)
		End If
		
		initing = False
		'SetFont(TFLTKGUIDriver.fntDefault)
		Return Self
		
	End Method
	
	Method InitGadget()
	End Method

	Method SetShow(truefalse:Int)
		If truefalse Then
			widget.Show()
		Else
			widget.Hide()
		End If
	End Method

	Method SetTooltip(Text:String)
		widget.setToolTip(Text)
	End Method
		
	Method ClientWidth:Int()
		Local w:Int, h:Int
		If Not widget.IsShown() Then
			widget.GetSize(w, h)
		Else
			widget.GetClientSize(w, h)
		End If
		Return w
	End Method

	Method ClientHeight:Int()
		Local w:Int, h:Int
		If Not widget.IsShown() Then
			widget.GetSize(w, h)
		Else
			widget.GetClientSize(w, h)
		End If
		Return h
	End Method

	Method SetColor(r:Int, g:Int, b:Int)
		Local col:wxColour = New wxColour.Create(r, g, b)
		widget.SetOwnBackgroundColour(col)
		widget.refresh() ' Windows (at least) requires this.
	End Method

	Method RealParentForChild:wxWindow()
		Return widget
	End Method

	Method SetFont(font:TGuiFont)
		widget.SetFont(TwxGuiFont(font).font)
	End Method
	
	Method GetFont:TGuiFont()
		Return New TwxGuiFont.Create(widget.GetFont())
	End Method

	Method SetIconStrip(iconstrip:TIconStrip)
		icons = TwxIconStrip(iconstrip)
	End Method
	
	Method Rethink()
		widget.Move(xpos, ypos)
		widget.SetSize(width, height)
	End Method

	Method State:Int()
		Local s:Int
		
		If Not widget.IsShown() Then
			s :| STATE_HIDDEN
		End If
		
		Return s
	End Method

End Type

Type TwxIconStrip Extends TIconStrip
	
	Field icons:wxBitmap[]
	Field dim:Int
	
	Function IsNotBlank:Int(pixmap:TPixmap)
		Local h:Int = pixmap.height
		Local c:Int = pixmap.ReadPixel(0,0) 			
		For Local x:Int = 0 Until h
			For Local y:Int = 0 Until h
				If pixmap.ReadPixel(x,y)<>c Return True
			Next
		Next
	End Function
		
	Function Create:TwxIconStrip(source:Object)
		Local iconstrip:TwxIconStrip

		Local pixmap:TPixmap = TPixmap(source)
		If Not pixmap Then
			pixmap = LoadPixmap(source)
		End If
		If Not pixmap Return Null
		
		Select pixmap.format
			Case PF_I8,PF_BGR888
				pixmap = pixmap.Convert( PF_RGB888 )
			Case PF_A8,PF_BGRA8888
				pixmap = pixmap.Convert( PF_RGBA8888 )
			Default
				pixmap = pixmap.Copy()
		End Select
		
		If AlphaBitsPerPixel[ pixmap.format ]
			For Local y:Int = 0 Until pixmap.height
				For Local x:Int = 0 Until pixmap.width
					Local argb:Int = pixmap.ReadPixel( x,y )
					pixmap.WritePixel x, y, premult(argb)
				Next
			Next
		EndIf
		
		Local n:Int = pixmap.width/pixmap.height
		If n = 0 Return Null
		
		iconstrip = New TwxIconStrip
		iconstrip.pixmap = pixmap
		iconstrip.count = n
		iconstrip.icons = New wxBitmap[n]
		
		Local w:Int = pixmap.width / n
		iconstrip.dim = w
		For Local x:Int = 0 Until n
			Local pix:TPixmap = pixmap.Window(x*w, 0, w, pixmap.height)
			If IsNotBlank(pix) Then
				iconstrip.icons[x] = wxBitmap.CreateBitmapFromPixmap(pix)
			End If
		Next

		Return iconstrip
	End Function	

	Function premult:Int(argb:Int)
		Local a:Int = ((argb Shr 24) & $FF)
		Return ((((argb&$ff00ff)*a)Shr 8)&$ff00ff)|((((argb&$ff00)*a)Shr 8)&$ff00)|(a Shl 24)
	End Function
	
	' create an imagelist from the icons
	Method GetImageList:wxImageList()
		Local imageList:wxImageList = New wxImageList.Create(dim, dim)
		For Local bitmap:wxBitmap = EachIn icons
			imageList.Add(bitmap)
		Next
		
		Return imageList
	End Method
	
EndType

Type TwxWindow Extends TwxGadget

	Field clientCoords:Int

	Method InitGadget()
		CreateWindow()
	End Method
	
	Method CreateWindow()
		Local flags:Int = 0
		
		If parent Then
			widget = New MaxGuiwxFrame.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, style)
		Else
			widget = New MaxGuiwxFrame.MCreate(Self, Null, xpos, ypos, width, height, style)
		End If
	
		If style & WINDOW_MENU Then
			MaxGuiwxFrame(widget).SetMenuBar(New wxMenuBar.Create())
		End If
		
		If style & WINDOW_STATUS Then
			'createStatusbar()
'			MaxGuiQMainWindow(widget).createStatusBar()
			'SetStatus("")
		EndIf
		
		If style & WINDOW_RESIZABLE Then

		Else
'			widget.setFixedSize(width, height)
		End If
		
		If style & WINDOW_CLIENTCOORDS Then
			clientCoords = True
		End If

		Rethink()

		If ~style & WINDOW_HIDDEN
			Setshow(True)
		Else
			SetShow(False)
		End If
	End Method

	Method SetText(Text:String)
		wxTopLevelWindow(widget).SetTitle(Text)
	End Method

	Method Rethink()
		If widget Then
			widget.SetPosition(xpos, ypos)
			If clientCoords Then
				widget.SetClientSize(width, height)
			Else
				widget.SetSize(width, height)
			End If

			LayoutKids()
		End If
	End Method

	Method RealParentForChild:wxWindow()
		Return MaxGuiwxFrame(widget).clientWidget
	End Method

	Method CreateToolBar:wxToolBar()
		Return MaxGuiwxFrame(widget).CreateToolBar()
	End Method

	Method GetMenu:TGadget()
		' return the window itself. Menus are attached to the menubar.
		' we deal with that in the menu item code!
		Return Self
	End Method
	
	Method GetMenuBar:wxMenuBar()
		Return MaxGuiwxFrame(widget).GetMenuBar()
	End Method

	Method UpdateMenu()
		Local mb:wxMenuBar = GetMenuBar()
		If mb Then
			mb.RefreshMenuBar()
		End If
	End Method
	
	Method Class:Int()
		Return GADGET_WINDOW
	End Method

End Type

Type TwxButton Extends TwxGadget


	Method SetText(Text:String)
		wxControl(widget).SetLabel(Text)
	End Method
	
	Method GetText:String()
		Return wxControl(widget).GetLabel()
	End Method

	Method Class:Int()
		Return GADGET_BUTTON
	End Method

End Type


Type TwxPushButton Extends TwxButton

	Method InitGadget()
		CreateButton()
	End Method
	
	Method CreateButton()
	
		widget = New MaxGuiwxButton.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, style)

'		Select style & 7
'			Case BUTTON_CHECKBOX
'				MaxGuiQPushButton(widget).setFlat(True)
'				MaxGuiQPushButton(widget).setCheckable(True)
'				MaxGuiQPushButton(widget).setAutoFillBackground(True)
'			Case BUTTON_RADIO
'				MaxGuiQPushButton(widget).setFlat(True)
'				MaxGuiQPushButton(widget).setCheckable(True)
'				MaxGuiQPushButton(widget).setAutoExclusive(True)
'				MaxGuiQPushButton(widget).setAutoFillBackground(True)
'			Default
'		End Select
				
'		If style = BUTTON_OK Then
'			MaxGuiQPushButton(widget).setDefault(True)
'			
'			Local window:TQtWindow = TQtWindow(getParentWindow())
'			
'			If window Then
'				window.setOKButton(Self)
'			End If
'			
'		End If
		
'		If style = BUTTON_CANCEL Then
'			Local window:TQtWindow = TQtWindow(getParentWindow())
'			
'			If window Then
'				window.setCancelButton(Self)
'			End If
'
'		End If
		
		Rethink()
		
		SetShow(True)
		
	End Method

	Method SetPixmap(pixmap:TPixmap, flags:Int)
		If pixmap Then
			Local bitmap:wxBitmap = wxBitmap.CreateBitmapFromPixmap(pixmap)
			wxButton(widget).SetBitmap(bitmap)
		End If
	End Method

End Type

Type TwxCheckBox Extends TwxButton

	Method InitGadget()
		CreateButton()
	End Method
	
	Method CreateButton()
	
		widget = New MaxGuiwxCheckBox.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, 0)

		Rethink()
		
		SetShow(True)
		
	End Method

	Method State:Int()
		Local flags:Int = Super.State()

		If wxCheckBox(widget).IsChecked() Then
			flags:|STATE_SELECTED
		End If

		Return flags
	End Method

	Method SetSelected(bool:Int)
		wxCheckBox(widget).SetValue(bool)
	End Method

End Type

Type TwxToggleButton Extends TwxButton

	Method InitGadget()
		CreateButton()
	End Method
	
	Method CreateButton()
	
		widget = New MaxGuiwxToggleButton.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, 0)

		Rethink()
		
		SetShow(True)
		
	End Method

	Method State:Int()
		Local flags:Int = Super.State()

		If wxToggleButton(widget).GetValue() Then
			flags:|STATE_SELECTED
		End If

		Return flags
	End Method

	Method SetSelected(bool:Int)
		wxToggleButton(widget).SetValue(bool)
	End Method

End Type

Type TwxRadioButton Extends TwxButton

	Method InitGadget()
		CreateButton()
	End Method
	
	Method CreateButton()
	
		widget = New MaxGuiwxRadioButton.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, 0)

		Rethink()
		
		SetShow(True)
		
	End Method

	Method State:Int()
		Local flags:Int = Super.State()

		If wxRadioButton(widget).GetValue() Then
			flags:|STATE_SELECTED
		End If

		Return flags
	End Method

	Method SetSelected(bool:Int)
		wxRadioButton(widget).SetValue(bool)
	End Method

End Type

Type TwxLabel Extends TwxGadget

	Method InitGadget()
		CreateLabel()
	End Method
	
	Method CreateLabel()
	
		Local labelStyle:Int = 0
		
		Select style & 3
			Case LABEL_FRAME
				labelStyle :| wxBORDER_SIMPLE
			Case LABEL_SUNKENFRAME
				labelStyle :| wxBORDER_SUNKEN
'			Case LABEL_SEPARATOR
'				' TODO : Horiz/Vert depending on width/height ?
'				If width < height Then
'					MaxGuiQLabel(widget).setFrameStyle(QFrame.Shape_VLine | QFrame.Shadow_Sunken)
'				Else
'					MaxGuiQLabel(widget).setFrameStyle(QFrame.Shape_HLine | QFrame.Shadow_Sunken)
'				End If
		End Select
		
		' alignment
		Select style & 24
			Case LABEL_LEFT
				labelStyle :| wxALIGN_LEFT
			Case LABEL_RIGHT
				labelStyle :| wxALIGN_RIGHT
			Case LABEL_CENTER
				labelStyle :| wxALIGN_CENTRE_HORIZONTAL
		End Select

		widget = New MaxGuiwxStaticText.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, labelStyle)
		
		Rethink()
		
		SetShow(True)
		
	End Method

	Method SetText(Text:String)
		wxControl(widget).SetLabel(Text)
	End Method
	
	Method GetText:String()
		Return wxControl(widget).GetLabel()
	End Method
	
	Method Class:Int()
		Return GADGET_LABEL
	End Method

End Type

Type TwxSeparator Extends TwxGadget

	Field separatorStyle:Int

	Method InitGadget()
		CreateSeparator()
	End Method
	
	Method CreateSeparator()
	
		Local w:Int = width
		Local h:Int = height
		
		If width < height Then
			separatorStyle = wxLI_VERTICAL
			w = -1
		Else
			separatorStyle = wxLI_HORIZONTAL
			h = -1
		End If


		widget = New MaxGuiwxStaticLine.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, w, h, separatorStyle)
		
		Rethink()
		
		SetShow(True)
		
	End Method
	
	Method Rethink()
		widget.Move(xpos, ypos)
		If separatorStyle = wxLI_VERTICAL Then
			widget.SetSize(-1, height)
		Else
			widget.SetSize(width, -1)
		End If
	End Method

	Method Class:Int()
		Return GADGET_LABEL
	End Method

End Type

Type TwxTextField Extends TwxGadget

	Method InitGadget()
		CreateTextField()
	End Method
	
	Method CreateTextField()
	
		widget = New MaxGuiwxTextCtrl.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, style)
		
		Rethink()
		
		SetShow(True)
		
	End Method

	Method SetText(Text:String)
		MaxGuiwxTextCtrl(widget).ChangeValue(Text)
	End Method
	
	Method GetText:String()
		Return MaxGuiwxTextCtrl(widget).GetValue()
	End Method

'	Method SetColor(r:Int, g:Int, b:Int)
'		Local pal:QPalette = widget.palette()
'		pal.SetColor(QPalette.Role_Base, New QColor.Create(r, g, b))
'		widget.setPalette(pal)
'	End Method

	Method Class:Int()
		Return GADGET_TEXTFIELD
	End Method

End Type

Type TwxPanel Extends TwxGadget

	Method InitGadget()
		CreatePanel()
	End Method
	
	Method CreatePanel()
		Local panelStyle:Int = 0
		
		Select style & 3
			Case LABEL_FRAME
				panelStyle :| wxBORDER_SIMPLE
			Case LABEL_SUNKENFRAME
				panelStyle :| wxBORDER_SUNKEN
		End Select

		widget = New MaxGuiwxPanel.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, panelStyle)

		If style & PANEL_ACTIVE Then
			' enable mouse sensitivity for active panel
			sensitivity :| SENSITIZE_MOUSE
		'	widget.setMouseTracking(True)
		End If

		Rethink()
		
		SetShow(True)
		
	End Method

'	Method RealParentForChild:QWidget()
'		Return MaxGuiQFrame(widget).clientWidget
'	End Method
'
'	Method ClientWidth:Int()
'		If Not widget.isVisible() Then
'			Return widget.width()
'		Else
'			Return MaxGuiQFrame(widget).ClientWidth()
'		End If
'	End Method
'
'	Method ClientHeight:Int()
'		If Not widget.isVisible() Then
'			Return widget.height()
'		Else
'			Return MaxGuiQFrame(widget).ClientHeight()
''		End If
''	End Method
'	
'	Method SetPixmap(pixmap:TPixmap, flags:Int)
'		If pixmap Then
'''			Local pix:QPixmap = ConvertPixmap(pixmap)
	'		MaxGuiQFrame(widget).setPixmap(pix, flags)
	'	End If
'	End Method

	Method Class:Int()
		Return GADGET_PANEL
	End Method

End Type

Type TwxStaticBox Extends TwxGadget

	Method InitGadget()
		CreateStaticBox()
	End Method
	
	Method CreateStaticBox()
	
		widget = New MaxGuiwxStaticBox.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, 0)
		
		Rethink()
		
		SetShow(True)
		
	End Method

	Method SetText(Text:String)
		MaxGuiwxStaticBox(widget).SetLabelText(Text)
	End Method
	
	Method GetText:String()
		Return MaxGuiwxStaticBox(widget).GetLabelText()
	End Method

'	Method RealParentForChild:QWidget()
'		Return MaxGuiQGroupBox(widget).clientWidget
'	End Method

'	Method ClientWidth:Int()
'		Return MaxGuiQGroupBox(widget).ClientWidth()
'	End Method

'	Method ClientHeight:Int()
'		Return MaxGuiQGroupBox(widget).ClientHeight()
'	End Method
	
End Type

Type TwxTrackBar Extends TwxGadget

	Method InitGadget()
		CreateTrackBar()
	End Method
	
	Method CreateTrackBar()
	
		Local flags:Int = wxSL_HORIZONTAL

		If style & SLIDER_VERTICAL Then
			flags = wxSL_VERTICAL | wxSL_INVERSE
		End If
	
		widget = New MaxGuiwxSlider.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, flags)
		
		' default range
		SetRange(1, 10)
		
		Rethink()
		
		SetShow(True)
		
	End Method

	Method SetRange(small:Int, big:Int)
		MaxGuiwxSlider(widget).SetRange(small, big)
	End Method
	
	Method SetProp(value:Int)
		MaxGuiwxSlider(widget).SetValue(value)
	End Method

	Method GetProp:Int()
		Return MaxGuiwxSlider(widget).GetValue()
	End Method

	Method Class:Int()
		Return GADGET_SLIDER
	End Method

End Type

Type TwxStepper Extends TwxGadget

	Method InitGadget()
		CreateStepper()
	End Method
	
	Method CreateStepper()
	
		widget = New MaxGuiwxSpinButton.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, 0)
		
		Rethink()
		
		SetShow(True)
		
	End Method

	Method SetRange(small:Int, big:Int)
		MaxGuiwxSpinButton(widget).SetRange(small, big)
	End Method
	
	Method SetProp(value:Int)
		MaxGuiwxSpinButton(widget).SetValue(value)
	End Method

	Method GetProp:Int()
		Return MaxGuiwxSpinButton(widget).GetValue()
	End Method

	Method Class:Int()
		Return GADGET_SLIDER
	End Method

End Type

Type TwxScrollBar Extends TwxGadget

	Field thumbSize:Int
	Field Range:Int
	Field pageSize:Int

	Method InitGadget()
		CreateScrollBar()
	End Method
	
	Method CreateScrollBar()
	
		Local orientation:Int = wxSB_HORIZONTAL
		
		If style & SLIDER_VERTICAL Then
			orientation = wxSB_VERTICAL
		End If
	
		widget = New MaxGuiwxScrollBar.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, orientation)
		
		' default range
		SetRange(1, 10)

		Rethink()
		
		SetShow(True)
		
	End Method

	Method SetRange(small:Int, big:Int)
		Range = big - small
		pageSize = small
		
		If small <> 0 Then
			thumbSize = big/small
		Else
			thumbSize = 1
		End If
		
		MaxGuiwxScrollBar(widget).SetScrollbar(GetProp(), thumbSize, Range + thumbSize, pageSize)
	End Method

	Method SetProp(value:Int)
		MaxGuiwxScrollBar(widget).SetScrollbar(value, thumbSize, Range + thumbSize, pageSize)
	End Method

	Method GetProp:Int()
		Return MaxGuiwxScrollBar(widget).GetThumbPosition()
	End Method

	Method Class:Int()
		Return GADGET_SLIDER
	End Method

End Type

Type TwxProgressBar Extends TwxGadget

	Method InitGadget()
		CreateProgressBar()
	End Method
	
	Method CreateProgressBar()
	
		widget = New MaxGuiwxGauge.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, wxGA_SMOOTH)
		
		Rethink()
		
		SetShow(True)
		
	End Method

	Method SetValue(value:Float)
		MaxGuiwxGauge(widget).SetValue(Int(value * 100))
	End Method
	
	Method Class:Int()
		Return GADGET_PROGBAR
	End Method

End Type

Type TwxComboBox Extends TwxGadget

	Method InitGadget()
		CreateComboBox()
	End Method
	
	Method CreateComboBox()
	
		If style & COMBOBOX_EDITABLE Then
			widget = New MaxGuiwxComboBox.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, 0)
		Else
			widget = New MaxGuiwxChoice.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, 0)
		End If
		
		Rethink()
		
		SetShow(True)
		
	End Method

	Method InsertListItem(index:Int, Text:String, tip:String, icon:Int, extra:Object)
		wxControlWithItems(widget).Insert(Text, index, extra)
	End Method

	Method SetItemState:Int(index:Int, state:Int)
DebugLog "TODO : TwxComboBox::SetItemState"
	End Method

	Method ItemState:Int(index:Int)
DebugLog "TODO : TwxComboBox::ItemState"
	End Method
	
	Method SelectedItem:Int()
		Return wxControlWithItems(widget).GetSelection()
	End Method

	Method SetListItem(index:Int, Text:String ,tip:String, icon:Int, data:Object)
		wxControlWithItems(widget).SetString(index, Text)
		wxControlWithItems(widget).SetItemClientData(index, data)
	End Method


	Method SelectItem:Int(index:Int, op:Int= 1) '0=deselect 1=select 2=toggle
		wxControlWithItems(widget).SetSelection(index)
	End Method
	
	Method RemoveListItem(index:Int)
		wxControlWithItems(widget).DeleteItem(index)
	End Method

	Method Class:Int()
		Return GADGET_COMBOBOX
	End Method

End Type

Type TwxDesktop Extends TwxGadget

	Method InitGadget()
		CreateDesktop()
	End Method
	
	Method CreateDesktop()
	
		widget = Null
		
	End Method
	
	Method Rethink()
	End Method

	Method GetWidth:Int()
		Local w:Int, h:Int
		wxDisplaySize(w, h)
		Return w
	End Method
	
	Method GetHeight:Int()
		Local w:Int, h:Int
		wxDisplaySize(w, h)
		Return h
	End Method

	Method Class:Int()
		Return GADGET_DESKTOP
	End Method

	Method ClientWidth:Int()
		Local x:Int, y:Int, w:Int, h:Int
		wxClientDisplayRect(x, y, w, h)
		Return w
	End Method
	
	Method ClientHeight:Int()
		Local x:Int, y:Int, w:Int, h:Int
		wxClientDisplayRect(x, y, w, h)
		Return h
	End Method

	Method SetTooltip(Text:String)
	End Method


End Type

Type TwxListBox Extends TwxGadget

	Field imageList:wxImageList

	Method InitGadget()
		CreateListBox()
	End Method
	
	Method CreateListBox()
	
		widget = New MaxGuiwxListCtrl.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, wxLC_REPORT | wxLC_NO_HEADER | wxLC_SINGLE_SEL)
		
		Rethink()
		
		SetShow(True)
		
	End Method

	Method InsertListItem(index:Int, Text:String, tip:String, icon:Int, extra:Object)

		If Not imageList Then
			icon = -1
		End If
		
		MaxGuiwxListCtrl(widget).InsertListItem(index, Text, icon, extra)
	End Method

	Method SetListItem(index:Int, Text:String ,tip:String, icon:Int, data:Object)

		If Not imageList Then
			icon = -1
		End If
		
		MaxGuiwxListCtrl(widget).SetListItem(index, Text, icon, data)
	End Method

	Method SetListItemState(index:Int, state:Int)
DebugLog "TwxListBox::SetListItemState"
		'MaxGuiQListView(widget).setListItemState(index, state)
	End Method

	Method ListItemState:Int(index:Int)
DebugLog "TwxListBox::ListItemState"
		'Return MaxGuiQListView(widget).listItemState(index)
	End Method

	'Method SelectItem:Int(index:Int, op:Int= 1) '0=deselect 1=select 2=toggle
'DebugLog "TQtListBox::SelectItem"
	'	MaxGuiQListView(widget).selectItem(index, op)
	'End Method

	Method RemoveListItem(index:Int)
		MaxGuiwxListCtrl(widget).DeleteItem(index)
	End Method

	Method ClearListItems()
		MaxGuiwxListCtrl(widget).DeleteAllItems()
	End Method

'	Method ItemState:Int(index:Int)
'DebugLog "TQtListBox::ItemState"
'	End Method

	Method SetIconStrip(iconstrip:TIconStrip)
		icons = TwxIconStrip(iconstrip)
		If icons Then
			imageList = icons.GetImageList()
			MaxGuiwxListCtrl(widget).SetImageList(imageList, wxIMAGE_LIST_SMALL)
		End If
	End Method

	Method Class:Int()
		Return GADGET_LISTBOX
	End Method

End Type

Type TwxHTMLView Extends TwxGadget
	Method CreateHTMLView:TwxHTMLView(x:Int, y:Int, w:Int, h:Int, label:String, group:TGadget, style:Int) Abstract

	Method InitGadget() Abstract
	
	Method Stop() Abstract
	Method SetText(url:String) Abstract
	Method GetText:String() Abstract
	Method Activate(cmd:Int) Abstract
	
	Method Class:Int()
		Return GADGET_HTMLVIEW
	End Method

End Type

Type TwxTabber Extends TwxGadget

	Field imageList:wxImageList

	Method InitGadget()
		CreateTabber()
	End Method
	
	Method CreateTabber()
	
		widget = New MaxGuiwxNotebook.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, 0)
		
		Rethink()
		
		SetShow(True)
		
	End Method

	Method InsertListItem(index:Int, Text:String, tip:String, icon:Int, extra:Object)
		
		If Not imageList Then
			icon = -1
		End If
		
		MaxGuiwxNotebook(widget).InsertListItem(index, Text, tip, icon, extra)
	End Method

	Method SetListItem(index:Int, Text:String ,tip:String, icon:Int, data:Object)
		
		If Not imageList Then
			icon = -1
		End If
		
		MaxGuiwxNotebook(widget).SetListItem(index, Text, tip, icon, data)
	End Method
	
	Method RealParentForChild:wxWindow()
		Return MaxGuiwxNotebook(widget).clientWidget
	End Method

	Method ClientWidth:Int()
		Return MaxGuiwxNotebook(widget).ClientWidth()
	End Method

	Method ClientHeight:Int()
		Return MaxGuiwxNotebook(widget).ClientHeight()
	End Method
	
	Method SelectedItem:Int()
		Return MaxGuiwxNotebook(widget).GetSelection()
	End Method

	Method SelectItem:Int(index:Int, op:Int= 1) '0=deselect 1=select 2=toggle
		' only set if it is not currently selected.
		If index <> SelectedItem() Then
			MaxGuiwxNotebook(widget).SetSelection(index)
		End If
	End Method

	Method RemoveListItem(index:Int)
		MaxGuiwxNotebook(widget).RemoveListItem(index)
	End Method

	Method Rethink()
		Super.Rethink()
	
		LayoutKids()
	End Method

	Method SetIconStrip(iconstrip:TIconStrip)
		icons = TwxIconStrip(iconstrip)
		If icons Then
			imageList = icons.GetImageList()
			MaxGuiwxNotebook(widget).SetImageList(imageList)
		End If
	End Method

	Method Class:Int()
		Return GADGET_TABBER
	EndMethod

End Type

Type TwxTreeViewNode Extends TwxGadget

	Field item:wxDataViewItem

	Method CreateNode:TwxTreeViewNode(Text:String, group:TwxGadget, tree:wxWindow, style:Int, icon:Int)
		Self.style = style
		parent = group
		widget = tree
		'InitGadget()

		MaxGuiwxDataViewTreeCtrl(widget).InsertNode(Self, icon)
		
		'LockLayout()
		
		If (LocalizationMode() & LOCALIZATION_OVERRIDE) Then
			LocalizeGadget(Self, Text)
		Else
			SetText(Text)
		EndIf

		If parent Then
			parent.kids.Remove(Self)
			parent.kids.AddLast(Self)
		End If
		
		Return Self
	End Method

	Method InitGadget()
	End Method
	
	Method InsertNode:TGadget(index:Int, Text:String, icon:Int)
		Local node:TwxTreeViewNode = New TwxTreeViewNode.CreateNode(Text, Self, widget, index, icon)
		'node.SetIcon icon
		node._SetParent Self
		Return node
	End Method

	Method ModifyNode(Text$, icon:Int)
'		Local image:QIcon
'		
'		If icons And icon >= 0 Then
'			image = icons.icons[icon]
'		End If
'		
'		MaxGuiQTreeView(widget).setItemText(item, text)
'		If image Then
'			item.setIcon(image)
'		End If
	End Method

	Method RootNode:TGadget()
		If parent Then
			Return parent.RootNode()
		End If
	End Method

	Method SetShow(truefalse:Int)

	End Method
	
	Method SelectedNode:TGadget()
		Return MaxGuiwxDataViewTreeCtrl(widget).SelectedNode()
	End Method
	
	Method CountKids:Int()
		Return MaxGuiwxDataViewTreeCtrl(widget).GetChildCount(item)
	End Method

	Method SetText(Text:String)
		MaxGuiwxDataViewTreeCtrl(widget).SetItemText(item, Text)
	End Method
	
	Method GetText:String()
		Return MaxGuiwxDataViewTreeCtrl(widget).GetItemText(item)
	End Method
	
'	Method Activate(command:Int)
'		If command = ACTIVATE_EXPAND Then
'			Local index:QModelIndex = MaxGuiQTreeView(widget).model.indexFromItem(item)
'			MaxGuiQTreeView(widget).expand(index)
'			Return
'		End If
'		
'		If command = ACTIVATE_COLLAPSE Then
'			Local index:QModelIndex = MaxGuiQTreeView(widget).model.indexFromItem(item)
'			MaxGuiQTreeView(widget).collapse(index)
'			Return
'		End If
'		
'		Super.Activate(command)
'	End Method

	Method Free()
'		If item.parent() Then
'			item.parent().removeRows(item.row(), 1)
'		End If
	End Method

	Method Class:Int()
		Return GADGET_NODE
	EndMethod

End Type


Type TwxTreeView Extends TwxTreeViewNode

	Method InitGadget()
		CreateTreeView()
	End Method
	
	Method CreateTreeView()

		widget = New MaxGuiwxDataViewTreeCtrl.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, wxDV_NO_HEADER)
		
		' get root item
		item = New wxDataViewItem.Create(Null)
		
		Rethink()
		
		SetShow(True)
		
	End Method

	Method RootNode:TGadget()
		Return Self
	End Method
	
	Method SetText(Text:String)
	End Method

	Method SetShow(truefalse:Int)
		If truefalse Then
			'widget.setAttribute(Qt_WA_DontShowOnScreen, False)
			widget.show()
			
			Rethink()
		Else
			widget.hide()
			'widget.setAttribute(Qt_WA_DontShowOnScreen, True)
		EndIf
		
	End Method

	Method Class:Int()
		Return GADGET_TREEVIEW
	EndMethod

End Type

Type TwxTextArea Extends TwxGadget

	Method InitGadget()
		CreateTextArea()
	End Method
	
	Method CreateTextArea()
	
		widget = New MaxGuiwxScintilla.MCreate(Self, TwxGadget(parent).RealParentForChild(), xpos, ypos, width, height, 0)
		
		If style & TEXTAREA_WORDWRAP Then
			MaxGuiwxScintilla(widget).SetWrapMode(wxSCI_WRAP_WORD)
		End If
		
		If style & TEXTAREA_READONLY Then
			MaxGuiwxScintilla(widget).SetReadOnly(True)
		End If
		
		Rethink()
		
		SetShow(True)
		
	End Method

	Method SetText(Text:String)
		MaxGuiwxScintilla(widget).SetText(Text)
		MaxGuiwxScintilla(widget).ClearStyles()
	End Method

	Method ReplaceText(pos:Int, length:Int, Text:String, units:Int)
		MaxGuiwxScintilla(widget).ReplaceText(pos, length, Text, units)
	End Method

	Method AddText(Text:String)
		MaxGuiwxScintilla(widget).AppendText(Text)
	End Method

	Method AreaText:String(pos:Int, length:Int, units:Int)
		Return MaxGuiwxScintilla(widget).AreaText(pos, length, units)
	End Method

	Method AreaLen:Int(units:Int)
		Return MaxGuiwxScintilla(widget).AreaLen(units)
	End Method

	Method LockText()
		'MaxGuiQPlainTextEdit(widget).lock()
	End Method

	Method UnlockText()
		'MaxGuiQPlainTextEdit(widget).unlock()
	End Method

	Method SetTabs(tabwidth:Int)
		MaxGuiwxScintilla(widget).SetTabWidth(tabwidth)
	End Method

	Method SetMargins(leftmargin:Int)
		'MaxGuiQPlainTextEdit(widget).setViewportMargins(leftmargin, 0, 0, 0)
	End Method

	Method GetCursorPos:Int(units:Int)
		Return MaxGuiwxScintilla(widget).GetCursorPos(units)
	End Method

	Method GetSelectionLength:Int(units:Int)
		Return MaxGuiwxScintilla(widget).GetSelectionLength(units)
	End Method

	Method SetStyle(r:Int, g:Int, b:Int, flags:Int, pos:Int, length:Int, units:Int)
		MaxGuiwxScintilla(widget).SetTextStyle(r, g, b, flags, pos, length, units)
	End Method	

	Method SetSelection(pos:Int, length:Int, units:Int)
		MaxGuiwxScintilla(widget).SetTextSelection(pos, length, units)
	End Method

	Method CharX:Int(char:Int)
		Return MaxGuiwxScintilla(widget).CharX(char)
	End Method

	Method CharY:Int(char:Int)
		Return MaxGuiwxScintilla(widget).CharY(char)
	End Method

	Method CharAt:Int(line:Int)
		Return MaxGuiwxScintilla(widget).CharAt(line)
	End Method

	Method LineAt:Int(index:Int)
		Return MaxGuiwxScintilla(widget).LineAt(index)
	End Method

	Method SetColor(r:Int, g:Int, b:Int)
		'Local pal:QPalette = widget.palette()
		'pal.SetColor(QPalette.Role_Base, New QColor.Create(r, g, b))
		'widget.setPalette(pal)
	End Method

	Method Class:Int()
		Return GADGET_TEXTAREA
	EndMethod

End Type

Type TwxToolBar Extends TwxGadget

	Field lastToolId:Int = 300

	Method InitGadget()
		CreateToolBar()
	End Method
	
	Method CreateToolBar()

		If parent.Class() <> GADGET_WINDOW Then
			DebugLog "Parent is not a WINDOW!?"
			Return
		End If
	
		' have the wxFrame create a toolbar instance for us.
		widget = TwxWindow(parent).CreateToolBar()
	
		widget.ConnectAny(wxEVT_COMMAND_TOOL_CLICKED, OnToolAction, Self)
	
		Rethink()
		
		SetShow(True)
		
	End Method
	
	Function OnToolAction(event:wxEvent)
 
		Local index:Int = wxToolBar(event.parent).GetToolPos(event.GetId())
		PostGuiEvent EVENT_GADGETACTION, TwxGadget(event.userData), index

	End Function

	Method InsertListItem(index:Int, Text:String, tip:String, icon:Int, extra:Object)
		Local bitmap:wxBitmap
		
		If icons And icon >= 0 Then
			bitmap = icons.icons[icon]
		Else
			bitmap = wxNullBitmap
		End If

		If icon = GADGETICON_SEPARATOR Then
			wxToolBar(widget).InsertSeparator(index)
		Else
			wxToolBar(widget).InsertTool(index, lastToolId, Text, bitmap, Null, , tip)
		End If

		lastToolId :+ 1
		
		wxToolBar(widget).Realize()
	End Method
	
	Method SetListItemState(index:Int, state:Int)

		Local tool:wxToolBarToolBase = wxToolBar(widget).GetToolByPos(index)
		
		If tool Then
			If state & STATE_DISABLED Then
				tool.Enable(False)
			Else
				tool.Enable(True)
			End If
		End If

	End Method

	Method ListItemState:Int(index:Int)
		
		Local state:Int
		
		Local tool:wxToolBarToolBase = wxToolBar(widget).GetToolByPos(index)
		
		If tool And Not tool.IsEnabled() Then
			state :| STATE_DISABLED
		End If
		
		Return state

	End Method

	Method RemoveListItem(index:Int)
		wxToolBar(widget).DeleteToolByPos(index)
	End Method

	Method Rethink()
		' toolbar looks after its own size!
	End Method

	Method Class:Int()
		Return GADGET_TOOLBAR
	EndMethod

End Type

Type TwxMenuItem Extends TwxGadget

	Field mb:wxMenuBar
	Field menu:wxMenu
	Field item:wxMenuItem
	Field label:String

	Method InitGadget()
		CreateMenuItem()
	End Method
	
	Method CreateMenuItem()

		If parent Then
			If TwxWindow(parent) Then
				mb = TwxWindow(parent).GetMenuBar()
				If mb Then
					menu = New wxMenu.Create()
				
					label = "MAXGUI_MENU"
					mb.Append(menu, label)
				End If
			Else
				If TwxMenuItem(parent) Then
					If TwxMenuItem(parent).menu Then
						If style = wxITEM_SEPARATOR Then
							item = TwxMenuItem(parent).menu.AppendSeparator()
						Else
							If style = 0 Then
								' a submenu ?
								label = "MAXGUI_MENU"
								
								menu = New wxMenu.Create()
								item = TwxMenuItem(parent).menu.AppendSubMenu(menu, label)
							Else
								label = "MAXGUI_ITEM"
								item = TwxMenuItem(parent).menu.Append(style, label)
							End If
						End If
					Else If TwxMenuItem(parent).item Then

						Local subMenu:wxMenu = TwxMenuItem(parent).item.GetSubMenu()
						
						If Not subMenu Then
							RuntimeError("Create submenus with id/style = 0")
						End If

						If style = wxITEM_SEPARATOR Then
							item = subMenu.AppendSeparator()
						Else
							label = "MAXGUI_ITEM"
							item = subMenu.Append(style, label)
						End If

					End If
				
				End If
			End If
		Else
			menu = New wxMenu.Create()
		End If
		
		Rethink()
		
		'SetShow(True)
		
	End Method
	
	Method SetText(Text:String)
		If mb Then
			If Text Then
				Local index:Int = mb.FindMenu(label)
				If index <> wxNOT_FOUND Then
					mb.SetMenuLabel(index, Text)
					label = Text
				End If
			End If
		Else
			If menu Then
				If item Then
					item.SetItemLabel(Text)
					label = Text
				Else
					If Text Then
						menu.SetTitle(Text)
						label = Text
					End If
				End If
			Else If item Then
				If Text Then
					item.SetItemLabel(Text)
					label = Text
				End If
			End If
		End If
	End Method

	Method SetTooltip(Text:String)
'		action.setToolTip(text)
	End Method

	Method SetHotKey(hotkey:Int, modifier:Int)
		If item Then
			Local seq:String
			
			If modifier Then
				seq :+ maxModifierToString(modifier) + "+"
			End If
			
			If hotkey Then
				seq :+ maxKeyCodeToString(hotkey)
			End If
			
			If seq Then
				item.SetItemLabel(label + "~t" + seq)
			Else
				item.SetItemLabel(label)
			End If
		End If
	End Method

	Method ClientWidth:Int()
		Return 0
	End Method

	Method ClientHeight:Int()
		Return 0
	End Method

	Method Rethink()
	End Method
	
	Method SetEnabled(bool:Int)
		If item Then
			item.Enable(bool)
		End If
	End Method

	Method SetSelected(bool:Int)
		If item Then
			If Not item.IsCheckable() Then
				item.SetCheckable(True)
			End If
			
			item.Check(bool)
		End If
	End Method
	
	Method State:Int()
		Local flags:Int = Super.State()

		If item Then
			If item.IsChecked() Then
				flags :| STATE_SELECTED
			End If
		
			If Not item.IsEnabled() Then
				flags :| STATE_DISABLED
			End If
		End If

		Return flags
	End Method

	Method Class:Int()
		Return GADGET_MENUITEM
	EndMethod

End Type

' +++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Type MaxGuiwxFrame Extends wxFrame

	Field gadget:TwxGadget
	
	' this is our "client area"
	' it automatically scales to fit the inside of the window.
	Field clientWidget:wxPanel

	Method MCreate:MaxGuiwxFrame(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		Local flags:Int
		
		If style & WINDOW_TOOL Then
			flags :| wxFRAME_TOOL_WINDOW
		End If
		
		If style & WINDOW_TITLEBAR Then
			flags :| wxDEFAULT_FRAME_STYLE
		End If
		
		gadget = owner
		Super.Create(parent, -1, "", x, y, w, h, flags)
		Return Self
	End Method

	Method OnInit()
		clientWidget = New wxPanel.Create(Self, wxID_ANY)

		ConnectAny(wxEVT_CLOSE_WINDOW, _OnCloseWindow)
		ConnectAny(wxEVT_SIZE, _OnSizeWindow)
		ConnectAny(wxEVT_ACTIVATE, _OnActivate)
		ConnectAny(wxEVT_COMMAND_MENU_SELECTED, _OnMenu)
	End Method
	
	Function _OnActivate(event:wxEvent)
		If wxActivateEvent(event).GetActive() Then
			PostGuiEvent EVENT_WINDOWACTIVATE, MaxGuiwxFrame(event.parent).gadget
		End If
	End Function
	
	Function _OnCloseWindow(event:wxEvent)
		MaxGuiwxFrame(event.parent).OnCloseWindow(wxCloseEvent(event))
	End Function
	
	Method OnCloseWindow(event:wxCloseEvent)
		PostGuiEvent EVENT_WINDOWCLOSE, gadget
		Destroy()
	End Method

	Function _OnSizeWindow(event:wxEvent)
		MaxGuiwxFrame(event.parent).OnSizeWindow(wxSizeEvent(event))
	End Function

	Method OnSizeWindow(event:wxSizeEvent)
		If Not gadget.initing Then
			Local w:Int, h:Int
			event.GetSize(w, h)
		
			gadget.SetRect(gadget.xpos, gadget.ypos, w, h)
			gadget.layoutKids

			PostGuiEvent EVENT_WINDOWSIZE, gadget ,,,w,h
		End If
		
		Event.Skip()
	End Method
	
	Function _OnMenu(event:wxEvent)
		MaxGuiwxFrame(event.parent).OnMenu(wxCommandEvent(event))
	End Function
	
	Method OnMenu(event:wxCommandEvent)
		' TODO : gadget should probably be the actual TwxMenuItem, and not the containing frame
		PostGuiEvent EVENT_MENUACTION, gadget, event.GetId()
	End Method

End Type

Type MaxGuiwxButton Extends wxButton

	Field gadget:TwxGadget

	Method MCreate:MaxGuiwxButton(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		
		Local id:Int = -1
		If style = BUTTON_OK Then
			id = wxID_OK
		End If
		
		Super.Create(parent, id, "", x, y, w, h, 0)
		Return Self
	End Method

	Method OnInit()
		ConnectAny(wxEVT_COMMAND_BUTTON_CLICKED, OnClick)
	End Method

	Function OnClick(event:wxEvent)
		PostGuiEvent EVENT_GADGETACTION, MaxGuiwxButton(event.parent).gadget
	End Function
	
End Type

Type MaxGuiwxCheckBox Extends wxCheckBox

	Field gadget:TwxGadget

	Method MCreate:MaxGuiwxCheckBox(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		Super.Create(parent, -1, Null, x, y, w, h, style)
		Return Self
	End Method

	Method OnInit()
		ConnectAny(wxEVT_COMMAND_CHECKBOX_CLICKED, OnClick)
	End Method

	Function OnClick(event:wxEvent)
		PostGuiEvent EVENT_GADGETACTION, MaxGuiwxCheckBox(event.parent).gadget
	End Function
	
End Type

Type MaxGuiwxToggleButton Extends wxToggleButton

	Field gadget:TwxGadget

	Method MCreate:MaxGuiwxToggleButton(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		Super.Create(parent, -1, Null, x, y, w, h, style)
		Return Self
	End Method

	Method OnInit()
		ConnectAny(wxEVT_COMMAND_TOGGLEBUTTON_CLICKED, OnClick)
	End Method

	Function OnClick(event:wxEvent)
		PostGuiEvent EVENT_GADGETACTION, MaxGuiwxToggleButton(event.parent).gadget
	End Function
	
End Type

Type MaxGuiwxRadioButton Extends wxRadioButton

	Field gadget:TwxGadget

	Method MCreate:MaxGuiwxRadioButton(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		Super.Create(parent, -1, Null, x, y, w, h, style)
		Return Self
	End Method

	Method OnInit()
		ConnectAny(wxEVT_COMMAND_RADIOBUTTON_SELECTED, OnClick)
	End Method

	Function OnClick(event:wxEvent)
		PostGuiEvent EVENT_GADGETACTION, MaxGuiwxRadioButton(event.parent).gadget
	End Function
	
End Type

Type MaxGuiwxStaticText Extends wxStaticText

	Field gadget:TwxGadget

	Method MCreate:MaxGuiwxStaticText(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		Super.Create(parent, -1, Null, x, y, w, h, style)
		Return Self
	End Method

	Method OnInit()
	End Method

End Type

Type MaxGuiwxStaticLine Extends wxStaticLine

	Field gadget:TwxGadget

	Method MCreate:MaxGuiwxStaticLine(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		Super.Create(parent, -1, x, y, w, h, style)
		Return Self
	End Method

	Method OnInit()
	End Method

End Type

Type MaxGuiwxTextCtrl Extends wxTextCtrl

	Field gadget:TwxGadget

	Method MCreate:MaxGuiwxTextCtrl(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		Super.Create(parent, -1, "", x, y, w, h, style)
		Return Self
	End Method

	Method OnInit()
		ConnectAny(wxEVT_COMMAND_TEXT_UPDATED, OnEdit)
	End Method

	Function OnEdit(event:wxEvent)
		PostGuiEvent EVENT_GADGETACTION, MaxGuiwxTextCtrl(event.parent).gadget
	End Function

End Type

Type MaxGuiwxPanel Extends wxPanel

	Field gadget:TwxGadget

	Method MCreate:MaxGuiwxPanel(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		Super.Create(parent, -1, x, y, w, h, style)
		Return Self
	End Method

	Method OnInit()
		ConnectAny(wxEVT_MOUSE_EVENTS, OnMouseEvent, Self)
	End Method
	
	Function OnMouseEvent(event:wxEvent)
		If MaxGuiwxPanel(event.parent).gadget.sensitivity & SENSITIZE_MOUSE Then
			Local evt:wxMouseEvent = wxMouseEvent(event)
			Local x:Int, y:Int
			evt.GetPosition(x, y)
		
			Select evt.GetEventType()
				Case wxEVT_ENTER_WINDOW
					PostGuiEvent EVENT_MOUSEENTER, MaxGuiwxPanel(event.parent).gadget

				Case wxEVT_LEAVE_WINDOW
					PostGuiEvent EVENT_MOUSELEAVE, MaxGuiwxPanel(event.parent).gadget

				Case wxEVT_MOTION
					PostGuiEvent EVENT_MOUSEMOVE, MaxGuiwxPanel(event.parent).gadget, wxMouseButtonToMaxMouseButton(evt.GetButton()), , x, y

				Case wxEVT_LEFT_DOWN, wxEVT_MIDDLE_DOWN
					PostGuiEvent EVENT_MOUSEDOWN, MaxGuiwxPanel(event.parent).gadget, wxMouseButtonToMaxMouseButton(evt.GetButton()), , x, y

				Case wxEVT_RIGHT_DOWN
					PostGuiEvent EVENT_GADGETMENU, MaxGuiwxPanel(event.parent).gadget, MOUSE_RIGHT, , x, y

				Case wxEVT_LEFT_UP, wxEVT_RIGHT_UP, wxEVT_MIDDLE_UP
					PostGuiEvent EVENT_MOUSEUP, MaxGuiwxPanel(event.parent).gadget, wxMouseButtonToMaxMouseButton(evt.GetButton()), , x, y
				
				Case wxEVT_MOUSEWHEEL
					PostGuiEvent EVENT_MOUSEWHEEL, MaxGuiwxPanel(event.parent).gadget, evt.GetWheelRotation(), , x, y
			End Select
		End If
	End Function

End Type

Type MaxGuiwxStaticBox Extends wxStaticBox

	Field gadget:TwxGadget

	Method MCreate:MaxGuiwxStaticBox(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		Super.Create(parent, -1, "", x, y, w, h, style)
		Return Self
	End Method

	Method OnInit()

	End Method

End Type

Type MaxGuiwxSlider Extends wxSlider

	Field gadget:TwxGadget

	Method MCreate:MaxGuiwxSlider(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		Super.Create(parent, -1, 1, 1, 10, x, y, w, h, style)
		Return Self
	End Method

	Method OnInit()
		ConnectAny(wxEVT_SCROLL, OnScroll, Self)
	End Method
	
	Function OnScroll(event:wxEvent)
		PostGuiEvent EVENT_GADGETACTION, MaxGuiwxSlider(event.parent).gadget, wxScrollEvent(event).GetPosition()
	End Function

End Type

Type MaxGuiwxSpinButton Extends wxSpinButton

	Field gadget:TwxGadget

	Method MCreate:MaxGuiwxSpinButton(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		Super.Create(parent, -1, x, y, w, h, style)
		Return Self
	End Method

	Method OnInit()
		ConnectAny(wxEVT_SPIN, OnSpin, Self)
	End Method

	Function OnSpin(event:wxEvent)
		PostGuiEvent EVENT_GADGETACTION, MaxGuiwxSpinButton(event.parent).gadget, wxSpinEvent(event).GetPosition()
	End Function

End Type

Type MaxGuiwxScrollBar Extends wxScrollBar

	Field gadget:TwxGadget

	Method MCreate:MaxGuiwxScrollBar(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		Super.Create(parent, -1, x, y, w, h, style)
		Return Self
	End Method

	Method OnInit()
		ConnectAny(wxEVT_SCROLL, OnScroll, Self)
	End Method
	
	Function OnScroll(event:wxEvent)
		PostGuiEvent EVENT_GADGETACTION, MaxGuiwxScrollBar(event.parent).gadget, wxScrollEvent(event).GetPosition()
	End Function

End Type

Type MaxGuiwxGauge Extends wxGauge

	Field gadget:TwxGadget

	Method MCreate:MaxGuiwxGauge(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		Super.Create(parent, -1, 100, x, y, w, h, style)
		Return Self
	End Method

	Method OnInit()

	End Method
	
End Type

Type MaxGuiwxComboBox Extends wxComboBox

	Field gadget:TwxGadget

	Method MCreate:MaxGuiwxComboBox(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		Super.Create(parent, -1, "", Null, x, y, w, h, style)
		Return Self
	End Method

	Method OnInit()
		Connect(-1, wxEVT_COMMAND_COMBOBOX_SELECTED, OnSelected, Self)
	End Method

	Function OnSelected(event:wxEvent)
		PostGuiEvent EVENT_GADGETACTION, MaxGuiwxComboBox(event.parent).gadget, MaxGuiwxComboBox(event.parent).GetSelection()
	End Function
	
End Type

Type MaxGuiwxChoice Extends wxChoice

	Field gadget:TwxGadget

	Method MCreate:MaxGuiwxChoice(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		Super.Create(parent, -1, Null, x, y, w, h, style)
		Return Self
	End Method

	Method OnInit()
		Connect(-1, wxEVT_COMMAND_CHOICE_SELECTED, OnSelected, Self)
	End Method

	Function OnSelected(event:wxEvent)
		PostGuiEvent EVENT_GADGETACTION, MaxGuiwxChoice(event.parent).gadget, MaxGuiwxChoice(event.parent).GetSelection()
	End Function
	
End Type

Type MaxGuiwxListCtrl Extends wxListCtrl

	Field gadget:TwxGadget

	Method MCreate:MaxGuiwxListCtrl(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		Super.Create(parent, -1, x, y, w, h, style)
		Return Self
	End Method

	Method OnInit()

		InsertColumn(0, "Column 1")
		
		UpdateColumnWidth()
	End Method
	
	' call this whenever we resize
	Method UpdateColumnWidth()
		Local w:Int, h:Int
		GetSize(w, h)
		SetColumnWidth(0, w)
	End Method

	Method InsertListItem(index:Int, Text:String, icon:Int, data:Object)
		If icon >= 0 Then
			InsertImageStringItem(index, Text, icon)
		Else
			InsertStringItem(index, Text)
		End If
		SetItemData(index, data)
	End Method
	
	Method SetListItem(index:Int, Text:String, icon:Int, data:Object)
		SetStringItem(index, 0, Text, icon)
		SetItemData(index, data)
	End Method
	
End Type

Type MaxGuiwxNotebook Extends wxNotebook

	Field gadget:TwxGadget

	' this is the client widget for ALL pages.
	' Its parent is always the current tab view - i.e. when the page changes this is reparented.
	Field clientWidget:wxPanel
	
	' each page widget contains a layout onto which the clientWidget is placed.
	' This causes the clientWidget to auto-fill the space.
	Field pages:wxPanel[0]

	Method MCreate:MaxGuiwxNotebook(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		Super.Create(parent, -1, x, y, w, h, style)
		Return Self
	End Method

	Method OnInit()
		clientWidget = New wxPanel.Create(Self)
		'clientWidget.Hide()
		
		ConnectAny(wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGED, _OnPageChanged)
		ConnectAny(wxEVT_CONTEXT_MENU, OnContextMenu)
	End Method
	
	Function _OnPageChanged(event:wxEvent)
		MaxGuiwxNotebook(event.parent).OnPageChanged(wxNotebookEvent(event))
	End Function
	
	Method OnPageChanged(event:wxNotebookEvent)
		Local index:Int = event.GetSelection()

		' reparent the clientWidget
		' remove from previous sizer
		Local sizer:wxSizer = clientWidget.GetContainingSizer()
		If sizer Then
			sizer.Remove(0)
		End If
		
		clientWidget.Reparent(pages[index])

		' clear sizer, if it isn't already empty
		sizer = pages[index].GetSizer()
		If Not sizer.IsEmpty() Then
			sizer.Remove(0)
		End If
		
		' add to the sizer
		sizer.Add(clientWidget, 1, wxEXPAND | wxALL, 0)
		
		PostGuiEvent EVENT_GADGETACTION, gadget, index
	End Method

	Function OnContextMenu(event:wxEvent)
		Local x:Int, y:Int, flags:Int
		wxContextMenuEvent(event).GetPosition(x, y)
		MaxGuiwxNotebook(event.parent).ScreenToClient(x, y)

		Local index:Int = MaxGuiwxNotebook(event.parent).HitTest(x, y, flags)

		If index <> wxNOT_FOUND Then
			PostGuiEvent EVENT_GADGETMENU, MaxGuiwxNotebook(event.parent).gadget, index
		End If
	End Function

	Method InsertListItem(index:Int, Text:String, tip:String, image:Int, extra:Object)
		Local page:wxPanel = New wxPanel.Create(Self)
		
		Local sizer:wxBoxSizer = New wxBoxSizer.Create(wxHORIZONTAL)

		' first page
		If Not clientWidget Then
			' reparent the clientWidget
			clientWidget = New wxPanel.Create(page)
			sizer.Add(clientWidget, 1, wxEXPAND | wxALL, 0)
		Else
			If sizer.IsEmpty() Then
				sizer.Add(clientWidget, 1, wxEXPAND | wxALL, 0)
			End If
		End If
		
		page.SetSizer(sizer)
		
		' add the page to our internal list
		pages = pages[..index] + [page] + pages[index..]
		
		InsertPage(index, page, Text, False, image)
	End Method

	
	Method SetListItem(index:Int, Text:String, tip:String, icon:Int, extra:Object)
		SetPageText(index, Text)
		SetPageImage(index, icon)
	End Method

	Method RemoveListItem(index:Int)

		RemovePage(index)
' TODO : sort out clientWidget parent and dispose page
'		If currentIndex() = index Then
'			' unparent the clientWidget so that it is not deleted when the page is removed.
'			clientWidget.setParent(Null)
'		End If

		Local tmp:wxPanel[] = pages
		pages = pages[..pages.length-1]
		For Local i:Int = index Until pages.length
			pages[i] = tmp[i + 1]
		Next
	
	End Method

	Method ClientWidth:Int()
		Local w:Int, h:Int
		If clientWidget Then
			clientWidget.GetSize(w, h)
		Else
			GetClientSize(w, h)
		End If
		Return w
	End Method

	Method ClientHeight:Int()
		Local w:Int, h:Int
		If clientWidget Then
			clientWidget.GetSize(w, h)
		Else
			GetClientSize(w, h)
		End If
		Return h
	End Method

End Type

Type MaxGuiwxDataViewTreeCtrl Extends wxDataViewTreeCtrl

	Field gadget:TwxGadget

	Method MCreate:MaxGuiwxDataViewTreeCtrl(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		Super.Create(parent, -1,,,,, style)
		Return Self
	End Method

	Method OnInit()
		
		ConnectAny(wxEVT_COMMAND_DATAVIEW_ITEM_EXPANDED, OnItemExpanded)
		ConnectAny(wxEVT_COMMAND_DATAVIEW_ITEM_COLLAPSED, OnItemCollapsed)
		ConnectAny(wxEVT_COMMAND_DATAVIEW_ITEM_ACTIVATED, OnItemActivated)
		ConnectAny(wxEVT_COMMAND_DATAVIEW_ITEM_CONTEXT_MENU, OnItemContextMenu)
		ConnectAny(wxEVT_COMMAND_DATAVIEW_ITEM_START_EDITING, OnItemStartEditing)
	End Method
	
	Function OnItemExpanded(event:wxEvent)
		Local item:wxDataViewItem = wxDataViewEvent(event).GetItem()
		PostGuiEvent EVENT_GADGETOPEN, MaxGuiwxDataViewTreeCtrl(event.parent).gadget,,,,, MaxGuiwxDataViewTreeCtrl(event.parent).GetItemData(item)
	End Function

	Function OnItemCollapsed(event:wxEvent)
		Local item:wxDataViewItem = wxDataViewEvent(event).GetItem()
		PostGuiEvent EVENT_GADGETCLOSE, MaxGuiwxDataViewTreeCtrl(event.parent).gadget,,,,, MaxGuiwxDataViewTreeCtrl(event.parent).GetItemData(item)
	End Function
	
	Function OnItemActivated(event:wxEvent)
		Local item:wxDataViewItem = wxDataViewEvent(event).GetItem()
		PostGuiEvent EVENT_GADGETACTION, MaxGuiwxDataViewTreeCtrl(event.parent).gadget,,,,, MaxGuiwxDataViewTreeCtrl(event.parent).GetItemData(item)
	End Function
	
	Function OnItemContextMenu(event:wxEvent)
		Local item:wxDataViewItem = wxDataViewEvent(event).GetItem()
		If item.IsOk() Then
			PostGuiEvent EVENT_GADGETMENU, MaxGuiwxDataViewTreeCtrl(event.parent).gadget, ,,,,MaxGuiwxDataViewTreeCtrl(event.parent).GetItemData(item)
		Else
			PostGuiEvent EVENT_GADGETMENU, MaxGuiwxDataViewTreeCtrl(event.parent).gadget
		End If
	End Function
	
	Function OnItemStartEditing(event:wxEvent)
		' we don't do inline editing of items in MaxGUI... *sniff*
		wxDataViewEvent(event).Veto()
	End Function

	Method InsertNode(node:TwxTreeViewNode, icon:Int)

		Local parent:wxDataViewItem = TwxTreeViewNode(node.parent).item
		Local count:Int = GetChildCount(parent)
		
		' if the parent is an item, but not a container, we need to convert it to a container 
		' so that we can add items to it.
		If Not IsContainer(parent) Then
			' get parent's parent
			Local grandParent:wxDataViewItem = TwxTreeViewNode(TwxTreeViewNode(node.parent).parent).item
			Local Text:String = GetItemText(parent)
			
			TwxTreeViewNode(node.parent).item = InsertContainer(grandParent, parent, Text, -1, -1, node.parent)
			' remove the old item
			DeleteItem(parent)
			' get the new parent item
			parent = TwxTreeViewNode(node.parent).item
		End If
		
		If node.style = 0 And count > 0 Then
			node.item = PrependItem(parent, "", icon, node)
		Else If (node.style > 0) And (node.style < count - 1) Then
			Local previous:wxDataViewItem = GetNthChild(parent, node.style)
			node.item = InsertItem(parent, previous, "", icon, node)
		Else
			' a style of -1 means append on the end
			node.item = AppendItem(parent, "", icon, node)
		End If
		
	End Method
	
	Method SelectedNode:TGadget()
		Local item:wxDataViewItem = GetSelection()

		If item.isOk() Then
			Return TGadget(GetItemData(item))
		End If
		
		Return Null
	End Method

End Type

Type MaxGuiwxScintilla Extends wxScintilla

	Field gadget:TwxGadget
	
	Field lastId:Int
	Field styles:TMap = New TMap

	Method MCreate:MaxGuiwxScintilla(owner:TwxGadget, parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		gadget = owner
		Super.Create(parent, x, y, w, h, style)
		Return Self
	End Method

	Method OnInit()

		' set a default monospaced font
		Local font:TGuiFont = LookupGuiFont(GUIFONT_MONOSPACED)
		StyleSetFontFont(wxSCI_STYLE_DEFAULT, TwxGuiFont(font).font)
		
		ClearStyles()
		
		' disable scintilla context menu
		UsePopUp(False)
		
		' fill selection to end of line
		SetSelEOLFilled(True)
		
	End Method

'	Method onCursorPositionChanged()
'		If Not locked Then
'			PostGuiEvent EVENT_GADGETSELECT, gadget
'		End If
'	End Method
	
'	Method onTextChanged()
'		If Not locked Then
'			PostGuiEvent EVENT_GADGETACTION, gadget
'		End If
'	End Method

	Method SetTextSelection(pos:Int, length:Int, units:Int)
		If units = TEXTAREA_LINES Then
			SetSelectionMode(wxSCI_SEL_LINES)
		
			GotoLine(pos)
			SetAnchor(GetLineEndPosition(pos + length - 1) + 1)
		
			SetSelectionMode(wxSCI_SEL_LINES)
		Else 
			SetSelection(pos, pos + length)
		End If
	End Method
	
	Method GetCursorPos:Int(units:Int)
		If units = TEXTAREA_LINES Then
			Return LineFromPosition(Min(GetCurrentPos(), GetAnchor()))
		Else
			' return the lowest of...
			' If there is a selection, anchor will be <> position
			Return Min(GetCurrentPos(), GetAnchor())
		End If
	End Method
	
	Method GetSelectionLength:Int(units:Int)
		Local _start:Int = GetSelectionStart()
		Local _end:Int = GetSelectionEnd()
		If units = TEXTAREA_LINES Then
			Return LineFromPosition(_end) - LineFromPosition(_start)
		Else
			Return _end - _start
		End If
	End Method

	Method AreaLen:Int(units:Int)
		If units = TEXTAREA_LINES Then
			Return LineFromPosition(GetTextLength())
		Else
			Return GetTextLength()
		End If
	End Method

	Method CharX:Int(char:Int)
		Local x:Int, y:Int
		PointFromPosition(char, x, y)
		Return x
	End Method

	Method CharY:Int(char:Int)
		Local x:Int, y:Int
		PointFromPosition(char, x, y)
		Return y
	End Method
	
	Method CharAt:Int(line:Int)
		Return PositionFromLine(line)
	End Method
	
	Method LineAt:Int(index:Int)
		Return LineFromPosition(index)
	End Method

	Method ReplaceText(pos:Int, length:Int, Text:String, units:Int)
		If units = TEXTAREA_LINES Then
			Local _start:Int = PositionFromLine(pos)
			Local _end:Int = GetLineEndPosition(pos + length - 1) + 1
			
			SetTargetStart(_start)
			SetTargetEnd(_end)
		Else
			SetTargetStart(pos)
			SetTargetEnd(pos + length)
		End If
		
		ReplaceTarget(Text)
	End Method

	Method SetTextStyle(r:Int, g:Int, b:Int, flags:Int, pos:Int, length:Int, units:Int)
	
		Local id:Int = GetStyleId(r, g, b, flags)
		
		If units = TEXTAREA_LINES Then
			Local _pos:Int = PositionFromLine(pos)
			length = GetLineEndPosition(pos + length - 1) + 1 - _pos
			pos = _pos
		End If
		
		StartStyling(pos, 31)
		SetStyling(length, id)
	End Method

	Method GetStyleId:Int(r:Int, g:Int, b:Int, flags:Int)
		Local f:String = r + "," + g + "," + b + "," + flags

		Local format:String = String(styles.ValueForKey(f))

		' format not found in our cache? Add it		
		If Not format Then
			lastId = lastId + 1
			
			' if we get to the max, reset.
			' Hopefully this won't break any currently used styles.
			' What are the chances of someone creating 200 unique styles? ... meh
			If lastId = 255 Then
				lastId = 40
			End If
			
			format = String(lastId)
			
			StyleSetForeground(lastId, New wxColour.Create(r, g, b))
			
			' bold
			If flags & TEXTFORMAT_BOLD Then
				StyleSetBold(lastId, True)
			End If
			
			' italic
			If flags & TEXTFORMAT_ITALIC Then
				StyleSetItalic(lastId, True)
			End If
			
			' underline
			If flags & TEXTFORMAT_UNDERLINE Then
				StyleSetUnderline(lastId, True)
			End If
			
			' strikethrough? ??
			
			' cache new style
			styles.Insert(f, format)
		End If
		
		Return format.ToInt()
	End Method
	
	Method ClearStyles()
		StyleClearAll()
		lastId = 40
		styles.Clear()
	End Method

	Method AreaText:String(pos:Int, length:Int, units:Int)

		If length <> TEXTAREA_ALL Then
			Local _start:Int, _end:Int
			
			If units = TEXTAREA_LINES Then
				_start = PositionFromLine(pos)
				_end = GetLineEndPosition(pos + length - 1) + 1
			Else
				_start = pos
				_end = pos + length
			End If
		
			Return GetTextRange(_start, _end)
		Else
			Return GetText()
		End If
	
	End Method
Rem 
	Method focusOutEvent(event:QFocusEvent)
		PostGuiEvent EVENT_GADGETLOSTFOCUS, gadget
		Super.focusOutEvent(event)
	End Method
End Rem
End Type

