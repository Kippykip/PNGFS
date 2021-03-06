SuperStrict

Framework wx.wxApp
Import wx.wxPrintout
Import wx.wxPrintData
Import wx.wxPageSetupDialogData
Import wx.wxFrame
Import wx.wxScrolledWindow
Import wx.wxPrintDialog
Import wx.wxPrinter
Import wx.wxPageSetupDialog
Import wx.wxPrintPreview
Import wx.wxPreviewFrame
?macos
Import wx.wxMacPageMarginsDialog
?

Global frame:MyFrame
Global printData:wxPrintData
Global pageSetupData:wxPageSetupDialogData

New MyApp.run()

Const WXPRINT_QUIT:Int = wxID_EXIT
Const WXPRINT_PRINT:Int = 100
Const WXPRINT_PAGE_SETUP:Int = 101
Const WXPRINT_PREVIEW:Int = 102

Const WXPRINT_ABOUT:Int = wxID_ABOUT

Const WXPRINT_ANGLEUP:Int = 103
Const WXPRINT_ANGLEDOWN:Int = 104

?macos
Const WXPRINT_PAGE_MARGINS:Int = 105
?

Type MyApp Extends wxApp

	Field testFont:wxFont

	Method OnInit:Int()

	    wxInitAllImageHandlers()
	
	    testFont = New wxFont.CreateWithAttribs(10, wxSWISS, wxNORMAL, wxNORMAL)
	
	    printData = New wxPrintData.Create()
	    ' You could set an initial paper size here
	'    printData.SetPaperId(wxPAPER_LETTER) ' For Americans
	'    printData.SetPaperId(wxPAPER_A4)    ' For everyone Else    
	
	    pageSetupData = New wxPageSetupDialogData.Create()
	
	    ' copy over initial paper size from Print record
		pageSetupData.SetPrintData(printData)

	    ' Set some initial page margins in mm. 
	    pageSetupData.SetMarginTopLeft(15, 15)
	    pageSetupData.SetMarginBottomRight(15, 15)

		frame = MyFrame(New MyFrame.Create(,,"wxWidgets Printing Demo", 0, 0, 400, 400))


		Local canvas:MyCanvas = MyCanvas.CreateMyCanvas(frame, 0, 0, 100, 100, wxHSCROLL|wxVSCROLL)
		
		' Give it scrollbars: the virtual canvas is 20 * 50 = 1000 pixels in each direction
		canvas.SetScrollbars(20, 20, 50, 50)
		
		frame.canvas = canvas

	    frame.Centre(wxBOTH)

		SetTopWindow(frame)
		
		frame.Show()
	

		Return True
	
	End Method

End Type

Type MyFrame Extends wxFrame

	Field angle:Int
	Field bitmap:wxBitmap = wxNullBitmap

	Field canvas:MyCanvas
	
	Method OnInit()

		angle = 30

		CreateStatusBar(2)

	    ' Make a menubar
	    Local file_menu:wxMenu = New wxMenu.Create()
	
	    file_menu.Append(WXPRINT_PRINT, "&Print...", "Print")
	    file_menu.Append(WXPRINT_PAGE_SETUP, "Page Set&up...", "Page setup")
	?macos
	    file_menu.Append(WXPRINT_PAGE_MARGINS, "Page Margins...", "Page margins")
	?
	    file_menu.Append(WXPRINT_PREVIEW, "Print Pre&view", "Preview")
	
	'#if wxUSE_ACCEL
	'    ' Accelerators
	'    wxAcceleratorEntry entries[1]
	'    entries[0].Set(wxACCEL_CTRL, (int) 'V', WXPRINT_PREVIEW)
	'    wxAcceleratorTable accel(1, entries)
	'    SetAcceleratorTable(accel)
	'#endif
	
	    file_menu.AppendSeparator()
	    file_menu.Append(WXPRINT_ANGLEUP, "Angle up~tAlt-U", "Raise rotated text angle")
	    file_menu.Append(WXPRINT_ANGLEDOWN, "Angle down~tAlt-D", "Lower rotated text angle")
	    file_menu.AppendSeparator()
	    file_menu.Append(WXPRINT_QUIT, "E&xit", "Exit program")
	
	    Local help_menu:wxMenu = New wxMenu.Create()
	    help_menu.Append(WXPRINT_ABOUT, "&About", "About this demo")
	
	    Local menu_bar:wxMenuBar = New wxMenuBar.Create()
	
	    menu_bar.Append(file_menu, "&File")
	    menu_bar.Append(help_menu, "&Help")
	
	    ' Associate the menu bar with the frame
	    SetMenuBar(menu_bar)
	
	    SetStatusText("Printing demo")

		Connect(WXPRINT_QUIT, wxEVT_COMMAND_MENU_SELECTED, OnExit)
		Connect(WXPRINT_PRINT, wxEVT_COMMAND_MENU_SELECTED, OnPrint)
		Connect(WXPRINT_PREVIEW, wxEVT_COMMAND_MENU_SELECTED, OnPrintPreview)
		Connect(WXPRINT_PAGE_SETUP, wxEVT_COMMAND_MENU_SELECTED, OnPageSetup)
		Connect(WXPRINT_ABOUT, wxEVT_COMMAND_MENU_SELECTED, OnPrintAbout)
		?Macos
		Connect(WXPRINT_PAGE_MARGINS, wxEVT_COMMAND_MENU_SELECTED, OnPageMargins)
		?
		Connect(WXPRINT_ANGLEUP, wxEVT_COMMAND_MENU_SELECTED, OnAngleUp)
		Connect(WXPRINT_ANGLEDOWN, wxEVT_COMMAND_MENU_SELECTED, OnAngleDown)

	End Method
	
	Function OnExit(event:wxEvent)
		frame.Close(True)
	End Function

	Function OnPrint(event:wxEvent)

		Local printDialogData:wxPrintDialogData = New wxPrintDialogData.Create(printData)
		
		Local printer:wxPrinter = New wxPrinter.Create(printDialogData)
		
		Local printout:MyPrintout = MyPrintout(New MyPrintout.Create("My printout"))
		If Not printer.Print(frame, printout, True ) Then
		    If wxPrinter.GetLastError() = wxPRINTER_ERROR Then
		        wxMessageBox("There was a problem printing.~nPerhaps your current printer is not set correctly?", "Printing", wxOK)
		    Else
		        wxMessageBox("You canceled printing", "Printing", wxOK)
			End If
		Else
		    printData = printer.GetPrintDialogData().GetPrintData()
		End If
	End Function

	Function OnPrintPreview(event:wxEvent)

		' Pass two printout objects: For preview, And possible printing.
		Local printDialogData:wxPrintDialogData = New wxPrintDialogData.Create(printData)
		Local preview:wxPrintPreview = New wxPrintPreview.Create(New MyPrintout.Create(), New MyPrintout.Create(), printData)
		If Not preview.IsOk() Then
		    preview.Free()
		    wxMessageBox("There was a problem previewing.\nPerhaps your current printer is not set correctly?", "Previewing", wxOK)
		    Return
		End If
		
		Local frame:wxPreviewFrame = New wxPreviewFrame.CreatePF(preview, frame, "Demo Print Preview", 100, 100, 600, 650)
		frame.Centre(wxBOTH)
		frame.Initialize()
		frame.Show()

	End Function

	Function OnPageSetup(event:wxEvent)

		pageSetupData.SetPrintData(printData)
		
		Local pageSetupDialog:wxPageSetupDialog = New wxPageSetupDialog.Create(frame, pageSetupData)
		pageSetupDialog.ShowModal()
		
		printData = pageSetupDialog.GetPageSetupData().GetPrintData()
		pageSetupData = pageSetupDialog.GetPageSetupData()
		
		pageSetupDialog.Free()
		
	End Function

	Function OnPrintAbout(event:wxEvent)
	End Function
	
?macos
	Function OnPageMargins(event:wxEvent)

		pageSetupData.SetPrintData(printData)
		
		Local pageMarginsDialog:wxMacPageMarginsDialog = New wxMacPageMarginsDialog.Create(frame, pageSetupData)
		pageMarginsDialog.ShowModal()
		
		printData = pageMarginsDialog.GetPageSetupDialogData().GetPrintData()
		pageSetupData = pageMarginsDialog.GetPageSetupDialogData()
		
		pageMarginsDialog.Free()
		
	End Function
?
	Function OnAngleUp(event:wxEvent)

		frame.angle:+ 5
		frame.canvas.Refresh()

	End Function

	Function OnAngleDown(event:wxEvent)

		frame.angle:- 5
		frame.canvas.Refresh()

	End Function

	Method Draw(dc:wxDC)
	
	    ' This routine just draws a bunch of random stuff on the screen so that we
	    ' can check that different types of object are being drawn consistently
	    ' between the screen image, the print preview image (at various zoom
	    ' levels), and the printed page.
	    dc.SetBackground(wxWHITE_BRUSH())
	    dc.Clear()
	    dc.SetFont(MyApp(wxGetApp()).testFont)
	
	    dc.SetBackgroundMode(wxTRANSPARENT)
	
	    dc.SetPen(wxBLACK_PEN())
	    dc.SetBrush(wxLIGHT_GREY_BRUSH())
	    dc.DrawRectangle(0, 0, 230, 350)
	    dc.DrawLine(0, 0, 229, 349)
	    dc.DrawLine(229, 0, 0, 349)
	    dc.SetBrush(wxTRANSPARENT_BRUSH())
	
	    dc.SetBrush(wxCYAN_BRUSH())
	    dc.SetPen(wxRED_PEN())
	
	    dc.DrawRoundedRectangle(0, 20, 200, 80, 20)
	
	    dc.DrawText( "Rectangle 200 by 80", 40, 40)
	
	    dc.SetPen( New wxPen.CreateFromColour(wxBLACK(), 0 , wxDOT_DASH) )
	    dc.DrawEllipse(50, 140, 100, 50)
	    dc.SetPen(wxRED_PEN())
	
	    dc.DrawText( "Test message: this is in 10 point text", 10, 180)
	    
	    Local test:String = "Hebrew    שלום -- Japanese (日本語)"
	    dc.DrawText( test, 10, 200 )
	
	    Local points:Int[] = New Int[10]
	    points[0] = 0
	    points[1] = 0
	    points[2] = 20
	    points[3] = 0
	    points[4] = 20
	    points[5] = 20
	    points[6] = 10
	    points[7] = 20
	    points[8] = 10
	    points[9] = -20
	    dc.DrawPolygon( points, 20, 250, wxODDEVEN_RULE )
	    dc.DrawPolygon( points, 50, 250, wxWINDING_RULE )
	
	    dc.DrawEllipticArc( 80, 250, 60, 30, 0.0, 270.0 )
	
	    points = New Int[8]
	    points[0] = 150
	    points[1] = 250
	    points[2] = 180
	    points[3] = 250
	    points[4] = 180
	    points[5] = 220
	    points[6] = 200
	    points[7] = 220
	    dc.DrawSpline( points )
	
	    dc.DrawArc( 20,10, 10,10, 25,40 )
	        
	    Local i:Int = 0
	    Local str:String = "---- Text at angle " + i + " ----"
	    dc.DrawRotatedText( str, 100, 300, i )
	
	    i = angle
	    str = "---- Text at angle " + i + " ----"
	    dc.DrawRotatedText( str, 100, 300, i )
	
	    'wxIcon my_icon = wxICON(mondrian) 
	
	    'dc.DrawIcon( my_icon, 100, 100)
	
	    If bitmap.IsOk() Then
	        dc.DrawBitmap( bitmap, 10, 10 )
	    End If
	End Method
	

End Type

Type MyPrintout Extends wxPrintout

	Method OnPrintPage:Int(page:Int)

   		Local dc:wxDC = GetDC()
	    If dc Then
	        If page = 1 Then
	            DrawPageOne()
	        Else If page = 2 Then
	            DrawPageTwo()
			End If
	
	        ' Draw page numbers at top Left corner of printable area, sized so that
	        ' screen size of text matches paper size.
	        MapScreenSizeToPage()
	        dc.DrawText("PAGE " + page, 0, 0)
	
	        Return True
	    Else
	        Return False
		End If

	End Method

	Method HasPage:Int(pageNum:Int)
		Return pageNum = 1 Or pageNum = 2
	End Method
	
	Method OnBeginDocument:Int(startPage:Int, endPage:Int)
		Return True
	End Method
	
	Method GetPageInfo(minPage:Int Var, maxPage:Int Var, selPageFrom:Int Var, selPageTo:Int Var)

		minPage = 1
		maxPage = 2
		selPageFrom = 1
		selPageTo = 2

	End Method
	
	Method DrawPageOne()

	    ' You might use THIS code if you were scaling graphics of known size to fit
	    ' on the page. The commented-out code illustrates different ways of scaling
	    ' the graphics.
	
	    ' We know the graphic is 230x350. If we didn't know this, we'd need to
	    ' calculate it.
	    Local maxX:Int = 230
	    Local maxY:Int = 350
	
	    ' This sets the user scale and origin of the DC so that the image fits
	    ' within the paper rectangle (but the edges could be cut off by printers
	    ' that can't print to the edges of the paper -- which is most of them. Use
	    ' this if your image already has its own margins.
	'    FitThisSizeToPaper(maxX, maxY)
	'    Local fitRect:wxRect = GetLogicalPaperRectRect()
	
	    ' This sets the user scale and origin of the DC so that the image fits
	    ' within the page rectangle, which is the printable area on Mac and MSW
	    ' and is the entire page on other platforms.
	'    FitThisSizeToPage(maxX, maxY)
	'    Local fitRect:wxRect = GetLogicalPageRectRect()
	
	    ' This sets the user scale and origin of the DC so that the image fits
	    ' within the page margins as specified by g_PageSetupData, which you can
	    ' change (on some platforms, at least) in the Page Setup dialog. Note that
	    ' on Mac, the native Page Setup dialog doesn't let you change the margins
	    ' of a wxPageSetupDialogData object, so you'll have to write your own dialog or
	    ' use the Mac-only wxMacPageMarginsDialog, as we do in this program.
	    FitThisSizeToPageMargins(maxX, maxY, pageSetupData)
	    Local fitRect:wxRect = GetLogicalPageMarginsRectRect(pageSetupData)
	
	    ' This sets the user scale and origin of the DC so that the image appears
	    ' on the paper at the same size that it appears on screen (i.e., 10-point
	    ' type on screen is 10-point on the printed page) and is positioned in the
	    ' top left corner of the page rectangle (just as the screen image appears
	    ' in the top left corner of the window).
	'    MapScreenSizeToPage()
	'    Local fitRect:wxRect = GetLogicalPageRectRect()
	
	    ' You could also map the screen image to the entire paper at the same size
	    ' as it appears on screen.
	'    MapScreenSizeToPaper()
	'    Local fitRect:wxRect = GetLogicalPaperRectRect()
	
	    ' You might also wish to do you own scaling in order to draw objects at
	    ' full native device resolution. In this case, you should do the following.
	    ' Note that you can use the GetLogicalXXXRect() commands to obtain the
	    ' appropriate rect to scale to.
	'    MapScreenSizeToDevice()
	'    Local fitRect:wxRect = GetLogicalPageRectRect()
	
	    ' Each of the preceding Fit or Map routines positions the origin so that
	    ' the drawn image is positioned at the top left corner of the reference
	    ' rectangle. You can easily center or right- or bottom-justify the image as
	    ' follows.
	
	    ' This offsets the image so that it is centered within the reference
	    ' rectangle defined above.
	    Local xoff:Int = (fitRect.GetWidth() - maxX) / 2
	    Local yoff:Int = (fitRect.GetHeight() - maxY) / 2
	    OffsetLogicalOrigin(xoff, yoff)
	
	    ' This offsets the image so that it is positioned at the bottom right of
	    ' the reference rectangle defined above.
	'    Local xoff:Int = (fitRect.width - maxX)
	'    Local yoff:Int = (fitRect.height - maxY)
	'    OffsetLogicalOrigin(xoff, yoff)
	
	    frame.Draw(GetDC())
	
	End Method
	
	Method DrawPageTwo()
	End Method

End Type

Type MyCanvas Extends wxScrolledWindow

	Function CreateMyCanvas:MyCanvas(parent:wxWindow, x:Int, y:Int, w:Int, h:Int, style:Int)
		Return MyCanvas(New MyCanvas.Create(parent, wxID_ANY, x, y, w, h, style))
	End Function
	
	Method OnInit()

		SetBackgroundColour(wxWHITE())

	End Method

	Method OnDraw(dc:wxDC)
		frame.Draw(dc)
	End Method
	
End Type
