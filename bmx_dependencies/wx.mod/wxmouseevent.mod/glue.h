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

extern "C" {

#include <blitz.h>

	int bmx_wxmouseevent_altdown(wxMouseEvent & event);
	int bmx_wxmouseevent_button(wxMouseEvent & event, int but);
	int bmx_wxmouseevent_buttondclick(wxMouseEvent & event, int but);
	int bmx_wxmouseevent_buttondown(wxMouseEvent & event, int but);
	int bmx_wxmouseevent_buttonup(wxMouseEvent & event, int but);
	int bmx_wxmouseevent_cmddown(wxMouseEvent & event);
	int bmx_wxmouseevent_controldown(wxMouseEvent & event);
	int bmx_wxmouseevent_dragging(wxMouseEvent & event);
	int bmx_wxmouseevent_entering(wxMouseEvent & event);
	int bmx_wxmouseevent_getbutton(wxMouseEvent & event);
	void bmx_wxmouseevent_getposition(wxMouseEvent & event, int * x, int * y);
	int bmx_wxmouseevent_getlinesperaction(wxMouseEvent & event);
	int bmx_wxmouseevent_getwheelrotation(wxMouseEvent & event);
	int bmx_wxmouseevent_getwheeldelta(wxMouseEvent & event);
	int bmx_wxmouseevent_getx(wxMouseEvent & event);
	int bmx_wxmouseevent_gety(wxMouseEvent & event);
	int bmx_wxmouseevent_isbutton(wxMouseEvent & event);
	int bmx_wxmouseevent_ispagescroll(wxMouseEvent & event);
	int bmx_wxmouseevent_leaving(wxMouseEvent & event);
	int bmx_wxmouseevent_leftdclick(wxMouseEvent & event);
	int bmx_wxmouseevent_leftdown(wxMouseEvent & event);
	int bmx_wxmouseevent_leftisdown(wxMouseEvent & event);
	int bmx_wxmouseevent_leftup(wxMouseEvent & event);
	int bmx_wxmouseevent_metadown(wxMouseEvent & event);
	int bmx_wxmouseevent_middledclick(wxMouseEvent & event);
	int bmx_wxmouseevent_middledown(wxMouseEvent & event);
	int bmx_wxmouseevent_middleisdown(wxMouseEvent & event);
	int bmx_wxmouseevent_middleup(wxMouseEvent & event);
	int bmx_wxmouseevent_moving(wxMouseEvent & event);
	int bmx_wxmouseevent_rightdclick(wxMouseEvent & event);
	int bmx_wxmouseevent_rightdown(wxMouseEvent & event);
	int bmx_wxmouseevent_rightisdown(wxMouseEvent & event);
	int bmx_wxmouseevent_rightup(wxMouseEvent & event);
	int bmx_wxmouseevent_shiftdown(wxMouseEvent & event);
	void bmx_wxmouseevent_getlogicalposition(wxMouseEvent & event, MaxDC * dc, int * x, int * y);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

