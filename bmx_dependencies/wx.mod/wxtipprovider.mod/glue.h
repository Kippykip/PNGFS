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
#include "wx/tipdlg.h"

class MaxTipProvider;

extern "C" {

#include <blitz.h>

	BBString * CB_PREF(wx_wxtipprovider_wxTipProvider__PreProcessTip)(BBObject * handle, BBString * tip);
	BBString * CB_PREF(wx_wxtipprovider_wxTipProvider__GetTip)(BBObject * handle);

	wxTipProvider * bmx_wxtipprovider_create(BBObject * handle, int currentTip);
	int bmx_wxtipprovider_getcurrenttip(wxTipProvider * tip);
	void bmx_wxtipprovider_free(wxTipProvider * tip);
	wxTipProvider * bmx_wxcreatefiletipprovider(BBString * filename, int currentTip);
	int bmx_wxshowtip(wxWindow * parent, wxTipProvider * tip, int showAtStartup);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxTipProvider : public wxTipProvider
{
public:
	MaxTipProvider(BBObject * handle, int currentTip);
	~MaxTipProvider();
	wxString GetTip();
	wxString PreProcessTip(const wxString & tip);
	
private:
	BBObject * maxHandle;
};

