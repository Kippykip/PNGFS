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

MaxLEDPanel::MaxLEDPanel(BBObject * handle, wxWindow * parent, wxWindowID id, int pointW, int pointH,
		int fieldW, int fieldH, int padding, int x, int y, long style)
	: wxLEDPanel(parent, id, wxSize(pointW, pointH), wxSize(fieldW, fieldH), padding, wxPoint(x, y), style)
{
	wxbind(this, handle);
}

MaxLEDPanel::~MaxLEDPanel() {
	wxunbind(this);
}

// *********************************************

BEGIN_EVENT_TABLE(MaxLEDPanel, wxLEDPanel)
END_EVENT_TABLE()

wxLEDPanel * bmx_wxledpanel_create(BBObject * handle, wxWindow* parent, wxWindowID id, int pointW, int pointH,
		int fieldW, int fieldH, int padding, int x, int y, int style) {
	return new MaxLEDPanel(handle, parent, id, pointW, pointH, fieldW, fieldH, padding, x, y, style);
}

void bmx_wxledpanel_clear(wxLEDPanel * panel) {
	panel->Clear();
}

void bmx_wxledpanel_reset(wxLEDPanel * panel) {
	panel->Reset();
}

void bmx_wxledpanel_getfieldsize(wxLEDPanel * panel, int * w, int * h) {
	wxSize s = panel->GetFieldsize();
	*w = s.x;
	*h = s.y;
}

void bmx_wxledpanel_getpointsize(wxLEDPanel * panel, int * w, int * h) {
	wxSize s = panel->GetPointsize();
	*w = s.x;
	*h = s.y;
}

void bmx_wxledpanel_setledcolour(wxLEDPanel * panel, int colourID) {
	panel->SetLEDColour(static_cast<wxLEDColour>(colourID));
}

MaxColour * bmx_wxledpanel_getledcolour(wxLEDPanel * panel) {
	wxColour c(panel->GetLEDColour());
	return new MaxColour(c);
}

void bmx_wxledpanel_setscrollspeed(wxLEDPanel * panel, int speed) {
	panel->SetScrollSpeed(speed);
}

int bmx_wxledpanel_getscrollspeed(wxLEDPanel * panel) {
	return panel->GetScrollSpeed();
}

void bmx_wxledpanel_setscrolldirection(wxLEDPanel * panel, int direction) {
	panel->SetScrollDirection(static_cast<wxLEDScrollDirection>(direction));
}

int bmx_wxledpanel_getscrolldirection(wxLEDPanel * panel) {
	return static_cast<int>(panel->GetScrollDirection());
}

void bmx_wxledpanel_showinverted(wxLEDPanel * panel, int invert) {
	panel->ShowInvertet(static_cast<bool>(invert));
}

void bmx_wxledpanel_showinactiveleds(wxLEDPanel * panel, int showInactives) {
	panel->ShowInactivLEDs(static_cast<bool>(showInactives));
}

void bmx_wxledpanel_settextalign(wxLEDPanel * panel, int align) {
	panel->SetTextAlign(align);
}

int bmx_wxledpanel_gettextalign(wxLEDPanel * panel) {
	return panel->GetTextAlign();
}

void bmx_wxledpanel_settext(wxLEDPanel * panel, BBString * text, int align) {
	panel->SetText(wxStringFromBBString(text), align);
}

BBString * bmx_wxledpanel_gettext(wxLEDPanel * panel) {
	return bbStringFromWxString(panel->GetText());
}

void bmx_wxledpanel_settextpaddingleft(wxLEDPanel * panel, int padLeft) {
	panel->SetTextPaddingLeft(padLeft);
}

void bmx_wxledpanel_settextpaddingright(wxLEDPanel * panel, int padRight) {
	panel->SetTextPaddingRight(padRight);
}

int bmx_wxledpanel_gettextpaddingleft(wxLEDPanel * panel) {
	return panel->GetTextPaddingLeft();
}

int bmx_wxledpanel_gettextpaddingright(wxLEDPanel * panel) {
	return panel->GetTextPaddingRight();
}

void bmx_wxledpanel_setletterspace(wxLEDPanel * panel, int letterSpace) {
	panel->SetLetterSpace(letterSpace);
}

int bmx_wxledpanel_getletterspace(wxLEDPanel * panel) {
	return panel->GetLetterSpace();
}

void bmx_wxledpanel_setfonttypewide(wxLEDPanel * panel) {
	panel->SetFontTypeWide();
}

void bmx_wxledpanel_setfonttypesmall(wxLEDPanel * panel) {
	panel->SetFontTypeSmall();
}

int bmx_wxledpanel_isfonttypesmall(wxLEDPanel * panel) {
	return static_cast<int>(panel->IsFontTypeSmall());
}
