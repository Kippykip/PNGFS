SuperStrict

Import wx.wxPdfDocument

' Minimal example
'
' The wxPdfDocument constructor is used here with the default values:
' pages are in A4 portrait and the measure unit is millimeter.
'
' It would be possible to use landscape, other page formats (such as Letter and Legal)
' and measure units (pt, cm, in). 
' 
' There is no page for the moment, so we have to add one with AddPage(). The origin is
' at the upper-left corner and the current position is by default placed at 1 cm from
' the borders; the margins can be changed with SetMargins(). 
'
' Before we can print text, it is mandatory to select a font with SetFont(), otherwise
' the document would be invalid. We choose Arial bold 16.
'
' We could have specified italics with I, underlined with U or a regular font with an
' empty string (or any combination). Note that the font size is given in points, not
' millimeters (or another user unit); it is the only exception. The other standard fonts
' are Times, Courier, Symbol and ZapfDingbats. 

' We can now print a cell with Cell(). A cell is a rectangular area, possibly framed,
' which contains some text. It is output at the current position. We specify its dimensions,
' its text (centered or aligned), if borders should be drawn, and where the current position
' moves after it (to the right, below or to the beginning of the next line).
' 
' To add a new cell next to it with centered text and go to the next line, we would do: 
' 
' pdf.Cell(60 ,10, "Powered by wxPdfDocument", wxPDF_BORDER_NONE, 1, wxPDF_ALIGN_CENTER)
' 
' Remark : the line break can also be done with Ln(). This method allows to specify in
' addition the height of the break. 
' 
' Finally, the document is closed and sent to file with SaveAsFile().
'
Function tutorial1()
  Local pdf:wxPdfDocument = New wxPdfDocument.Create()
  pdf.AddPage()
  pdf.SetFont("Arial", "B", 16)
  pdf.Cell(40, 10, "Hello World!")
  pdf.SaveAsFile("tutorial1.pdf")
End Function

