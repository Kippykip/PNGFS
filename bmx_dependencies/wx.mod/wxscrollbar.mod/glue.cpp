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

MaxScrollBar::MaxScrollBar(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style)
	: wxScrollBar(parent, id, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxScrollBar::MaxScrollBar()
{}

MaxScrollBar::~MaxScrollBar() {
	wxunbind(this);
}

void MaxScrollBar::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxScrollBarXmlHandler, wxScrollBarXmlHandler)

MaxScrollBarXmlHandler::MaxScrollBarXmlHandler()
	: wxScrollBarXmlHandler()
{}


wxObject * MaxScrollBarXmlHandler::DoCreateResource()
{
    XRC_MAKE_INSTANCE(control, MaxScrollBar)

    control->Create(m_parentAsWindow,
                    GetID(),
                    GetPosition(), GetSize(),
                    GetStyle(),
                    wxDefaultValidator,
                    GetName());

    control->SetScrollbar(GetLong( wxT("value"), 0),
                          GetLong( wxT("thumbsize"),1),
                          GetLong( wxT("range"), 10),
                          GetLong( wxT("pagesize"),1));

	control->MaxBind(CB_PREF(wx_wxscrollbar_wxScrollBar__xrcNew)(control));

    SetupWindow(control);
    CreateChildren(control);

    return control;
}


// *********************************************


MaxScrollBar * bmx_wxscrollbar_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, int style) {
	return new MaxScrollBar(maxHandle, parent, id, x, y, w, h, style);
}

int bmx_wxscrollbar_getrange(wxScrollBar * scrollbar) {
	return scrollbar->GetRange();
}

int bmx_wxscrollbar_getpagesize(wxScrollBar * scrollbar) {
	return scrollbar->GetPageSize();
}

int bmx_wxscrollbar_getthumbposition(wxScrollBar * scrollbar) {
	return scrollbar->GetThumbPosition();
}

int bmx_wxscrollbar_getthumbsize(wxScrollBar * scrollbar) {
	return scrollbar->GetThumbSize();
}

void bmx_wxscrollbar_setthumbposition(wxScrollBar * scrollbar, int viewStart) {
	scrollbar->SetThumbPosition(viewStart);
}

void bmx_wxscrollbar_setscrollbar(wxScrollBar * scrollbar, int position, int thumbSize, int range, int pageSize, int refresh) {
	scrollbar->SetScrollbar(position, thumbSize, range, pageSize, refresh);
}

// *********************************************

void bmx_wxscrollbar_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxScrollBarXmlHandler);
}

