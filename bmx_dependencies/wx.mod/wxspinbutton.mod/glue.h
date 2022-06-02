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
#include "wx/spinbutt.h"
#include "wx/xrc/xh_spin.h"
#include "wx/xml/xml.h"

class MaxSpinButton;

extern "C" {

#include <blitz.h>

	BBObject * CB_PREF(wx_wxspinbutton_wxSpinButton__xrcNew)(wxSpinButton * button);

	MaxSpinButton * bmx_wxspinbutton_create(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, int style);
	int bmx_wxspinbutton_getmax(wxSpinButton * button);
	int bmx_wxspinbutton_getmin(wxSpinButton * button);
	int bmx_wxspinbutton_getvalue(wxSpinButton * button);
	void bmx_wxspinbutton_setrange(wxSpinButton * button, int minValue, int maxValue);
	void bmx_wxspinbutton_setvalue(wxSpinButton * button, int value);

	int bmx_wxspinevent_getposition(wxSpinEvent & event);
	void bmx_wxspinevent_setposition(wxSpinEvent & event, int pos);

	int bmx_wxspinbutton_geteventtype(int type);
	
	void bmx_wxspinbutton_addresourcehandler();
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxSpinButton: public wxSpinButton
{
public:
	MaxSpinButton(BBObject * handle, wxWindow* parent, wxWindowID id, int x, int y, int w, int h, long style);
	MaxSpinButton();
	~MaxSpinButton();

	void MaxBind(BBObject * handle);

private:
    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxSpinButtonXmlHandler : public wxSpinButtonXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxSpinButtonXmlHandler)

public:
    MaxSpinButtonXmlHandler();
    virtual wxObject *DoCreateResource();
};

