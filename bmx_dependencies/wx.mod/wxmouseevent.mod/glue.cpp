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

int bmx_wxmouseevent_altdown(wxMouseEvent & event) {
	return static_cast<int>(event.AltDown());
}

int bmx_wxmouseevent_button(wxMouseEvent & event, int but) {
	return static_cast<int>(event.Button(but));
}

int bmx_wxmouseevent_buttondclick(wxMouseEvent & event, int but) {
	return static_cast<int>(event.ButtonDClick(but));
}

int bmx_wxmouseevent_buttondown(wxMouseEvent & event, int but) {
	return static_cast<int>(event.ButtonDown(but));
}

int bmx_wxmouseevent_buttonup(wxMouseEvent & event, int but) {
	return static_cast<int>(event.ButtonUp(but));
}

int bmx_wxmouseevent_cmddown(wxMouseEvent & event) {
	return static_cast<int>(event.CmdDown());
}

int bmx_wxmouseevent_controldown(wxMouseEvent & event) {
	return static_cast<int>(event.ControlDown());
}

int bmx_wxmouseevent_dragging(wxMouseEvent & event) {
	return static_cast<int>(event.Dragging());
}

int bmx_wxmouseevent_entering(wxMouseEvent & event) {
	return static_cast<int>(event.Entering());
}

int bmx_wxmouseevent_getbutton(wxMouseEvent & event) {
	return event.GetButton();
}

void bmx_wxmouseevent_getposition(wxMouseEvent & event, int * x, int * y) {
	long _x, _y;
	event.GetPosition(&_x, &_y);
	*x = _x;
	*y = _y;
}

int bmx_wxmouseevent_getlinesperaction(wxMouseEvent & event) {
	return event.GetLinesPerAction();
}

int bmx_wxmouseevent_getwheelrotation(wxMouseEvent & event) {
	return event.GetWheelRotation();
}

int bmx_wxmouseevent_getwheeldelta(wxMouseEvent & event) {
	return event.GetWheelDelta();
}

int bmx_wxmouseevent_getx(wxMouseEvent & event) {
	return event.GetX();
}

int bmx_wxmouseevent_gety(wxMouseEvent & event) {
	return event.GetY();
}

int bmx_wxmouseevent_isbutton(wxMouseEvent & event) {
	return static_cast<int>(event.IsButton());
}

int bmx_wxmouseevent_ispagescroll(wxMouseEvent & event) {
	return static_cast<int>(event.IsPageScroll());
}

int bmx_wxmouseevent_leaving(wxMouseEvent & event) {
	return static_cast<int>(event.Leaving());
}

int bmx_wxmouseevent_leftdclick(wxMouseEvent & event) {
	return static_cast<int>(event.LeftDClick());
}

int bmx_wxmouseevent_leftdown(wxMouseEvent & event) {
	return static_cast<int>(event.LeftDown());
}

int bmx_wxmouseevent_leftisdown(wxMouseEvent & event) {
	return static_cast<int>(event.LeftIsDown());
}

int bmx_wxmouseevent_leftup(wxMouseEvent & event) {
	return static_cast<int>(event.LeftUp());
}

int bmx_wxmouseevent_metadown(wxMouseEvent & event) {
	return static_cast<int>(event.MetaDown());
}

int bmx_wxmouseevent_middledclick(wxMouseEvent & event) {
	return static_cast<int>(event.MiddleDClick());
}

int bmx_wxmouseevent_middledown(wxMouseEvent & event) {
	return static_cast<int>(event.MiddleDown());
}

int bmx_wxmouseevent_middleisdown(wxMouseEvent & event) {
	return static_cast<int>(event.MiddleIsDown());
}

int bmx_wxmouseevent_middleup(wxMouseEvent & event) {
	return static_cast<int>(event.MiddleUp());
}

int bmx_wxmouseevent_moving(wxMouseEvent & event) {
	return static_cast<int>(event.Moving());
}

int bmx_wxmouseevent_rightdclick(wxMouseEvent & event) {
	return static_cast<int>(event.RightDClick());
}

int bmx_wxmouseevent_rightdown(wxMouseEvent & event) {
	return static_cast<int>(event.RightDown());
}

int bmx_wxmouseevent_rightisdown(wxMouseEvent & event) {
	return static_cast<int>(event.RightIsDown());
}

int bmx_wxmouseevent_rightup(wxMouseEvent & event) {
	return static_cast<int>(event.RightUp());
}

int bmx_wxmouseevent_shiftdown(wxMouseEvent & event) {
	return static_cast<int>(event.ShiftDown());
}

void bmx_wxmouseevent_getlogicalposition(wxMouseEvent & event, MaxDC * dc, int * x, int * y) {
	wxPoint p(event.GetLogicalPosition(*dc->GetDC()));
	*x = p.x;
	*y = p.y;
}


// *********************************************


