/*
  Copyright (c) 2007-2018 Bruce A Henderson
 
  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:
  
  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.
  
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
*/ 

#include "wxglue.h"
#include "wx/msgdlg.h"

class MaxMessageDialog;

extern "C" {

#include <blitz.h>

	MaxMessageDialog * bmx_wxmessagedialog_create(BBObject * handle, wxWindow * parent, BBString * message,
			BBString * caption, int style, int x, int y);
	int bmx_wxmessagedialog_showmodal(wxMessageDialog * dialog);
	void bmx_wxmessagedialog_setextendedmessage(wxMessageDialog * dialog, BBString * message);
	int bmx_wxmessagedialog_sethelplabeltext(wxMessageDialog * dialog, BBString * text);
	int bmx_wxmessagedialog_sethelplabelid(wxMessageDialog * dialog, int id);
	void bmx_wxmessagedialog_setmessage(wxMessageDialog * dialog, BBString * message);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxMessageDialog : public wxMessageDialog
{
public:
	MaxMessageDialog(BBObject * handle, wxWindow * parent, const wxString& message, const wxString& caption, long style, int x, int y);
	~MaxMessageDialog();
	
};
