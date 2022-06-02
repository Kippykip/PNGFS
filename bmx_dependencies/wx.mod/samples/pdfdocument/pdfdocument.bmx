SuperStrict

Framework wx.wxApp
Import wx.wxFrame

Import "tutorial1.bmx"
Import "tutorial2.bmx"
Import "tutorial3.bmx"
Import "tutorial4.bmx"
Import "xmlwrite.bmx"
Import "transparency.bmx"
Import "transformation.bmx"
Import "bookmark.bmx"
Import "templates.bmx"
Import "barcodes.bmx"
Import "clipping.bmx"
Import "drawing.bmx"

New MyApp.run()


Type MyApp Extends wxApp

	

	Method OnInit:Int()
	
		wxImage.AddHandler(New wxPNGHandler)

		tutorial1()
		tutorial2()
		tutorial3()
		tutorial4()
		
		bookmark()
		clipping()
		drawing()
		xmlwrite()
		transparency()
		transformation()
		templates1()
		templates2()
		
		barcodes()
		
		Return False
	
	End Method

End Type
