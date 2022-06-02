SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local txt:Text = Text(New Text.Create(Null, wxID_ANY, ..
			"Text", -1, -1, 250, 150))
		txt.Show(True)
 
		Return True
	End Method

End Type

Type Text Extends wxFrame
 
	Method OnInit:Int()
		
		ConnectAny(wxEVT_PAINT, OnPaint)
		Centre()
 
	End Method
	
	Function OnPaint(event:wxEvent)

		Local dc:wxPaintDC = New wxPaintDC.Create(wxWindow(event.parent))
		
		dc.DrawText("Лев Николaевич Толстoй", 40, 60)
		dc.DrawText("Анна Каренина", 70, 80)
	
		dc.Free()
	End Function
	
End Type


