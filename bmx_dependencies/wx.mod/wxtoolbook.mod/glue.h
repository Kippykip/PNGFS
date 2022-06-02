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

#ifndef _WX_MAX_TOOLBOOK_H_
#define _WX_MAX_TOOLBOOK_H_

#include "wxglue.h"
#include "wx/toolbook.h"
#include "wx/xrc/xh_toolbk.h"
#include "wx/xml/xml.h"

class MaxToolbook;

extern "C" {

#include <blitz.h>

	BBObject * CB_PREF(wx_wxtoolbook_wxToolbook__xrcNew)(wxToolbook * toolbook);

	MaxToolbook * bmx_wxtoolbook_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, int style);
	wxToolBarBase * bmx_wxtoolbook_gettoolbar(wxToolbook * book);
	void bmx_wxtoolbook_realize(wxToolbook * book);

	void bmx_wxtoolbook_addresourcehandler();
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxToolbook : public wxToolbook
{
public:
	MaxToolbook();
	MaxToolbook(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	~MaxToolbook();

	void MaxBind(BBObject * handle);
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxToolbookXmlHandler : public wxToolbookXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxToolbookXmlHandler)

public:
    MaxToolbookXmlHandler();
    virtual wxObject *DoCreateResource();
	bool CanHandle(wxXmlNode *node);
	
    bool m_isInside;
    wxToolbook *m_toolbook;
};

#endif
