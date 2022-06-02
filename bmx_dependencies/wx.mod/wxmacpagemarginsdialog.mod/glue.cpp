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

#include "glue.h"

// ---------------------------------------------------------------------------------------

MaxMacPageMarginsDialog::MaxMacPageMarginsDialog(BBObject * handle, wxFrame * parent, wxPageSetupDialogData* data)
	: wxMacPageMarginsDialog(parent, data)
{
	wxbind(this, handle);
}

MaxMacPageMarginsDialog::~MaxMacPageMarginsDialog() {
	wxunbind(this);
}


// *********************************************

wxMacPageMarginsDialog * bmx_wxmacpagemarginsdialog_create(BBObject * handle, wxFrame * parent, MaxPageSetupDialogData * data) {
	if (data) {
		return new MaxMacPageMarginsDialog(handle, parent, &data->Data());
	} else {
		return new MaxMacPageMarginsDialog(handle, parent, NULL);
	}
}

int bmx_wxmacpagemarginsdialog_transfertowindow(wxMacPageMarginsDialog * dialog) {
	return static_cast<int>(dialog->TransferToWindow());
}

int bmx_wxmacpagemarginsdialog_transferdatafromwindow(wxMacPageMarginsDialog * dialog) {
	return static_cast<int>(dialog->TransferDataFromWindow());
}

MaxPageSetupDialogData * bmx_wxmacpagemarginsdialog_getpagesetupdialogdata(wxMacPageMarginsDialog * dialog) {
	return new MaxPageSetupDialogData(dialog->GetPageSetupDialogData());
}


