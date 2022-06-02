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
#include "wx/osx/printdlg.h"
#include "../wxpagesetupdialogdata.mod/glue.h"

class MaxMacPageMarginsDialog;

extern "C" {

#include <blitz.h>

	wxMacPageMarginsDialog * bmx_wxmacpagemarginsdialog_create(BBObject * handle, wxFrame * parent, MaxPageSetupDialogData * data);
	int bmx_wxmacpagemarginsdialog_transfertowindow(wxMacPageMarginsDialog * dialog);
	int bmx_wxmacpagemarginsdialog_transferdatafromwindow(wxMacPageMarginsDialog * dialog);
	MaxPageSetupDialogData * bmx_wxmacpagemarginsdialog_getpagesetupdialogdata(wxMacPageMarginsDialog * dialog);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxMacPageMarginsDialog : public wxMacPageMarginsDialog
{
public:
	MaxMacPageMarginsDialog(BBObject * handle, wxFrame * parent, wxPageSetupData* data);
	~MaxMacPageMarginsDialog();
};
