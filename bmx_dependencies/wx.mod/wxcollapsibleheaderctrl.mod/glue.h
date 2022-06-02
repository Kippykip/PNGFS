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
#include "wx/collheaderctrl.h"

class MaxCollapsibleHeaderCtrl;

extern "C" {

#include <blitz.h>

	wxCollapsibleHeaderCtrl * bmx_wxcollapsibleheaderctrl_create(BBObject * handle, wxWindow * parent, int id, BBString * label, int x, int y, int w, int h, int style);
	void bmx_wxcollapsibleheaderctrl_setcollapsed(wxCollapsibleHeaderCtrl * ctrl, int collapsed);
	int bmx_wxcollapsibleheaderctrl_iscollapsed(wxCollapsibleHeaderCtrl * ctrl);

	int bmx_wxcollapsibleheaderctrl_geteventtype(int evt);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxCollapsibleHeaderCtrl : public wxCollapsibleHeaderCtrl
{
public:
	MaxCollapsibleHeaderCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString &label, int x, int y, int w, int h, long style);
	MaxCollapsibleHeaderCtrl();
	~MaxCollapsibleHeaderCtrl();

	void MaxBind(BBObject * handle);
private:
    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

