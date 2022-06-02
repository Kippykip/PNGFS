'SuperStrict
Framework wx.wxApp
Import wx.wxFrame
Import wx.wxFilePickerCtrl
Import wx.wxFileDialog
Import wx.wxSpinCtrl
Import wx.wxStaticText
Import wx.wxStaticLine
Import wx.wxButton
Import wx.wxCheckBox
Import wx.wxAboutBox
Import wx.wxScrolledWindow
Import wx.wxStaticBitmap
Import wx.wxProcess
Import brl.pngloader
Import brl.tgaloader
Import brl.jpgloader
Import brl.bmploader
Import brl.pixmap
Import brl.retro
?Win32
Import pub.Win32
?

'Imports
Include "PNGFS.bmx"
Include "extension_list.bmx"

'Constants
Const PNGFS_Version:String = "V0.2"
Const PANE_COLLAPSE:Int = 1
Const PANE_EXPAND:Int = 2
Const PANE_SETLABEL:Int = 3
Const PANE_F2PFS:Int = 4
Const PANE_PFS2F:Int = 5
Const PANE_ABOUT:Int = wxID_ABOUT
Const PANE_QUIT:Int = wxID_EXIT

'Incbin
Incbin "incbin\pngfs_bg.png"
Incbin "incbin\banner_bg.png"
Incbin "incbin\banner_l.png"
Incbin "incbin\banner_s.png"

'Global vars for PNGFS
Global WorkspacePixmap:TPixmap = LoadPixmap("incbin::incbin\pngfs_bg.png")
ToPixmapWorkspace.Banner[0] = LoadPixmap("incbin::incbin\banner_bg.png")
ToPixmapWorkspace.Banner[1] = LoadPixmap("incbin::incbin\banner_l.png")
ToPixmapWorkspace.Banner[2] = LoadPixmap("incbin::incbin\banner_s.png")
Global PreviewPixmap:wxPixmap
Global PNGFS_Frame:MyApp
New MyApp.run()

'This is what gets displayed in the background
Type wxPixmap
	Field sw:wxScrolledWindow 'Scrolled Window
	Field bm:wxBitmap 'Bitmap
	Field sb:wxStaticBitmap 'Static Bipmap
	Field pm:TPixmap 'Pixmap
	
	Function Update(TMP_Frame:wxFrame = Null)
		If(PreviewPixmap)
			PreviewPixmap.sb.Destroy()
			'PreviewPixmap.bm.Delete()
		Else
			PreviewPixmap = New wxPixmap
			PreviewPixmap.sw = New wxScrolledWindow.Create(TMP_Frame)

		EndIf
		PreviewPixmap.pm = ConvertPixmap(WorkspacePixmap, PF_RGBA8888)
		'PreviewPixmap.pm.Convert(PF_RGB888) 'Remove alpha in preview
		PreviewPixmap.bm = wxBitmap.CreateBitmapFromPixmap(PreviewPixmap.pm)
		PreviewPixmap.sb = New wxStaticBitmap.Create(PreviewPixmap.sw, -1, PreviewPixmap.bm)
		PreviewPixmap.sw.SetScrollbars(10, 10, PixmapWidth(PreviewPixmap.pm) / 10, PixmapHeight(PreviewPixmap.pm) / 10)
		PreviewPixmap.sw.scroll(0, 0)
	End Function
	
End Type

Type MyApp Extends wxApp
	Field frame:MyFrame

	Method OnInit:Int()
		PNGFS_Frame = Self
		frame = MyFrame(New MyFrame.Create(Null, -1, "PNGFS Converter Tool ", -1, -1, 420, 300, wxDEFAULT_FRAME_STYLE))
		frame.show()
		SetIcon()
		Return True
	End Method
End Type

'Windows only
Function SetIcon()
	?Win32
	SendMessageW(GetActiveWindow(), WM_SETICON, 0, LParam(LoadIconW(GetModuleHandleW(Null), 101)))
	?
End Function

Type MyFrame Extends wxFrame
	Method OnInit:Int()
		'Statusbar
		CreateStatusBar(2)
		SetStatusText("PNGFS Conversion Tools " + PNGFS_Version, 0)
		SetStatusText("No file loaded.", 1)

		'Make menubar
		Local paneMenu:wxMenu = New wxMenu.Create()
		paneMenu.Append(PANE_F2PFS, "Convert File to PNGFS...", "Converts a binary file into a 'PNG File Storage' PNG image.")
		paneMenu.Append(PANE_PFS2F, "Convert PNGFS to File...", "Converts a 'PNG File Storage' image back into a file again.")
		paneMenu.AppendSeparator()
		paneMenu.Append(PANE_QUIT, "Quit~tAlt-F4")
		Local helpMenu:wxMenu = New wxMenu.Create()
		helpMenu.Append(PANE_ABOUT)
		Local menuBar:wxMenuBar = New wxMenuBar.Create()
		menuBar.Append(paneMenu, "&Convert")
		menuBar.Append(helpMenu, "&Help")
		SetMenuBar(menuBar)
		
		If Not (WorkspacePixmap) Then RuntimeError("Default Pixmap couldn't be loaded PLS FIX KIPPYKIP U IDIOT")
		wxPixmap.Update(Self)

		Centre() 'Centers the whole entire window
		Connect(PANE_F2PFS, wxEVT_COMMAND_MENU_SELECTED, OnFile2PNGFS)
		Connect(PANE_PFS2F, wxEVT_COMMAND_MENU_SELECTED, OnPNGFS2File)
		Connect(PANE_ABOUT, wxEVT_COMMAND_MENU_SELECTED, OnAbout)
		Connect(PANE_QUIT, wxEVT_COMMAND_MENU_SELECTED, Quit)
		Connect(wxID_ANY, wxEVT_UPDATE_UI, UpdateUI) 'Update window, might be unused idk yet
	End Method

	
	Function OnFile2PNGFS(event:wxEvent)
		Local dlg:MyDialog = New MyDialog.CreateMyDialog(wxFrame(event.parent))
		dlg.ShowModal()
		dlg.Free()
	End Function
	
	'Convert PNGFS to file
	Function OnPNGFS2File(event:wxEvent)
		Local TMP_InputFile:String = wxFileSelector("Open Source PNGFS File", "", "", "", "PNGFS File (*.png)|*.png;", wxFLP_OPEN | wxFLP_FILE_MUST_EXIST)
		If(Len(TMP_InputFile) <= 0) Then Return
		WorkspacePixmap = LoadPixmap(TMP_InputFile)
		If Not(WorkspacePixmap)
			wxMessageBox("Failed to load the input image! Is it a PNG?", "Error loading file!", wxICON_ERROR)
			Return
		EndIf
		Local TMP_Header:PNGFS_Header = PNGFS_Header.PixmapToHeader(WorkspacePixmap)
		If Not(TMP_Header)
			wxMessageBox("Failed to read header information! Is the selected file a PNGFS supported image?", "Error loading file!", wxICON_ERROR)
			Return
		EndIf
		
		'Output shit
		Local TMP_OutputFile:String = wxFileSelector("Select Output File", "", TMP_Header.InternalFilename, "", GetExtensionInfo(TMP_Header.InternalFilename), wxFD_SAVE | wxFD_OVERWRITE_PROMPT)
		If(Len(TMP_OutputFile) <= 0) Then Return
		
		If(wxMessageBox(TMP_Header.PageCount + " PNGFS Page(s) will extracted into a file of " + TMP_Header.TotalSize + " bytes. Continue?", "Please confirm", wxICON_QUESTION | wxYES_NO, wxWindow(event.parent)) = wxNO)
			Return
		EndIf
		
		Local TMP_TestWrite:Int = CreateFile(TMP_OutputFile)
		If(TMP_TestWrite <= 0)
			wxMessageBox("Failed to write an output file! Do you have permission in this directory?", "Error writing file!", wxICON_ERROR)
			Return
		EndIf
		
		Local TMP_Conv:ToFileWorkspace = ConvertPixmapToFile(TMP_InputFile, TMP_OutputFile)
		If(Len(TMP_Conv.ErrorStatus) > 0)
			wxMessageBox(TMP_Conv.ErrorStatus, "Error writing file!", wxICON_ERROR)
			Return
		EndIf
		wxMessageBox("Sucessfully extracted PNGFS file!", "Completed!", wxICON_INFORMATION)
		
		wxPixmap.Update()
		PNGFS_Frame.frame.SetStatusText(TMP_InputFile, 1)
	End Function
	
	Function Quit(event:wxEvent)
		wxWindow(event.parent).Close(True)
	End Function
	
	Function OnAbout(event:wxEvent)
		Local info:wxAboutDialogInfo = New wxAboutDialogInfo.Create()
		info.SetName("PNGFS Converter Tool")
		info.SetDescription("This tool converts between binary files and PNG images, allowing simple file sharing on social media.")
		info.SetWebSite("https://github.com/Kippykip/PNGFS")
		info.SetVersion(PNGFS_Version)
		info.SetCopyright("PNGFS Converter Tool - 2022 Kippykip~nPatreons:~n" + ..
			"arceus, Lachlan Hill, Swithdas, bert, Lachlan Moore, Uncle Cletus, Yacob, Garwaron")
		wxAboutBox(info)
	End Function
	
	' Menu command update functions
	Function UpdateUI(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
	End Function

End Type

Type MyDialog Extends wxDialog
	Global Handle:MyDialog
	Field CurrentDialog:wxSizer
	Field BG_UseBaseCanvas:wxCheckBox
	Field BG_EnableDithering:wxCheckBox
	Field BG_FilePicker:wxFilePickerCtrl
	Field BG_ImagePathText:wxStaticText
	Field BG_SpinWidth:wxSpinCtrl, BG_SpinHeight:wxSpinCtrl
	Field IO_InputFilePicker:wxFilePickerCtrl
	Field IO_OutputFilePicker:wxFilePickerCtrl
	Field IO_InternalName:wxTextCtrl
	Field IO_ConvertBtn:wxButton
	
	'IDs for events
	Const ID_UseBaseCanvas:Int = 1
	Const ID_ConvertBtn:Int = 2
	Const ID_BGFilePicker:Int = 3
	Const ID_InputFilePicker:Int = 4
	Const ID_OutputFilePicker:Int = 5
	Const ID_InternalName:Int = 6
	
	Method CreateMyDialog:MyDialog(parent:wxFrame)
		Return MyDialog(Create_(parent, wxID_ANY, "Convert File to PNGFS Wizard", -1, -1, -1, -1, wxDEFAULT_DIALOG_STYLE))
	End Method
	
	Method OnInit:Int()
		'Create the main window for the conversion box, make it global too its hella easier
		If(Handle) Then Handle = Null '
		CurrentDialog = New wxBoxSizer.Create(wxVERTICAL)
		Handle = Self
		
		'Canvas size options
		CurrentDialog.Add(New wxStaticText.Create(Self, -1, "Canvas Width: ", 4, 8, -1, -1, 0), 0, wxALL, 0)
		BG_SpinWidth = New wxSpinCtrl.Create(Self, -1, "128", 128, 4, 64, -1, wxGROW | wxLEFT | wxRIGHT | wxTOP, 32, 99999)
		CurrentDialog.Add(BG_SpinWidth)
		CurrentDialog.Add(New wxStaticText.Create(Self, -1, "Canvas Height: ", 212, 8, -1, -1, 0), 0, wxALL, 0)
		BG_SpinHeight = New wxSpinCtrl.Create(Self, -1, "128", 332, 4, 64, -1, wxGROW | wxLEFT | wxRIGHT | wxTOP, 32, 99999)
		CurrentDialog.Add(BG_SpinHeight)
		CurrentDialog.Add(New wxStaticLine.Create(Self, -1, 0, 32, 394, 1))
		
		'Background Canvas options
		BG_UseBaseCanvas = New wxCheckBox.Create(Self, ID_UseBaseCanvas, "Use a Background Canvas", 4, 40)
		CurrentDialog.Add(BG_UseBaseCanvas)
		'Dithering option
		BG_EnableDithering = New wxCheckBox.Create(Self, -1, "Enable Dithering Pattern", 200, 40)
		BG_EnableDithering.Disable()
		BG_EnableDithering.SetValue(1)
		CurrentDialog.Add(BG_EnableDithering)
		BG_ImagePathText = New wxStaticText.Create(Self, -1, "Background Image Path: ", 4, 64)
		BG_ImagePathText.Disable()
		CurrentDialog.Add(BG_ImagePathText)
		BG_FilePicker = New wxFilePickerCtrl.Create(Self, ID_BGFilePicker, "", "Select a background image file", "Image Files (*.png;*.jpg;*.bmp;*.tga)|*.png;*.jpg;*.bmp;*.tga", 144, 60, 244)
		CurrentDialog.Add(BG_FilePicker)
		BG_FilePicker.Disable()
		
		'Input/Output + Internal filename
		CurrentDialog.Add(New wxStaticLine.Create(Self, -1, 0, 94, 394, 1))
		CurrentDialog.Add(New wxStaticText.Create(Self, -1, "Input File Path (*.*): ", 4, 108))
		IO_InputFilePicker = New wxFilePickerCtrl.Create(Self, ID_InputFilePicker, "", "Select an input file", "*.*", 144, 104, 244, -1, wxFLP_USE_TEXTCTRL | wxFLP_FILE_MUST_EXIST)
		CurrentDialog.Add(IO_InputFilePicker)
		CurrentDialog.Add(New wxStaticText.Create(Self, -1, "Output File Path (*.png): ", 4, 136))
		IO_OutputFilePicker = New wxFilePickerCtrl.Create(Self, ID_OutputFilePicker, "", "Select an output file", "PNG Images (*.png)|*.png", 144, 132, 244, -1, wxFLP_USE_TEXTCTRL | wxFLP_SAVE | wxFLP_OVERWRITE_PROMPT)
		CurrentDialog.Add(IO_OutputFilePicker)
		CurrentDialog.Add(New wxStaticText.Create(Self, -1, "Internal Filename Inside PNG (Max 12 Characters): ", 4, 164))
		IO_InternalName = New wxTextCtrl.Create(Self, ID_InternalName, "FILENAME.BIN", 292, 160, 96)
		IO_InternalName.SetMaxLength(12)
		CurrentDialog.Add(IO_InternalName)
	'	CurrentDialog.Add(New wxStaticText.Create(Self, -1, "This dialog allows you to test the wxCollapsiblePane control"), 0, wxALL, 5)
		IO_ConvertBtn = New wxButton.Create(Self, ID_ConvertBtn, "Convert", 144, 186)
		CurrentDialog.Add(IO_ConvertBtn)
		IO_ConvertBtn.Disable()

	'Testing
	'	wxShell("notepad")

		Connect(ID_UseBaseCanvas, wxEVT_CHECKBOX, EVT_UseBaseCanvas)
		Connect(ID_BGFilePicker, wxEVT_COMMAND_FILEPICKER_CHANGED, EVT_BGFilePicker)
		Connect(ID_InputFilePicker, wxEVT_COMMAND_FILEPICKER_CHANGED, EVT_InputFilePicker)
		Connect(ID_OutputFilePicker, wxEVT_COMMAND_FILEPICKER_CHANGED, EVT_OutputFilePicker)
		Connect(ID_InternalName, wxEVT_TEXT, EVT_InternalName)
		Connect(ID_ConvertBtn, wxEVT_COMMAND_BUTTON_CLICKED, EVT_ConvertBtn)
		'Connect(-1, wxEVT_CLOSE, EVT_Closed)
	End Method
	
	'Refresh boxes function
	Method RefreshAll()
		'Disable/Enable these boxes depending on whether background canvas is checked
		If(BG_UseBaseCanvas.GetValue())
			BG_EnableDithering.Enable()
			BG_ImagePathText.Enable()
			BG_FilePicker.Enable()
		Else
			BG_EnableDithering.Disable()
			BG_ImagePathText.Disable()
			BG_FilePicker.Disable()
		EndIf
		
		'Steps to enable the conversion button
		Local TMP_EnableConvert:Int = True
		If(BG_UseBaseCanvas.GetValue() > 0)
			If Not (Len(BG_FilePicker.GetPath()) > 0 And FileType(BG_FilePicker.GetPath()) = 1 And WorkspacePixmap) Then TMP_EnableConvert = False
		EndIf
		If Not (Len(IO_InputFilePicker.GetPath()) > 0 And FileType(Handle.IO_InputFilePicker.GetPath()) = 1) Then TMP_EnableConvert = False
		If(Len(IO_OutputFilePicker.GetPath()) <= 0) Then TMP_EnableConvert = False
		If(Len(IO_InternalName.GetValue()) <= 0) Then TMP_EnableConvert = False
		'Update the button
		If(TMP_EnableConvert)
			IO_ConvertBtn.Enable()
		Else
			IO_ConvertBtn.Disable()
		EndIf
	End Method
	
	'On background Canvas Checkbox
	Function EVT_UseBaseCanvas(event:wxEvent)
		Handle.RefreshAll()
	End Function
	
	'On background Canvas Checkbox
	Function EVT_InternalName(event:wxEvent)
		Handle.RefreshAll()
	End Function
	
	'On background Canvas Checkbox
	Function EVT_OutputFilePicker(event:wxEvent)
		Handle.RefreshAll()
	End Function
	
	'Background canvas file picker
	Function EVT_BGFilePicker(event:wxEvent)
		'Update Pixmap stuff
		Local TMP_BGImagePath:String = Handle.BG_FilePicker.GetPath()
		If(Len(TMP_BGImagePath) > 0 And FileType(TMP_BGImagePath) = 1) 'Path is set and file exists
			WorkspacePixmap = LoadPixmap(TMP_BGImagePath)
			If(WorkspacePixmap)
				Handle.BG_SpinWidth.SetValue(PixmapWidth(WorkspacePixmap))
				Handle.BG_SpinHeight.SetValue(PixmapHeight(WorkspacePixmap))
				WorkspacePixmap = ConvertPixmap(WorkspacePixmap, PF_RGBA8888)
			Else
				wxMessageBox("Could not load the input image, is the base canvas filepath an image?", "Error loading file!", wxICON_ERROR)
				WorkspacePixmap = Null
			EndIf
		EndIf
		
		Handle.RefreshAll()
	End Function
	
	'Input file, file picker change
	Function EVT_InputFilePicker(event:wxEvent)
		If(Len(Handle.IO_InputFilePicker.GetPath()) > 0)
			Local TMP_FullPath:String = StripPath(Handle.IO_InputFilePicker.GetPath())
			Local TMP_Ext:String = Left(StripFilename(TMP_FullPath), 11)
			Local TMP_FN:String = Left(StripExtension(TMP_FullPath), 12 - Len(TMP_Ext))
			Handle.IO_InternalName.SetValue(TMP_FN + TMP_Ext)
		EndIf
	End Function
	
	'This is where the magic happens!
	Function EVT_ConvertBtn(event:wxEvent)
		Handle.IO_ConvertBtn.Disable()
		Local TMP_EnableDithering:Byte = False
		
		'Is Use Base Canvas enabled?
		If(Handle.BG_UseBaseCanvas.GetValue())
			WorkspacePixmap = LoadPixmap(Handle.BG_FilePicker.GetPath())
			If Not(WorkspacePixmap) Then Return ConvertError("Read error on Base Canvas image!")
			WorkspacePixmap = ConvertPixmap(WorkspacePixmap, PF_RGBA8888)
			
			'Width is an even number?
			If(TMP_EnableDithering And Int(Floor(Float(Handle.BG_SpinWidth.GetValue()) / 2) * 2) = Handle.BG_SpinWidth.GetValue())
				If(wxMessageBox("Would you like to resize the canvas width to be not even? This can massively improve the dithering effect!", "Please confirm", wxICON_QUESTION | wxYES_NO, Handle) = wxYES)
					Handle.BG_SpinWidth.SetValue(Handle.BG_SpinWidth.GetValue() + 1) 'Add 1 pixel to width
				EndIf
			EndIf
			WorkspacePixmap = ResizePixmap(WorkspacePixmap, Handle.BG_SpinWidth.GetValue(), Handle.BG_SpinHeight.GetValue())
			If(Handle.BG_EnableDithering.GetValue() = 1) Then TMP_EnableDithering = True
		Else
			WorkspacePixmap = CreatePixmap(Handle.BG_SpinWidth.GetValue(), Handle.BG_SpinHeight.GetValue(), PF_RGBA8888)
			ClearPixels(WorkspacePixmap)
		EndIf
		
				
		'LETS ROCK
		Local TMP_Input:TStream = ReadFile(Handle.IO_InputFilePicker.GetPath())
		If Not(TMP_Input) Return ConvertError("Read error on input file!")
		Local TMP_PageCount:UInt = ToPixmapWorkspace.CalculatePages(UInt(StreamSize(TMP_Input)), TMP_EnableDithering)
		
		If(TMP_PageCount > 1)
			If(wxMessageBox("This canvas doesn't have enough space for this file! Would you like to split it into " + TMP_PageCount + " pages?", "Please confirm", wxICON_QUESTION | wxYES_NO, Handle) = wxNO)
				Handle.RefreshAll()
				Return
			EndIf
		EndIf
		
		Local TMP_Output:ToPixmapWorkspace = ConvertFileToPixmap(TMP_EnableDithering, TMP_Input, Handle.IO_InternalName.GetValue(), StripExtension(Handle.IO_OutputFilePicker.GetPath()))
		If(TMP_Output.ErrorStatus) Then Return ConvertError("Conversion error: " + TMP_Output.ErrorStatus)
		CloseFile(TMP_Input)
		
		wxMessageBox("Sucessfully exported PNGFS file!", "Completed!", wxICON_INFORMATION)
		Handle.RefreshAll()
		If(FileType(StripExtension(Handle.IO_OutputFilePicker.GetPath()) + ".png") = 1)
			WorkspacePixmap = LoadPixmap(StripExtension(Handle.IO_OutputFilePicker.GetPath()) + ".png")
		ElseIf(FileType(StripExtension(Handle.IO_OutputFilePicker.GetPath()) + "_0.png") = 1)
			WorkspacePixmap = LoadPixmap(StripExtension(Handle.IO_OutputFilePicker.GetPath()) + "_0.png")
		EndIf
		If(WorkspacePixmap)
			wxPixmap.Update()
			PNGFS_Frame.frame.SetStatusText(Handle.IO_OutputFilePicker.GetPath(), 1)
		EndIf		
	End Function
	
	rem
	Function EVT_Closed(event:wxEvent)
		If(FileType(StripExtension(Handle.IO_OutputFilePicker.GetPath()) + ".png") = 1)
			WorkspacePixmap = LoadPixmap(StripExtension(Handle.IO_OutputFilePicker.GetPath()) + ".png")
		ElseIf(FileType(StripExtension(Handle.IO_OutputFilePicker.GetPath()) + "_0.png") = 1)
			WorkspacePixmap = LoadPixmap(StripExtension(Handle.IO_OutputFilePicker.GetPath()) + "_0.png")
		EndIf
		If(WorkspacePixmap)
			wxPixmap.Update()
			PNGFS_Frame.frame.SetStatusText(Handle.IO_OutputFilePicker.GetPath(), 1)
		EndIf
		Handle.Destroy()
	End Function
	endrem
	
	Function ConvertError:Int(reason:String, title:String = "Error!", icon:Int = wxICON_ERROR)
		wxMessageBox(reason, title, wxICON_ERROR)
		Handle.RefreshAll()
	End Function
	
End Type
